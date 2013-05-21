/*
 * dvtbMPEG4HDVICPDec2.h
 *
 * XDM1.2 MPEG4HDVICP Decode Interface
 *
 * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
 * 
 * 
 *  Redistribution and use in source and binary forms, with or without 
 *  modification, are permitted provided that the following conditions 
 *  are met:
 *
 *    Redistributions of source code must retain the above copyright 
 *    notice, this list of conditions and the following disclaimer.
 *
 *    Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the 
 *    documentation and/or other materials provided with the   
 *    distribution.
 *
 *    Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
 *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
*/

#ifndef _DVEVM_ST_MPEG4HDVICP_DEC2_H
#define _DVEVM_ST_MPEG4HDVICP_DEC2_H

#include "dvtbGlobal.h"
#include "dvtbEngine.h"
#include <ti/sdo/ce/video2/viddec2.h>
#include <ti/sdo/codecs/mpeg4dec_hdvicp/imp4vdec.h>

#define IMP4VDEC_MAX_WD           (720)
#define IMP4VDEC_MAX_HT           (480)
#define IMP4VDEC_MAX_FR           (30000)
#define IMP4VDEC_MAX_BR           (10000000)//((IMP4VDEC_MAX_FR/1000) * (IMP4VDEC_MAX_HT) * (IMP4VDEC_MAX_WD) * 2)

typedef struct
{
	char mpeg4dec2Name[MAX_NAME_LEN];

	Imp4VDEC_Cmd vdec2Cmd;
	Imp4VDEC_Params vdec2Params;
	Imp4VDEC_DynamicParams vdec2DynParams;
	Imp4VDEC_InArgs vdec2InArgs;
	Imp4VDEC_OutArgs vdec2OutArgs;
	Imp4VDEC_Status vdec2Status;

	DvevmStXdmBuffer inBuf;
	DvevmStXdmBuffer outBuf;
	XDM1_BufDesc inBufDesc;
	XDM_BufDesc outBufDesc;

	DvevmStBufElement outBufArray[VIDDEC2_PLAY_MAX_BUFFERS];
	DvevmStOutBuffsInUse dispBufArray[VIDDEC2_PLAY_MAX_BUFFERS];
	int buffIdSearchStart;

	Engine_Handle ceHdl;
	Imp4VDEC_Handle vdec2Hdl;

	DvevmStBool skipFrame;
	int numFrames;
	int totBuf;
} DvevmStMPEG4HDVICPDec2Info;

DvevmStRetCode
dvtb_mpeg4HDVICPDec2Init(DvevmStMPEG4HDVICPDec2Info *vd);

DvevmStRetCode
dvtb_mpeg4HDVICPDec2Decode(DvevmStMPEG4HDVICPDec2Info *vd, int nFrames, int *decDuration);

DvevmStRetCode
dvtb_mpeg4HDVICPDec2Control(DvevmStMPEG4HDVICPDec2Info *vd);

void
dvtb_mpeg4HDVICPDec2Cleanup(DvevmStMPEG4HDVICPDec2Info *vd);

DvevmStRetCode
dvtb_mpeg4HDVICPDec2Close(DvevmStMPEG4HDVICPDec2Info *vd);

#endif
