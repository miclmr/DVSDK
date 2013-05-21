/*
 * dvtbImgDec.h
 *
 * XDM0.9 Image Decode Interface
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

#ifndef _DVEVM_ST_IMG_DEC_H
#define _DVEVM_ST_IMG_DEC_H

#include "dvtbGlobal.h"
#include "dvtbEngine.h"
#include "dvtbMemory.h"
#include <ti/sdo/ce/image/imgdec.h>

#define IMGDEC_MAX_HT           (480)
#define IMGDEC_MAX_WD           (720)
#define IMGDEC_MAX_SCANS        (1)

typedef struct
{
	char idecName[MAX_NAME_LEN];

	IMGDEC_Params idecParams;
	IMGDEC_Cmd idecCmd;
	IMGDEC_DynamicParams idecDynParams;
	IMGDEC_InArgs idecInArgs;
	IMGDEC_OutArgs idecOutArgs;
	IMGDEC_Status idecStatus;

	DvevmStXdmBuffer inBuf;
	DvevmStXdmBuffer outBuf;

	Engine_Handle ceHdl;
	IMGDEC_Handle idecHdl;
} DvevmStImgDecInfo;

DvevmStRetCode
dvtb_imgDecInit(DvevmStImgDecInfo *idec);

DvevmStRetCode
dvtb_imgDecDecode(DvevmStImgDecInfo *idec, int *decDuration);

void
dvtb_imgDecCleanup(DvevmStImgDecInfo *idec);

DvevmStRetCode
dvtb_imgDecControl(DvevmStImgDecInfo *idec);

DvevmStRetCode
dvtb_imgDecClose(DvevmStImgDecInfo *idec);

#endif