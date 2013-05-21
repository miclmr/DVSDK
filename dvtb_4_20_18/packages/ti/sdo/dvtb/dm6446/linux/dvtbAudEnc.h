/*
 * dvtbAudEnc.h
 *
 * XDM0.9 Audio Encode Interface
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

#ifndef _DVEVM_ST_AUD_ENC_H
#define _DVEVM_ST_AUD_ENC_H

#include "dvtbGlobal.h"
#include "dvtbEngine.h"
#include <ti/sdo/ce/audio/audenc.h>

#define AUDENC_FRAME_SIZE          (80)
#define AUDENC_MAX_SR              (16000)
#define AUDENC_MAX_CH              (1)
#define AUDENC_MAX_BR              (AUDENC_MAX_SR*AUDENC_MAX_CH*16)  /* Assuming 16bits per sample */
#define AUDENC_INBUF_SIZE          (1648)//(4096)
#define AUDENC_OUTBUF_SIZE         (8192)
#define DEFAULT_AUDENC_TIME        (10)

typedef struct
{

	char aencName[MAX_NAME_LEN];

	IAUDENC_Params aencParams;
	AUDENC_Cmd aencCmd;
	IAUDENC_DynamicParams aencDynParams;
	IAUDENC_Status aencStatus;

	DvevmStXdmBuffer inBuf;
	DvevmStXdmBuffer outBuf;

	Engine_Handle ceHdl;
	AUDENC_Handle aencHdl;

	unsigned int seconds; /* Number of seconds for audio capture */
} DvevmStAudEncInfo;

DvevmStRetCode
dvtb_audEncInit(DvevmStAudEncInfo *ae);

DvevmStRetCode
dvtb_audEncEncode(DvevmStAudEncInfo *ae, int *encDuration);

void
dvtb_audEncCleanup(DvevmStAudEncInfo *ae);

DvevmStRetCode
dvtb_audEncControl(DvevmStAudEncInfo *ae);

DvevmStRetCode
dvtb_audEncClose(DvevmStAudEncInfo *ae);

#endif
