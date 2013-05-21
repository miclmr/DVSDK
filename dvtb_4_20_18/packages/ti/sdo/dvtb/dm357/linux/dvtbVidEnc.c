/*
 * dvtbVidEnc.c
 *
 * XDM0.9 Video Encode Interface
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

#include "dvtbVidEnc.h"
#include "dvtbMemory.h"

static void
dvtb_vidEncInitDebug(VIDENC_Params *vep)
{
  SYS_DEBUG("\n<======== Video Encoder Initialize Debug Start ==========>\n");
  SYS_DEBUG("Encoding Preset    : %d\n", (int) vep->encodingPreset);
  SYS_DEBUG("Rate Ctrl Preset   : %d\n", (int) vep->rateControlPreset);
  SYS_DEBUG("Max Height         : %d\n", (int) vep->maxHeight);
  SYS_DEBUG("Max Width          : %d\n", (int) vep->maxWidth);
  SYS_DEBUG("Max Frame Rate     : %d\n", (int) vep->maxFrameRate);
  SYS_DEBUG("Max Bit Rate       : %d\n", (int) vep->maxBitRate);
  SYS_DEBUG("Endianness         : %d\n", (int) vep->dataEndianness);
  SYS_DEBUG("Max Inter Frame    : %d\n", (int) vep->maxInterFrameInterval);
  SYS_DEBUG("Input Chroma Fmt   : %d\n", (int) vep->inputChromaFormat);
  SYS_DEBUG("Input Content      : %d\n", (int) vep->inputContentType);
  SYS_DEBUG("\n<======== Video Encoder Initialize Debug End ============>\n\n");
}

static void
dvtb_vidEncProcessDebug(VIDENC_OutArgs *veo)
{
  SYS_DEBUG("\n<======== Video Encoder Process Debug Start ==========>\n");
  SYS_DEBUG("Extended Error     : %d\n", (int) veo->extendedError);
  SYS_DEBUG("Bytes Generated    : %d\n", (int) veo->bytesGenerated);
  SYS_DEBUG("Encoded Frame Type : %d\n", (int) veo->encodedFrameType);
  SYS_DEBUG("Input Frame Skip   : %d\n", (int) veo->inputFrameSkip);
  SYS_DEBUG("\n<======== Video Encoder Process Debug End ============>\n");
}

#if 0
static void
dvtb_vidEncControlDebug(VIDENC_Status *ves)
{
  int i=0;

  SYS_DEBUG("\n<======== Video Encoder Control Debug Start ==========>\n");
  SYS_DEBUG("Extended Error     : %d\n", (int) ves->extendedError);
  SYS_DEBUG("BUF-Min In Bufs    : %d\n", (int) ves->bufInfo.minNumInBufs);
  SYS_DEBUG("BUF-Min Out Bufs   : %d\n", (int) ves->bufInfo.minNumOutBufs);

  for (i=0; i<ves->bufInfo.minNumInBufs; i++)
    SYS_DEBUG("BUF-Min In Size  [%d]  : %d\n", i, (int) ves->bufInfo.minInBufSize[i]);

  for (i=0; i<ves->bufInfo.minNumOutBufs; i++)
    SYS_DEBUG("BUF-Min Out Size  [%d] : %d\n", i, (int) ves->bufInfo.minOutBufSize[i]);

  SYS_DEBUG("\n<======== Video Encoder Control Debug End ============>\n");
}
#endif

static void
dvtb_vidEncCleanup(DvevmStVidEncInfo *ve)
{
  if (NULL != ve->vencHdl)
  {
    VIDENC_delete(ve->vencHdl);
    ve->vencHdl = NULL;
  }

  dvtb_freeCmem(&ve->inBuf);
  dvtb_freeCmem(&ve->outBuf);
}

DvevmStRetCode
dvtb_vidEncInit(DvevmStVidEncInfo *ve)
{
  ASSERT(ve != NULL);
  ASSERT(ve->ceHdl != NULL);
  ASSERT(ve->vencName[0] != 0);

  ve->vencCmd = XDM_SETPARAMS;
  if (NULL == (ve->vencHdl = VIDENC_create(ve->ceHdl, ve->vencName, &ve->vencParams)))
  {
    dvtb_vidEncInitDebug(&ve->vencParams);
    SYS_ERROR("Unable to initialize Video Encoder\n");
  }
  else if (DVEVM_ST_FAIL == dvtb_vidEncControl(ve))
  {
    dvtb_vidEncCleanup(ve);
    SYS_ERROR("Unable to set encoder dynamic parameters\n");
  }
  else if (DVEVM_ST_FAIL == dvtb_allocCmem(&ve->inBuf))
  {
    SYS_ERROR("Unable to allocate memory for input buffer\n");
  }
  else if (DVEVM_ST_FAIL == dvtb_allocCmem(&ve->outBuf))
  {
    SYS_ERROR("Unable to allocate memory for output buffer\n");
  }
  else
  {
    SYS_DEBUG("Video Encoder <%s> initialized\n", ve->vencName);
    dvtb_vidEncInitDebug(&ve->vencParams);
    return DVEVM_ST_SUCCESS;
  }

  return DVEVM_ST_FAIL;
}

DvevmStRetCode
dvtb_vidEncEncode(DvevmStVidEncInfo *ve, int* encDuration)
{
  XDM_BufDesc                 inBufDesc;
  XDM_BufDesc                 outBufDesc;
  XDAS_Int32                  status;

  VIDENC_InArgs              encInArgs;
  DvevmStTime timeStmpBfrEnc, timeStmpAftrEnc;
  int processTime=0;

  ASSERT(ve != NULL);
  ASSERT(ve->ceHdl != NULL);
  ASSERT(ve->vencHdl != NULL);
  ASSERT(ve->inBuf.numBufs > 0);
  ASSERT(ve->outBuf.numBufs > 0);

  inBufDesc.numBufs = ve->inBuf.numBufs;
  inBufDesc.bufSizes = (XDAS_Int32 *) ve->inBuf.bufSizes;
  inBufDesc.bufs = (XDAS_Int8 **) ve->inBuf.bufs;

  outBufDesc.numBufs = ve->outBuf.numBufs;
  outBufDesc.bufSizes = (XDAS_Int32 *) ve->outBuf.bufSizes;
  outBufDesc.bufs = (XDAS_Int8 **) ve->outBuf.bufs;

  encInArgs.size = sizeof(encInArgs);
  ve->vencOutArgs.size = sizeof(ve->vencOutArgs);

  timeStmpBfrEnc = dvtb_getTime();
  status = VIDENC_process(ve->vencHdl, &inBufDesc, &outBufDesc, &encInArgs, &ve->vencOutArgs);
  timeStmpAftrEnc = dvtb_getTime();
  processTime = ((timeStmpAftrEnc.tv_sec*NUM_MICROSECS_IN_SEC)+timeStmpAftrEnc.tv_usec)-((timeStmpBfrEnc.tv_sec*NUM_MICROSECS_IN_SEC)+timeStmpBfrEnc.tv_usec);
  *encDuration = processTime;
//  printDspTrace();

  if (status != VIDENC_EOK)
  {
    SYS_ERROR("Video Encode Process failed (%d), Codec Error : %d\n", (int) status, (int) ve->vencOutArgs.extendedError);
    return DVEVM_ST_FAIL;
  }

  dvtb_vidEncProcessDebug(&ve->vencOutArgs);

  return DVEVM_ST_SUCCESS;
}

DvevmStRetCode
dvtb_vidEncControl(DvevmStVidEncInfo *ve)
{
  int status;

  ASSERT(ve != NULL);
  ASSERT(ve->ceHdl != NULL);

  status = VIDENC_control(ve->vencHdl, ve->vencCmd, &ve->vencDynParams, &ve->vencStatus);
  if (VIDENC_EOK != status)
  {
    SYS_ERROR("Error (%d), Codec Error (%d) in Video Encoder Control\n", status, (int)ve->vencStatus.extendedError);
    return DVEVM_ST_FAIL;
  }
  else
  {
    SYS_DEBUG("Video Encode Control => Command : %d\n", ve->vencCmd);
    SYS_DEBUG("Input Height     : %d\n", (int) ve->vencDynParams.inputHeight);
    SYS_DEBUG("Input Width      : %d\n", (int) ve->vencDynParams.inputWidth);
    SYS_DEBUG("Ref Frame Rate   : %d\n", (int) ve->vencDynParams.refFrameRate);
    SYS_DEBUG("Tgt Frame Rate   : %d\n", (int) ve->vencDynParams.targetFrameRate);
    SYS_DEBUG("Target Bit Rate  : %d\n", (int) ve->vencDynParams.targetBitRate);

#if 0
    if (XDM_GETBUFINFO == ve->vencCmd)
    {
      ve->inBuf.numBufs = ve->vencStatus.bufInfo.minNumInBufs;
      ve->outBuf.numBufs = ve->vencStatus.bufInfo.minNumOutBufs;

      for (i=0; i<ve->inBuf.numBufs; i++)
      {
        ve->inBuf.bufSizes[i] = ve->vencStatus.bufInfo.minInBufSize[i];
      }

      for (i=0; i<ve->outBuf.numBufs; i++)
      {
        ve->outBuf.bufSizes[i] = ve->vencStatus.bufInfo.minOutBufSize[i];
      }
    }
    dvtb_vidEncControlDebug(&ve->vencStatus);
#endif

    return DVEVM_ST_SUCCESS;
  }
}

DvevmStRetCode
dvtb_vidEncClose(DvevmStVidEncInfo *ve)
{
  dvtb_vidEncCleanup(ve);
  return DVEVM_ST_SUCCESS;
}