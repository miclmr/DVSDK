/*******************************************************************************
**+--------------------------------------------------------------------------+**
**|                            ****                                          |**
**|                            ****                                          |**
**|                            ******o***                                    |**
**|                      ********_///_****                                   |**
**|                      ***** /_//_/ ****                                   |**
**|                       ** ** (__/ ****                                    |**
**|                           *********                                      |**
**|                            ****                                          |**
**|                            ***                                           |**
**|                                                                          |**
**|         Copyright (c) 1998-2004 Texas Instruments Incorporated           |**
**|                        ALL RIGHTS RESERVED                               |**
**|                                                                          |**
**| Permission is hereby granted to licensees of Texas Instruments           |**
**| Incorporated (TI) products to use this computer program for the sole     |**
**| purpose of implementing a licensee product based on TI products.         |**
**| No other rights to reproduce, use, or disseminate this computer          |**
**| program, whether in part or in whole, are granted.                       |**
**|                                                                          |**
**| TI makes no representation or warranties with respect to the             |**
**| performance of this computer program, and specifically disclaims         |**
**| any responsibility for any damages, special or consequential,            |**
**| connected with the use of this program.                                  |**
**|                                                                          |**
**+--------------------------------------------------------------------------+**
*******************************************************************************/
/*
 * File name : saBlending.c
 * Decription : This file does the blending of 160*256 buffer
		 on 720*480 image size of format 4:2:2.
		It blends 4 colors with different blend ratios 
		at postion of (260,200) in image.
		The application currently uses buffers allocated by the 
		VDCE driver for input output and bitmap . The input is taken
		 from a file, copied into the "inaddress", and after doing 
		blending the output is stored into "outaddress". The 
		application takes the bitmap buffer "bmpaddress" and 
		blends the same buffer with image 
		buffer
		size of inaddress buffer = (720x480x2
		size of outaddress buffer = (720*480*2)
		size of bmpaddress buffer = (64*160)

  Flow: 				bmpaddress
					   |	
480i.yuv(file on nfs)->inaddr--->blending--->outaddress->489i_blended.yuv
 */
/******************************************************************************
  Header File Inclusion
******************************************************************************/
#include <stdio.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <string.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <linux/davinci_vdce.h>
/******************************************************************************
  Macros
	Changing the following will result in different blending windows.
	PITCH:
	The pitch giverns the buffers' offset.(bytes to traverse to get 
	to the next line
	Rest of them are self explanatory.
 ******************************************************************************/
#define DEVICE_NAME	"/dev/DavinciHD_vdce"
#define IN_HEIGHT	480
#define IN_WIDTH	720
#define IN_PITCH	720
#define OUT_HEIGHT      480
#define OUT_WIDTH	720
#define OUT_PITCH	720
#define BMP_HEIGHT	160
#define BMP_WIDTH	256
#define BMP_PITCH	64
#define BMP_HSP		260
#define BMP_VSP		200
#define INPUTFILE	"480p.yuv"
#define OUTPUTFILE	"480_blended.yuv"
/******************************************************************************
                        Function Definitions
 ******************************************************************************/
void read_from_file(unsigned char *,char *,int);
void write_to_file(unsigned char *, char *,int);
int  init_vdce_engine(int);
void prepare_bitmap_data(unsigned char *);
int  blending(int);
/******************************************************************************
  			Program Main
*******************************************************************************/
int main(int argc, char *argv[])
{
	int ret=0;
	int vdcefd = 0;
	vdce_reqbufs_t	reqbuf;
	vdce_buffer_t buffer;
	void *inaddress,*outaddress,*bmpaddress;
	/*STEP1:  Open VDCE device */
	vdcefd = open(DEVICE_NAME,O_RDWR);
	if( vdcefd <= 0){
                perror("Unable to open VDCE Driver.\n");
                close(vdcefd);
                exit(-1);
        }


        /*
	STEP2: 
	Buffer allocation
	The buffers can be allocated either from 
	the VDCE driver or user pointers can be used
	*/

	/*
	VDCE allocated buffers:
	Request for 1 input buffer of size (720x480x2) of 4:2:2 format
	Here HEIGHT = Height of Y portion of the buffer.Driver 
	understands that size 2 times the size is needed for a 4:2:2 buffer.
	PITCH is NOT restriced to be 720. It could be more if needed.
	*/
        reqbuf.buf_type = VDCE_BUF_IN;
        reqbuf.num_lines = IN_HEIGHT;
        reqbuf.bytes_per_line = IN_PITCH;
        reqbuf.image_type = VDCE_IMAGE_FMT_422;
        reqbuf.count = 1;
        if (ioctl(vdcefd, VDCE_REQBUF, &reqbuf) < 0) {
                perror("buffer allocation error.\n");
                close(vdcefd);
                exit(-1);
        }

        /* request for 1 output buffer of size 720x480x2*/
        reqbuf.buf_type = VDCE_BUF_OUT;
        reqbuf.num_lines = OUT_HEIGHT;
        reqbuf.bytes_per_line = OUT_PITCH;
        reqbuf.image_type = VDCE_IMAGE_FMT_422;
        reqbuf.count =1;
        if (ioctl(vdcefd, VDCE_REQBUF, &reqbuf) < 0) {
                perror("buffer allocation error.\n");
                close(vdcefd);
                exit(-1);
        }

	/* request for 1 bitmap buffer of size 160*64*2*/
        reqbuf.buf_type = VDCE_BUF_BMP;
        reqbuf.num_lines = BMP_HEIGHT;
        reqbuf.bytes_per_line = BMP_PITCH;
        reqbuf.image_type = VDCE_IMAGE_FMT_422;
        reqbuf.count =1;
        if (ioctl(vdcefd, VDCE_REQBUF, &reqbuf) < 0) {
                perror("buffer allocation error.\n");
                close(vdcefd);
                exit(-1);
        }


        /* STEP3:
	Query physical address buffers and map them to user
	space. */
        buffer.buf_type = VDCE_BUF_IN;
        buffer.index = 0;
        if (ioctl(vdcefd, VDCE_QUERYBUF, &buffer) < 0) {
                perror("buffer query  error.\n");
		/*
		closing a device takes care of freeing up
		of the buffers automatically
		*/
                close(vdcefd);
        }
        inaddress =
                 mmap(NULL, buffer.size,
                        PROT_READ | PROT_WRITE, MAP_SHARED,
                 vdcefd, buffer.offset);
        /* mapping input buffer */
        if (inaddress == MAP_FAILED) {
                perror("\nerror in mmaping output buffer");
                close(vdcefd);
                exit(1);
        }

        /* quering physical address for output buffer */
        buffer.buf_type = VDCE_BUF_OUT;
        buffer.index = 0;
        if (ioctl(vdcefd, VDCE_QUERYBUF, &buffer) < 0) {
                perror("buffer query  error.\n");
                close(vdcefd);
        }
        outaddress =
                 mmap(NULL, buffer.size,
                        PROT_READ | PROT_WRITE, MAP_SHARED,
                 vdcefd, buffer.offset);
        /* mapping output buffer */
        if (outaddress == MAP_FAILED) {
                perror("\nerror in mmaping output buffer");
                close(vdcefd);
                exit(1);
        }

        /* quering physical address for bitmap buffer */
        buffer.buf_type = VDCE_BUF_BMP;
        buffer.index = 0;
        if (ioctl(vdcefd, VDCE_QUERYBUF, &buffer) < 0) {
                perror("buffer query  error.\n");
                close(vdcefd);
        }
        bmpaddress =
                 mmap(NULL, buffer.size,
                        PROT_READ | PROT_WRITE, MAP_SHARED,
                 vdcefd, buffer.offset);
        /* mapping output buffer */
        if (bmpaddress == MAP_FAILED) {
                perror("\nerror in mmaping bitmap buffer");
                close(vdcefd);
                exit(1);
        }


	/*STEP4:
	Buffer preperation. Copy the data into an input buffer from a file.
	This step could be different depnding on the app. One could also 
	use the user pointers to prepare the data.
	The way to copy the file into buffer depends on the buffer pitch too. 
	If  the pitches of the file and the buffer are different, 
	consider copying them line by line.
	*/
	read_from_file(inaddress,INPUTFILE,IN_HEIGHT*IN_PITCH*2);

	/*STEP5:
	Bitmap Buffer preperation. Copy the data into an bitmap buffer.
	This step could be different depnding on the app. 
	One could also use file to copy data into bitmap buffer.
	The way to copy the data into buffer depends on the buffer pitch too.
       	If the pitches of the data to be copied from file and the buffer 
	are different, consider copying them line by line.
	*/
	prepare_bitmap_data(bmpaddress);
	/*
	STEP6:
	Initialize the parameters of VDCE.
	*/	
	ret = init_vdce_engine(vdcefd);
	if(ret) {
		perror("Cannot initialize Vdce Driver\n");
		return -1;
	}

	/* STEP7:
	Issue a call to do blending. This requires the input/output and bitmap
	buffer pointer info and info regarding usage of either user 
	pointers/driver	 allocated buffers.
	*/
	ret = blending(vdcefd);
	if(ret<0) {
		perror("blending operation failed\n");
	}
	/* Dump the Blended file data to file */
	write_to_file(outaddress,OUTPUTFILE,OUT_HEIGHT*OUT_PITCH*2);
	printf("Blending complete. Output written to file %s\n", OUTPUTFILE);
	printf("Use the saDisplay application to view the output on a "
			"connected display\n");

	/*STEP8:
	Close the file handle and unmap the buffers
	*/
	munmap(inaddress,IN_HEIGHT*IN_PITCH*2);
        munmap(outaddress,OUT_HEIGHT*OUT_PITCH*2);
	munmap(bmpaddress,BMP_HEIGHT*BMP_PITCH*2);
	close(vdcefd);

}


/*
 *=====================init_vdce_engine===========================*/
/* set the necessary parameters */
int init_vdce_engine(int vdcefd )
{
	vdce_params_t vdce_params;
	int i=0;

	/* Bitmap array used for blending. Changing the values of Y CB and CR
	will result into different colors of blend windows. With evey Y,Cb CR
	values there is an blend factor associate. Blend factor 0xff means
	opaque and 0x0 means transperent */

	unsigned char crcbyfactor[4][4] = {
         0xf0, 0x5a, 0x51,0xff,/* blue color component values of cr cb & y */
         0x22, 0x36, 0x91,0xc0,/* red color component values of cr cb & y*/
         0x6e, 0xf0, 0x29,0x80,/* green color component values of cr cb & y*/
         0xde, 0xca, 0x6a,0x40,/* magenta color component values of cr cb & y*/

        };
	/* We want to do Blending.(as agianst other operations
	   like CCV,RESIZE etc)
	 */
	vdce_params.vdce_mode = VDCE_OPERATION_BLENDING;

	/* Get the default set of parameters to save ourselves from
	   enetring a whole host of parameters and using wrong parameters
	 */
	if (ioctl(vdcefd, VDCE_GET_DEFAULT, &vdce_params) < 0) {
		printf("default params failed error.\n");
		return -1;
	}
	/* change input and output size from the dafaults 
	   applicable for the current need
	 */
	vdce_params.common_params.src_hsz_luminance = IN_WIDTH;
	vdce_params.common_params.src_vsz_luminance = IN_HEIGHT;

	/* set output size  */
	vdce_params.common_params.dst_hsz_luminance = OUT_WIDTH;
	vdce_params.common_params.dst_vsz_luminance= OUT_HEIGHT;

	/* set the bitmap size */
	vdce_params.common_params.bmp_hsize = BMP_WIDTH;
	vdce_params.common_params.bmp_vsize = BMP_HEIGHT;

	/* 
	   --------------
	 ************** == INTERLACED FRAME or POGRESSIVE FRAME
	 --------------
	 **************

	 --------------
	 -------------- == INTERLACED FIELD
	 **************
	 **************
	 PROGRESSIVE indicates that we wish use a full framed buffer.
	 One could also use INTERLACED FRAME. for the same.INTERLACED
	 FIELD mode indicates separated fields.
	 */
	vdce_params.common_params.src_processing_mode = VDCE_PROGRESSIVE;
	vdce_params.common_params.src_mode = VDCE_FRAME_MODE;
	vdce_params.common_params.res_mode = VDCE_FRAME_MODE;
	vdce_params.common_params.src_bmp_mode = VDCE_FRAME_MODE;

	/* Postions the bitmap windows on the overall image window .This
	   values governs the stating of bitmap on image */
	vdce_params.common_params.res_vsp_bitmap = BMP_VSP;
	vdce_params.common_params.res_hsp_bitmap = BMP_HSP;

	/* Fill the blend values associated with every blend table */
	for(i=0;i<MAX_BLEND_TABLE;i++){
		vdce_params.vdce_mode_params.blend_params.
			bld_lut[i].blend_cr =  crcbyfactor[i][0];
		vdce_params.vdce_mode_params.blend_params.
			bld_lut[i].blend_cb = crcbyfactor[i][1];
		vdce_params.vdce_mode_params.blend_params.
			bld_lut[i].blend_y = crcbyfactor[i][2];
		vdce_params.vdce_mode_params.blend_params.
			bld_lut[i].blend_value= crcbyfactor[i][3];
	}
	/* call ioctl to set parameters */
	if (ioctl(vdcefd, VDCE_SET_PARAMS, &vdce_params) < 0) {
		printf("set params failed \n");
		return -1;
	}
	return 0;
}
/*
 *=====================ccv420_422===========================*/
/*This function triggers the ccv operation */
int blending(int vdcefd)
{
	vdce_address_start_t runtime_params;

	/* Here 0 is the index of the  Driver allocated buffer.
	For multiple driver allocated buffers, use 0,1,2 etc.
	If one wishes to use user pointers, the index should be set to -1
	 */
	runtime_params.buffers[VDCE_BUF_IN].index =0;/* Index number */
	runtime_params.buffers[VDCE_BUF_OUT].index =0;/* Index number */
	runtime_params.buffers[VDCE_BUF_BMP].index =0;/* Index number */
	runtime_params.src_horz_pitch = IN_PITCH;
	runtime_params.res_horz_pitch = OUT_PITCH;
	runtime_params.bmp_pitch = BMP_PITCH;


        if (ioctl(vdcefd, VDCE_START, &runtime_params) < 0) {
                perror("ge start failed \n");
                return -1;
        }

	return 0;
}

/*
 *=====================read_from_file===========================
 It will take the data from file and fill in ge buffer 
*/

void read_from_file(unsigned char *addr,char *filename,int size)
{
        FILE *fp;
        fp = fopen(filename, "rb");
        if(fp == NULL) {
                printf("Cannot open file %s. You should find it along with"
				" example source code\n", filename);
                exit(0);
        }
        fread(addr,size,1,fp);
        fclose(fp);
}
/*
 *=====================write_to_file===========================
It will take the output data and dump into file 
*/

void write_to_file(unsigned char *addr, char *filename, int size)
{
        FILE *fp;
        fp = fopen(filename, "wb");
        if(fp == NULL) {
                printf("Cannot open file = %s\n",filename);
                return ;
        }
        fwrite(addr,size,1,fp);
        fclose(fp);
}
/*
 *=====================prepare_bitmap_data===========================
It will prepare the bitmap buffer
*/
void prepare_bitmap_data(unsigned char *bmpaddress)
{
	/* The logic divides the bitamp buffer into 4 equal horizontal 
	   parts.With every part there is an bitmap table associated
	   which will blend associated color with appropriate blend factor */
	memset((void *)bmpaddress,0,(BMP_PITCH)*(BMP_HEIGHT/4));
	memset((void *)(bmpaddress+((BMP_PITCH) *(BMP_HEIGHT/4))),
			0X55,((BMP_HEIGHT/4)*(BMP_PITCH)));
	memset((void *)(bmpaddress+((BMP_PITCH) *(BMP_HEIGHT/2))),
			0Xaa,((BMP_HEIGHT/4)*(BMP_PITCH)));
	memset((void *)(bmpaddress+(((BMP_PITCH) *BMP_HEIGHT*3)/4)),
			0Xff,((BMP_HEIGHT/4)*(BMP_PITCH)));
}
