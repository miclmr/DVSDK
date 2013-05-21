/* 
 * Copyright (c) 2010, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 */
/*
 *  ======== Processor_dsplink.c ========
 */
#include <xdc/std.h>

#include <ti/sdo/ce/osal/File.h>
#include <ti/sdo/ce/osal/Memory.h>
#include <ti/sdo/ce/osal/Global.h>
#include <ti/sdo/ce/osal/Thread.h>
#include <ti/sdo/ce/osal/Lock.h>
#include <ti/sdo/ce/osal/Sem.h>
#include <ti/sdo/ce/ipc/Power.h>
#include <ti/sdo/utils/trace/gt.h>

#ifdef WIN32
#include <ti/sdo/winceutils/cmem/cmem.h>
#else
#include <ti/sdo/linuxutils/cmem/include/cmem.h>
#endif

#include <ti/sdo/ce/ipc/Processor.h>

/*  ----------------------------------- DSP/BIOS Link                   */
#include <ti/sdo/ce/ipc/dsplink/_adapted_link_gpptypes.h>
#include <dsplink.h>
#include <errbase.h>
#include <msgqdefs.h>

/*  ----------------------------------- DSP/BIOS LINK API               */
#include <proc.h>
#include <msgq.h>
#include <pool.h>

#include <string.h>

#include <ti/dsplink/utils/ladclient/ladclient.h>

#define KEY      0x434F5250 /* "CORP" */
#define CMDKEY   KEY
#define REPLYKEY KEY + 1

extern Int Global_useLinkArbiter;
static LAD_ClientHandle handle;
static LAD_Status ladStatus;

/*
 *  ======== Processor_Obj ========
 */
typedef struct Processor_Obj {
    Int               cpuId;
    String            imageName;
    String            linkConfigName;
    Bool              loaded;
    Processor_Attrs   attrs;
    Power_Handle      powerHandle;
    Bool              connected;
} Processor_Obj;

/*
 *  ======== Processor_ATTRS ========
 */
Processor_Attrs Processor_ATTRS = {
    "dsp0",     /* cpu ID */
    0,          /* argc */
    NULL,       /* argv */
};

#define NONE    0
#define CREATE  1
#define DELETE  2
#define EXIT    3

#define SUCCESS 1
#define FAILURE 2

/*
 *  ======== CmdObj ========
 */
typedef struct CmdObj {
    Thread_Handle     dproc;
    Processor_Handle  proc;
    Int               cmdId;
    Int               reply;

    Sem_Handle        cmdPresent;
    Sem_Handle        replyPresent;
    Lock_Handle       gate;
} CmdObj;

/* REMINDER: if you add an initialized static var, reinitialize it at cleanup */
static Bool curInit = FALSE;

static CmdObj dcmd = {NULL, NULL, NONE, NONE, NULL, NULL, NULL};

static GT_Mask curTrace;

/* generated by Global.xdt */
extern SmaPoolAttrs Global_cePoolAttrs;
extern Int          Global_cePoolId;

/* our core Link config object is defined in Processor_dsplink_linkcfg.c */
extern LINKCFG_Object  ti_sdo_ce_ipc_Processor_linkcfg;

/* generated by ti.sdo.ce.ipc.dsplink/Ipc.xdt
 *
 * This table of tables describes how certain entries in the
 * LINKCFG_Object above have to be modified for each server.
 */
extern Global_ArmDspLinkConfig *ti_sdo_ce_ipc_armDspLinkConfigs[];

/* generated by ti.sdo.ce.ipc.dsplink/Ipc.xdt
 *
 * and we find the table in the server by matching it with the server name
 * from this NULL-terminated list:
 */
extern String ti_sdo_ce_ipc_armDspLinkConfigServerNames[];

static Void cleanup(Void);
static Int daemon(Void);
static Int doCmd(Int cmdId, Processor_Handle proc);
static Int getCmd(Processor_Handle *proc);
static Void modifyDefaultLinkCfgObjectForCENeeds();
static Void modifyDefaultLinkCfgObjectBasedOnUserCfgData();
static Bool procCreate(Processor_Handle proc);
static Void procDelete(Processor_Handle proc);
static Void putReply(Int status);


/*
 *  ======== Processor_create ========
 */
Processor_Handle Processor_create(String imageName, String linkCfg,
    Processor_Attrs *attrs)
{
    Processor_Handle proc = NULL;
    File_Stat statBuf;

    GT_assert(curTrace, curInit == TRUE);

    GT_3trace(curTrace, GT_ENTER, "Processor_create> "
        "Enter(imageName='%s', linkCfg='%s', attrs=0x%x)\n", imageName,
        linkCfg, attrs);

    if (attrs == NULL) {
        attrs = &Processor_ATTRS;
    }

    if ((!Global_useLinkArbiter) &&
            (File_stat(imageName, &statBuf) != File_EOK)) {
        GT_1trace(curTrace, GT_7CLASS, "Processor_create> "
            "ERROR: cannot access file %s\n", imageName);
        return (NULL);
    }

    if ((proc = Memory_alloc(sizeof(Processor_Obj), NULL)) == NULL) {
        GT_0trace(curTrace, GT_7CLASS, "Processor_create> "
            "ERROR: Memory_alloc failed\n");
        return (NULL);
    }

    proc->attrs = *attrs;
    proc->imageName = imageName;
    proc->linkConfigName = linkCfg;
    proc->loaded = FALSE;
    proc->powerHandle = NULL;
    proc->connected = FALSE;

    if (doCmd(CREATE, proc) != SUCCESS) {
        Processor_delete(proc);
        return (NULL);
    }
    proc->loaded = TRUE;

    GT_1trace(curTrace, GT_ENTER, "Processor_create> return (0x%x)\n", proc);

    return (proc);
}


/*
 *  ======== Processor_delete ========
 */
Void Processor_delete(Processor_Handle proc)
{
    GT_assert(curTrace, curInit == TRUE);

    GT_1trace(curTrace, GT_ENTER, "Processor_delete> Enter(proc=0x%x)\n", proc);

    if (proc != NULL) {
        if (proc->loaded == TRUE && dcmd.dproc != NULL) {
            doCmd(DELETE, proc);
        }

        GT_1trace(curTrace, GT_1CLASS,
            "Processor_delete(0x%x) freeing object ...\n", proc);
        Memory_free(proc, sizeof(Processor_Obj), NULL);
    }

    GT_0trace(curTrace, GT_ENTER, "Processor_delete> return.\n");
}


/*
 *  ======== Processor_init ========
 */
Void Processor_init(Void)
{
    if (curInit != TRUE) {
        curInit = TRUE;

        GT_create(&curTrace, Processor_GTNAME);

        /* Semaphore with count 0, will be posted when a command is present */
        dcmd.cmdPresent = Sem_create(CMDKEY, 0);

        /* Semaphore with count 0, will be posted when reply is ready */
        dcmd.replyPresent = Sem_create(REPLYKEY, 0);

        /*
         *  Create lock to allow only one thread at a time to send command
         *  to the daemon.
         */
        dcmd.gate = Lock_create(NULL);

        if ((dcmd.cmdPresent == NULL) || (dcmd.replyPresent == NULL) ||
                (dcmd.gate == NULL)) {
            // TODO: Shouldn't we abort?
            GT_0trace(curTrace, GT_7CLASS, "Processor_init> ERROR: cannot"
                " create semaphores or lock\n");
        }

        if ((dcmd.dproc = Thread_create((Fxn)daemon, NULL)) == NULL) {
            GT_0trace(curTrace, GT_7CLASS, "Processor_init> "
                "ERROR: cannot create DSP daemon\n");
        }

        Power_init();

        Global_atexit((Fxn)cleanup);
    }
}

/*
 *  ======== Processor_wait ========
 */
Int Processor_wait(Processor_Handle proc)
{
    return (-1);
}

/*
 *  ======== cleanup ========
 */
static Void cleanup(Void)
{
    static CmdObj dcmdInit = {NULL, NULL, NONE, NONE, NULL, NULL, NULL};

    if (curInit != FALSE) {
        curInit = FALSE;
        if (dcmd.dproc != NULL) {
            doCmd(EXIT, NULL);
            // Thread_join(dcmd.dproc);
            Thread_delete( dcmd.dproc ); /* will do join first? */
            dcmd.dproc = NULL;
        }

        if (dcmd.cmdPresent != NULL) {
            Sem_delete(dcmd.cmdPresent);
            dcmd.cmdPresent = NULL;
        }

        if (dcmd.replyPresent != NULL) {
            Sem_delete(dcmd.replyPresent);
            dcmd.replyPresent = NULL;
        }

        if (dcmd.gate != NULL) {
            Lock_delete(dcmd.gate);
            dcmd.gate = NULL;
        }

        dcmd = dcmdInit;
    }
}

/*
 *  ======== modifyDefaultLinkCfgObjectForCENeeds ========
 *  make changes in the object that are necessary for CE
 *  to work
 */
static Void modifyDefaultLinkCfgObjectForCENeeds()
{
    /* 130 message ques is max */
    ti_sdo_ce_ipc_Processor_linkcfg.gppObject->maxMsgqs = 130;

    /* entry #0 in the IPS table should use DSPLINK mem segment, which is #1 */
    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->ipsTables[0]->memEntry = 1;

    /* RINGIO table should use DSPLINK mem segment, which is #1 */
    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->ringIoObjects->memEntry = 1;

    /* handshake timeout is infinite if an appropriate env var is set */
    if (Global_getenv("CE_DSPDEBUG") != NULL) {
        ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->linkDrvObjects->hshkPollCount = -1;
    }
}

/*
 *  ======== modifyDefaultLinkCfgObjectBasedOnUserCfgData ========
 */
static Void modifyDefaultLinkCfgObjectBasedOnUserCfgData( String serverName )
{
    LINKCFG_MemEntry *  linkcfgMemTable;
    LINKCFG_MemEntry *  e;
    static LINKCFG_MemEntry * linkcfgMemTables[] = { NULL /* to be set */ };
    Global_ArmDspLinkConfig * armDspLinkConfig = NULL;
    Global_ArmDspLinkConfigMemTableEntry *mte;
    DSP_BootMode    staticCfgDspCtl;
    DSP_BootMode    newCfgDspCtl;
    Int    serverNameIndex;
    UInt32 cmemPhysBase;
    size_t cmemSize;
    Int    status;

    /* MODIFY MEMORY CONFIGURATION */
    CMEM_BlockAttrs   blockAttrs;
    Int    numMemTableEntries, i = 0;
    Int    numMemEntries = 0;
    Int    memEntryIdx;
    Int    numCmemBlocks = 0;
    Bool   addCmemBlocks = FALSE;

    /* first locate our server in the list of server names */
    for (serverNameIndex = 0;;serverNameIndex++) {
        if (!strcmp(ti_sdo_ce_ipc_armDspLinkConfigServerNames[serverNameIndex],
            serverName)) {
                break;
        }
        if (ti_sdo_ce_ipc_armDspLinkConfigServerNames[serverNameIndex] ==
            NULL ) {
            GT_1trace(curTrace, GT_7CLASS, "Processor_create_d> "
                "ERROR: Cannot find DspLink configuration data for the server "
                "named '%s' -- verify that the name was specified correctly in "
                "the application configuration file.\n", serverName);
            return;
        }
    }

    GT_2trace(curTrace, GT_2CLASS, "Processor_create_d> "
        "Using DspLink config data for entry #%d [server '%s']\n",
        serverNameIndex, serverName );

    armDspLinkConfig = ti_sdo_ce_ipc_armDspLinkConfigs[ serverNameIndex ];

    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->memTables = linkcfgMemTables;
    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->memTables[0] = NULL;

    /*
     *  Count the number of CMEM blocks, so we can add entries for these,
     *  if needed.
     */
    status = CMEM_getNumBlocks(&numCmemBlocks);
    if (status != 0) {
        /* TODO: Is this always an error? */
        GT_0trace(curTrace, GT_6CLASS, "Processor_create_d> "
                "CMEM_getNumBlocks() failed!");
        numCmemBlocks = 0;
    }
    else {
        GT_1trace(curTrace, GT_2CLASS, "Processor_create_d> Number of CMEM "
                "blocks: %d\n", numCmemBlocks);
    }

    for (;armDspLinkConfig->memTable[i].segmentName != NULL; i++);

    /*
     *  Add a few extra entries in case we need to map CMEM blocks. The
     *  app's config will have at most one CMEM entry with base and length
     *  set to 0. We'll use CMEM_getBlockAttrs to get the base and length
     *  of all CMEM blocks. (Note: We will allocate at least one more entry
     *  then is actually needed, but this is easier than checking the
     *  memTable for "CMEM", and subtracting '1' from the nuber to allocate
     *  if "CMEM" is found.)
     */
    numMemEntries = i;
    numMemTableEntries = numMemEntries + numCmemBlocks;

    /* anything allocated here must be deallocated in procDelete */
    linkcfgMemTable = (LINKCFG_MemEntry *) Memory_alloc(
            sizeof(LINKCFG_MemEntry) * numMemTableEntries, NULL);

    if (linkcfgMemTable == NULL) {
        GT_0trace(curTrace, GT_7CLASS, "Processor_create_d> "
            "ERROR: Memory_alloc failed\n");
        return;
    }

    /* point link config memTables only entry to our list of memTable entries */
    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->memTables[0] = linkcfgMemTable;

    for (i = 0, memEntryIdx = 0; i < numMemEntries; i++) {
        e   = &linkcfgMemTable[memEntryIdx];
        mte = &armDspLinkConfig->memTable[i];
        GT_4trace(curTrace, GT_2CLASS, "Processor_create_d> Adding memTable "
                "entry for %s, physAddr = 0x%x, dspAddr = 0x%x, size = 0x%x\n",
                mte->segmentName, mte->gppAddress, mte->startAddress,
                mte->sizeInBytes);

        if (!strcmp("CMEM", mte->segmentName)) {
            /* Skip CMEM entry, we'll add CMEM blocks later */
            addCmemBlocks = TRUE;
            continue;
        }

        e->entry        = memEntryIdx; //i;
        strncpy( e->name, mte->segmentName, DSP_MAX_STRLEN );
        e->physAddr     = mte->gppAddress; // gpp physical address
        e->dspVirtAddr  = mte->startAddress; // dsp view (physical or virtual)
        e->gppVirtAddr  = (UInt32)-1;
        e->size         = mte->sizeInBytes;
        e->shared       = mte->shared;
        e->syncd        = mte->syncd;

        memEntryIdx++;

        GT_6trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "Adding DSP segment #%d to Link configuration: "
            "name='%s', startAddress=0x%x, sizeInBytes=0x%x, shared=%d, "
            "syncd=%d\n",
            i, e->name, e->physAddr, e->size, e->shared, e->syncd);
    }

    /* Now add the CMEM blocks if needed */
    if (addCmemBlocks) {
        for (i = 0; i < numCmemBlocks; i++) {
            e = &linkcfgMemTable[memEntryIdx];
            status = CMEM_getBlockAttrs(i, &blockAttrs);
            if (status != 0) {
                GT_1trace(curTrace, GT_7CLASS, "Processor_create_d> "
                        "ERROR: failed to get CMEM attrs of block %d\n", i);
                break;
            }
            sprintf(e->name, "CMEM_BLOCK%d", i);
            e->physAddr = blockAttrs.phys_base;
            e->dspVirtAddr = blockAttrs.phys_base;
            e->size = blockAttrs.size;
            memEntryIdx++;
        }
    }

    /* set number of memTable entries */
    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->dspObject[0].memEntries =
        memEntryIdx; //numMemTableEntries;

    /* RESET vector is always #3 in the list (that's how Global.xdt arranges it;
     * read its start address and size and adjust some other params in the
     * dsplink config object. (Note: third in the list is index [2].
     */
    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->dspObject[0].resumeAddr =
        armDspLinkConfig->memTable[2].startAddress + 0x20;
    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->dspObject[0].resetVector =
        armDspLinkConfig->memTable[2].startAddress;
    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->dspObject[0].resetCodeSize =
        armDspLinkConfig->memTable[2].sizeInBytes;

    /* SET DOPOWERCONTROL PER CE CONFIGURATION */
    staticCfgDspCtl =
        ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->dspObject[0].doDspCtrl;

    if (armDspLinkConfig->doDspCtrl == BootNoPwr) {
        newCfgDspCtl = DSP_BootMode_Boot_NoPwr;
    }
    else if (armDspLinkConfig->doDspCtrl == BootPwr) {
        newCfgDspCtl = DSP_BootMode_Boot_Pwr;
    }
    else if (armDspLinkConfig->doDspCtrl == NoLoadNoPwr) {
        newCfgDspCtl = DSP_BootMode_NoLoad_NoPwr;
    }
    else if (armDspLinkConfig->doDspCtrl == NoLoadPwr) {
        newCfgDspCtl = DSP_BootMode_NoLoad_Pwr;
    }
    else { /* NoBoot */
        newCfgDspCtl = DSP_BootMode_NoBoot;
    }

    ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->dspObject[0].doDspCtrl =
        newCfgDspCtl;
    GT_2trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "DODSPCTRL was=%d; now=%d\n", staticCfgDspCtl, newCfgDspCtl);
}

#define sstring(p) #p
#define H( pref ) GT_1trace( curTrace, GT_3CLASS, "linkCfg->%s\n", sstring(pref) )
#define S( pref, field ) GT_2trace( curTrace, GT_3CLASS, "  %s = \"%s\"\n", #field, cfg->pref field )
#define N( pref, field ) GT_2trace( curTrace, GT_3CLASS, "  %s = 0x%x\n", #field, (unsigned)(cfg->pref field) )
#define B( pref, field ) GT_2trace( curTrace, GT_3CLASS, "  %s = %s\n", #field, cfg->pref field ? "TRUE" : "FALSE" )
#define BLANK GT_0trace( curTrace, GT_3CLASS, "\n" );

void dumpLinkCfgObj(LINKCFG_Object *cfg)
{
    int i;
    DSP_BootMode doDspCtrl;
    char *bootString;

    doDspCtrl = cfg->dspConfigs[0]->dspObject->doDspCtrl;
    switch (doDspCtrl) {
      case DSP_BootMode_Boot_NoPwr:
    bootString = "DSP_BootMode_Boot_NoPwr";
    break;
      case DSP_BootMode_Boot_Pwr:
    bootString = "DSP_BootMode_Boot_Pwr";
    break;
      case DSP_BootMode_NoLoad_NoPwr:
    bootString = "DSP_BootMode_NoLoad_NoPwr";
    break;
      case DSP_BootMode_NoLoad_Pwr:
    bootString = "DSP_BootMode_NoLoad_Pwr";
    break;
      case DSP_BootMode_NoBoot:
    bootString = "DSP_BootMode_NoBoot";
    break;
      default:
    bootString = "<INVALID SETTING>";
    break;
    }

    GT_1trace(curTrace, GT_3CLASS, "LINKCFG_Object generated for PROC_setup(%p) ...\n", cfg);

    H(gppObject->);
    #undef P
    #define P gppObject->
    S( P, name );
    N( P, maxMsgqs );
    N( P, maxChnlQueue );
    N( P, poolTableId );
    N( P, numPools );
    // LINKCFG_Gpp );

    BLANK

    H(dspConfigs[0]->dspObject->);
    #undef P
    #define P dspConfigs[0]->dspObject->
        S( P, name );
        N( P, dspArch );
        S( P, loaderName );
        B( P, autoStart );
        S( P, execName );
        // N( P, doDspCtrl );
    GT_1trace(curTrace, GT_3CLASS, "  doDspCtrl = %s\n", bootString);
        N( P, resumeAddr );
        N( P, resetVector );
        N( P, resetCodeSize );
        N( P, maduSize );
        N( P, cpuFreq );
        N( P, endian );
        N( P, wordSwap );
        N( P, memTableId );
        N( P, memEntries );
        N( P, linkDrvId );
        N( P, arg1 );
        N( P, arg2 );
        N( P, arg3 );
        N( P, arg4 );
        N( P, arg5 );

    BLANK

    H(dspConfigs[0]->linkDrvObjects->);
    #undef P
    #define P dspConfigs[0]->linkDrvObjects->
        S( P, name );
        N( P, hshkPollCount );
        N( P, memEntry );
        N( P, ipsTableId );
        N( P, numIpsEntries );
        N( P, poolTableId );
        N( P, numPools );
        N( P, dataTableId );
        N( P, numDataDrivers );
        N( P, mqtId );
        N( P, ringIoTableId );
        N( P, mplistTableId );
        N( P, mpcsTableId );
    // LINKCFG_LinkDrv );


    BLANK

    H(dspConfigs[0]->memTables[0][i].);
    #undef P
    #define P dspConfigs[0]->memTables[0][i].
    for (i = 0; i < cfg->dspConfigs[0]->dspObject->memEntries; i++) {
    GT_1trace( curTrace, GT_3CLASS, "entry #%d:\n", i );
        N( P, entry );
        S( P, name );
        N( P, physAddr );
        N( P, dspVirtAddr );
        N( P, gppVirtAddr );
        N( P, size );
        B( P, shared );
        B( P, syncd );
    } // LINKCFG_MemEntry );

    BLANK

    H(dspConfigs[0]->ipsTables[0][i].);
    #undef P
    #define P dspConfigs[0]->ipsTables[0][i].
    for (i = 0; i < cfg->dspConfigs[0]->linkDrvObjects->numIpsEntries; i++) {
    GT_1trace( curTrace, GT_3CLASS, "entry #%d:\n", i );
        S( P, name );
        N( P, numIpsEvents );
        N( P, memEntry );
        N( P, gppIntId );
        N( P, dspIntId );
        N( P, dspIntVectorId );
        N( P, arg1 );
        N( P, arg2 );
    } // LINKCFG_Ips );

    BLANK

    H(dspConfigs[0]->poolTables[0][i].);
    #undef P
    #define P dspConfigs[0]->poolTables[0][i].
    for (i = 0; i < cfg->gppObject->numPools; i++) {
    GT_1trace( curTrace, GT_3CLASS, "entry #%d:\n", i );
        S( P, name );
        N( P, memEntry );
        N( P, poolSize );
        N( P, ipsId );
        N( P, ipsEventNo );
        N( P, poolMemEntry );
        N( P, arg1 );
        N( P, arg2 );
    } // LINKCFG_Pool );

    BLANK

    H(dspConfigs[0]->dataTables[0][i].);
    #undef P
    #define P dspConfigs[0]->dataTables[0][i].
    for (i = 0; i < cfg->dspConfigs[0]->linkDrvObjects->numDataDrivers; i++) {
    GT_1trace( curTrace, GT_3CLASS, "entry #%d:\n", i );
        S( P, name );
        N( P, baseChnlId );
        N( P, numChannels );
        N( P, maxBufSize );
        N( P, memEntry );
        N( P, poolId );
        N( P, queuePerChnl );
        N( P, ipsId );
        N( P, ipsEventNo );
        N( P, arg1 );
        N( P, arg2 );
    } // LINKCFG_DataDrv );

    BLANK

    H(dspConfigs[0]->mqtObjects->);
    #undef P
    #define P dspConfigs[0]->mqtObjects->
        S( P, name );
        N( P, memEntry );
        N( P, maxMsgSize );
        N( P, ipsId );
        N( P, ipsEventNo );
        N( P, arg1 );
        N( P, arg2 );
    // LINKCFG_Mqt );

    BLANK


    H(dspConfigs[0]->ringIoObjects->);
    #undef P
    #define P dspConfigs[0]->ringIoObjects->
        S( P, name );
        N( P, memEntry );
        N( P, maxEntries );
        N( P, ipsId );
        N( P, ipsEventNo );
    // LINKCFG_RingIo );

    BLANK


    H(dspConfigs[0]->mplistObjects->);
    #undef P
    #define P dspConfigs[0]->mplistObjects->
        S( P, name );
        N( P, memEntry );
        N( P, maxEntries );
        N( P, ipsId );
        N( P, ipsEventNo );
    // LINKCFG_MpList );

    BLANK


    H(dspConfigs[0]->mpcsObjects->);
    #undef P
    #define P dspConfigs[0]->mpcsObjects->
        S( P, name );
        N( P, memEntry );
        N( P, maxEntries );
        N( P, ipsId );
        N( P, ipsEventNo );
    // LINKCFG_Mpcs );
}


/*
 *  ======== procCreate ========
 */
static Bool procCreate(Processor_Handle proc)
{
    DSP_STATUS      status = DSP_SOK;
    ZcpyMqtAttrs    mqtAttrs;
    Bool            retVal;

    GT_1trace(curTrace, GT_ENTER, "Processor_create_d> Enter(proc=0x%x)\n",
            proc);

    /* TODO:L ignoring cpuId string, using 0 for cpuId */
    proc->cpuId = 0;

    /* call power on function -- either the real one, or the empty
     * stub defined by Global.xdt if power is not used.
     */
    if (Power_on(&proc->powerHandle) == Power_EFAIL) {
        retVal = FALSE;
        GT_0trace(curTrace, GT_6CLASS,
            "Processor_create_d> Power_on failed.\n");
        goto procCreate_return;
    }

    /* if using LAD: connect to LAD, startup DSP, attach with Link */
    if (Global_useLinkArbiter) {

        /* connect to LAD */
        ladStatus = LAD_connect(&handle);
        GT_2trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "LAD_connect status = %x, handle = %x\n", ladStatus, handle);

        if (ladStatus != LAD_SUCCESS) {
            GT_1trace(curTrace, GT_7CLASS, "Processor_create_d> "
               "LAD_connect FAILED, status = [0x%x]\n", ladStatus);
            goto ladfail;
        }

        /* startup the DSP (if it isn't already started) */
        GT_2trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "Loading %s on DSP, linkConfigName= %s ...\n", proc->imageName,
            proc->linkConfigName);
        ladStatus = LAD_startupDsp(handle, proc->cpuId, proc->linkConfigName,
            proc->imageName);
        GT_1trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "LAD_startupDsp status = %x\n", ladStatus);

        /* on success, continue */
        if ((ladStatus == LAD_SUCCESS) || (ladStatus == LAD_ALREADYRUNNING)) {
#ifndef WIN32
            /*
             *  Must still call PROC_Attach from this app's process. (For
             *  WinCE, LAD runs in the same process, so PROC_Attach() returns
             *  an error.)
             */
            status = PROC_Attach(proc->cpuId, NULL);
            if (!DSP_SUCCEEDED(status)) {
                GT_1trace(curTrace, GT_7CLASS, "Processor_create_d> "
                    "PROC_Attach following LAD_startupDsp FAILED, "
                    "status=[0x%x]\n", (Uns) status);
                goto ladfail;
            }

            /* must still call POOL_Open from this app (NULL attributes) */
            status = POOL_Open (Global_cePoolId, NULL) ;
            if (!DSP_SUCCEEDED(status)) {
                GT_1trace(curTrace, GT_7CLASS, "Processor_create_d> "
                    "POOL_Open following LAD_startupDsp FAILED, "
                    "status=[0x%x]\n", (Uns) status);
            }
#endif
        }
        /* else, on fail, abort */
        else {
            GT_1trace(curTrace, GT_7CLASS, "Processor_create_d> "
                "LAD_startupDsp FAILED, status = [0x%x]\n", ladStatus);
            goto ladfail;
        }
    } /* end of 'if using LAD' */

    /* else, if no LAD, call Link's startup APIs directly */
    else {

        /*
         *  Create and initialize the PROC object.
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "Initializing DSP PROC...\n");

        modifyDefaultLinkCfgObjectForCENeeds();
        modifyDefaultLinkCfgObjectBasedOnUserCfgData(proc->imageName);

    dumpLinkCfgObj(&ti_sdo_ce_ipc_Processor_linkcfg);

        status = PROC_setup( &ti_sdo_ce_ipc_Processor_linkcfg );

        if (!DSP_SUCCEEDED(status)) {
            goto fail;
        }

        /*
         *  Attach the Dsp.
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "Attaching to DSP PROC...\n");

        status = PROC_Attach(proc->cpuId, NULL);
        if (!DSP_SUCCEEDED(status)) {
            goto fail;
        }

        /*
         *  Open a pool with buffers for both the control messages use by the
         *  transport and the application.
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "Opening MSGQ pool...\n");

        status = POOL_Open(Global_cePoolId, &Global_cePoolAttrs);
        if (!DSP_SUCCEEDED(status)) {
            goto fail;
        }

        /*
         *  Load the executable on the DSP.
         */
        GT_2trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "Loading %s on DSP (%d args)...\n", proc->imageName,
            proc->attrs.argc);

        status = PROC_Load(proc->cpuId, proc->imageName,
            proc->attrs.argc, proc->attrs.argv);
        if (!DSP_SUCCEEDED(status)) {
            goto fail;
        }

        /*
         *  Start execution on DSP.
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "Starting DSP PROC...\n");

        status = PROC_Start(proc->cpuId);
        if (!DSP_SUCCEEDED(status)) {
            goto fail;
        }

        /*
         *  Open the remote transport to the DSP.
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_create_d> "
            "Opening remote transport...\n");
        /* tell the transport which open pool id to use for ctrl messages */
        mqtAttrs.poolId = Global_cePoolId;

        status = MSGQ_TransportOpen(proc->cpuId, &mqtAttrs);
        if (!DSP_SUCCEEDED(status)) {
            goto fail;
        }

    }  /* end of else to using LAD */

    /*
     *  Connect to the Power on the DSP
     */
    if (Power_connect(proc->powerHandle) == Power_EFAIL) {
        goto fail;
    }

    proc->connected = TRUE;

    if (Global_getenv("CE_DSPDEBUG") != NULL) {
        printf("Codec Engine system message (b/c CE_DSPDEBUG=1) : DSP image "
                "loaded and started, press Enter to continue: ");
        getchar();
    }

    retVal = TRUE;
    goto procCreate_return;

    /* TODO:[4] should try those asyncErrorHandlers that link supports?
     * (MSGQ_SetErrorHandler)
     */

fail:
    GT_4trace(curTrace, GT_7CLASS, "Processor_create_d> "
        "Loading and starting DSP server '%s' FAILED, status=[0x%x] "
        "(look for error code 'DSP_EBASE + 0x%x' in "
        "dsplink*/packages/dsplink/gpp/inc/usr/errbase.h) %s\n",
        proc->imageName, status,
        status & 0x7fff, status == DSP_ERANGE ?
            "This error code typically indicates a problem with the DSP memory "
            "map, i.e. it is different from what the Arm side specified; check "
            "the DSP server's memory map in your Arm application .cfg script, "
            "and make sure you have set 'armDspLinkConfig' "
            "configuration variable correctly (for details, refer to the "
            "documentation for ti.sdo.ce.Engine.xdc). Also, verify that "
            "the DSPLINKMEM segment on the DSP is large enough. "
            : ""
         );

ladfail:

    procDelete(proc);

    retVal = FALSE;

procCreate_return:

    GT_1trace(curTrace, GT_2CLASS, "Processor_create_d> return (%d)\n", retVal);

    return retVal;
}

/*
 *  ======== procDelete ========
 */
static Void procDelete(Processor_Handle proc)
{
    DSP_STATUS  status = DSP_SOK;

    GT_1trace(curTrace, GT_ENTER, "Processor_delete_d> Enter (proc=0x%x)\n",
            proc);

    if (proc == NULL) {
        goto procDelete_return;
    }

    /*
     *  Disconnect the Power transport to the DSP
     */
    if (proc->connected) {
        Power_disconnect(proc->powerHandle);
        proc->connected = FALSE;
    }

    /* if not using LAD: close tranport and stop DSP, detach, destroy */
    if (!Global_useLinkArbiter) {
        /*
         *  Close the remote transport
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_delete_d> "
            "Closing remote transport...\n");
        status = MSGQ_TransportClose(proc->cpuId);
        if (!DSP_SUCCEEDED(status)) {
            GT_1trace(curTrace, GT_6CLASS, "Processor_delete_d> "
                "Closing remote transport FAILED, status=0x%x.\n", status);
        }

        /*
         *  Stop execution on DSP
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_delete_d> "
            "Stopping DSP...\n");
        status = PROC_Stop(proc->cpuId);
        if (!DSP_SUCCEEDED(status)) {
            GT_1trace(curTrace, GT_6CLASS, "Processor_delete_d> "
                "Stopping DSP FAILED, status=0x%x\n", status);
        }
    }

#ifdef WIN32
    if (!Global_useLinkArbiter) {
#endif
    /*
     *  Close the CE pool
     */
    GT_0trace(curTrace, GT_2CLASS, "Processor_delete_d> "
        "Closing pool...\n");
    status = POOL_Close(Global_cePoolId);
    if (!DSP_SUCCEEDED(status)) {
        GT_1trace(curTrace, GT_6CLASS, "Processor_delete_d> "
            "Closing pool FAILED, status=0x%x\n", status);
    }
#ifdef WIN32
    }
#endif

    /* if not using LAD: detach and destroy */
    if (!Global_useLinkArbiter) {

        /*
         *  Detach from the processor
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_delete_d> "
            "Detaching from DSP...\n");
        status = PROC_Detach(proc->cpuId);
        if (!DSP_SUCCEEDED(status)) {
            GT_1trace(curTrace, GT_6CLASS, "Processor_delete_d> "
                "Detaching from DSP FAILED, status=0x%x\n", status);
        }

        /*
         *  Destroy the PROC object
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_delete_d> "
            "Destroying DSP... (object, that is)\n");

        status = PROC_Destroy();
        if (!DSP_SUCCEEDED(status)) {
            GT_1trace(curTrace, GT_6CLASS, "Processor_delete_d> "
                "Destroying DSP FAILED, status=0x%x\n", status);
        }
    }

    /* else, if using LAD: release DSP, disconnect, detach */
    else {
#ifndef WIN32
        /*
         *  Detach from DSP to allow Link cleanup
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_delete_d> "
            "Detaching before LAD_releaseDsp...\n");
        status = PROC_Detach(proc->cpuId);
        if (!DSP_SUCCEEDED(status)) {
            GT_1trace(curTrace, GT_6CLASS, "Processor_delete_d> "
                "Detaching from DSP FAILED, status=0x%x\n", status);
        }
#endif
        /*
         *  Release DSP
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_delete_d> "
            "Releasing DSP via LAD_releaseDsp...\n");
        ladStatus = LAD_releaseDsp(handle);
        if ((ladStatus != LAD_SUCCESS) && (ladStatus != LAD_STILLRUNNING)) {
            GT_1trace(curTrace, GT_6CLASS, "Processor_delete_d> "
                "LAD_releaseDsp FAILED, status=0x%x\n", ladStatus);
        }

        /*
         *  Disconnect from LAD
         */
        GT_0trace(curTrace, GT_2CLASS, "Processor_delete_d> "
            "Disconnecting from LAD...\n");
        ladStatus = LAD_disconnect(handle);
        if (ladStatus != LAD_SUCCESS) {
            GT_1trace(curTrace, GT_6CLASS, "Processor_delete_d> "
                "LAD_disconnect FAILED, status=0x%x\n", ladStatus);
        }
    }

    if (proc->powerHandle != NULL) {
        Power_off(proc->powerHandle);
        proc->powerHandle = NULL;
    }

    /* if not using LAD: free memory alloc'd during create */
    if (!Global_useLinkArbiter) {
        /* free up space allocated to modify the config table */
        if (ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->memTables[0] != NULL) {
            Memory_free( ti_sdo_ce_ipc_Processor_linkcfg.dspConfigs[0]->memTables[0],
                    0 /* this should be actual size, but hate to
                       * add one more global variable and we know
                       * on Linux free doesn't require size
                       */,
                    NULL);
        }
    }

procDelete_return:

    GT_0trace(curTrace, GT_ENTER, "Processor_delete_d> return\n");
}

/*
 *  ======== doCmd ========
 */
static Int doCmd(Int cmdId, Processor_Handle proc)
{
    Int result;

    GT_2trace(curTrace, GT_ENTER, "doCmd> Enter (cmdId=%d, proc=0x%x)\n",
            cmdId, proc);

    //pthread_mutex_lock(&dcmd.gate);
    Lock_acquire(dcmd.gate);

    dcmd.proc = proc;
    dcmd.cmdId = cmdId;
    //pthread_cond_signal(&dcmd.cmdPresent);
    Sem_post(dcmd.cmdPresent);

    //while (dcmd.reply == NONE) {
    //    pthread_cond_wait(&dcmd.replyPresent, &dcmd.gate);
    //}
    Sem_pend(dcmd.replyPresent, Sem_FOREVER);

    result = dcmd.reply;
    dcmd.reply = NONE;

    //pthread_mutex_unlock(&dcmd.gate);
    Lock_release(dcmd.gate);

    GT_1trace(curTrace, GT_ENTER, "doCmd> Exit (result=%d)\n", result);

    return (result);
}

/*
 *  ======== getCmd ========
 */
static Int getCmd(Processor_Handle *proc)
{
    Int result;

    GT_1trace(curTrace, GT_ENTER, "getCmd_d> Enter (proc=0x%x)\n", proc);

    //pthread_mutex_lock(&dcmd.gate);

    //while (dcmd.cmdId == NONE) {
    //    pthread_cond_wait(&dcmd.cmdPresent, &dcmd.gate);
    //}
    Sem_pend(dcmd.cmdPresent, Sem_FOREVER);

    result = dcmd.cmdId;
    *proc = dcmd.proc;
    dcmd.cmdId = NONE;

    //pthread_mutex_unlock(&dcmd.gate);
    GT_1trace(curTrace, GT_ENTER, "getCmd_d> Exit (result=%d)\n", result);

    return (result);
}

/*
 *  ======== putReply ========
 */
static Void putReply(Int status)
{
    //pthread_mutex_lock(&dcmd.gate);

    dcmd.reply = status;

    //pthread_cond_signal(&dcmd.replyPresent);
    Sem_post(dcmd.replyPresent);

    /* GT_2trace(curTrace, GT_ENTER, "putReply(0x%x): proc = 0x%lx\n",
     *   status, dcmd.proc);
     */

    //pthread_mutex_unlock(&dcmd.gate);
}

/*
 *  ======== daemon ========
 */
static Int daemon(Void)
{

    GT_0trace(curTrace, GT_1CLASS, "daemon> thread created.\n");

    for (;;) {
        Processor_Handle proc;

        switch (getCmd(&proc)) {
            case CREATE: {
                putReply(procCreate(proc) ? SUCCESS : FAILURE);
                break;
            }

            case DELETE: {
                /* GT_1trace(curTrace, GT_ENTER, "daemon(0x%x) deleting ...\n",
                 *   proc);
                 */
                procDelete(proc);
                /* GT_1trace(curTrace, GT_ENTER, "daemon(0x%x) replying ...\n",
                 *   proc);
                 */
                putReply(SUCCESS);

                break;
            }

            case EXIT: {
                //GT_0trace(curTrace, GT_1CLASS, "daemon> thread terminating\n");
                putReply(SUCCESS);
                return (0);
            }

            default: {
                break;
            }
        }
    }
}

/*
 *  @(#) ti.sdo.ce.ipc.dsplink; 2, 0, 1,182; 12-2-2010 21:24:21; /db/atree/library/trees/ce/ce-r11x/src/ xlibrary

 */

