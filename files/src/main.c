/*
 * main.c
 *
 *  Created on: 2019Äê6ÔÂ27ÈÕ
 *      Author: yongw
 */

#include "xparameters.h"
#include "xil_printf.h"
#include "xstatus.h"
#include "stdlib.h"
#include "main.h"
#include "sleep.h"
#include "xdebug.h"

#include "ov5640.h"
#include "xv_demosaic.h"
#include "XIic.h"

#define CAM_DEV_ADDR 0x3C
#define IIC_ID XPAR_PS7_I2C_0_DEVICE_ID
#define IIC_SCLK_RATE 100000
#define DYNCLK_BASEADDR XPAR_AXI_DYNCLK_0_BASEADDR
#define VDMA_BASEADDR_0 XPAR_AXI_VDMA_0_BASEADDR
#define VDMA_BASEADDR_1 XPAR_AXI_VDMA_1_BASEADDR
#define DISP_VTC_ID XPAR_VTC_0_DEVICE_ID

#define AXI_IIC_ADDR XPAR_AXI_IIC_0_BASEADDR

void writeReg(u16 reg_addr, u8 reg_data);
u8 readReg(u16 reg_addr);

#include "xsobelFilter.h"

#define CHANNEL 3

int main()
{
	xil_printf("\x1B[H"); //Set cursor to top left of terminal
	xil_printf("\x1B[2J"); //Clear terminal
	int Status;

	XV_demosaic *demosaicPtr = (XV_demosaic*)malloc(sizeof(XV_demosaic));
	XV_demosaic_Initialize(demosaicPtr, XPAR_V_DEMOSAIC_0_DEVICE_ID);

	xil_printf("mosaic init \r\n");
	XV_demosaic_Set_HwReg_width(demosaicPtr, 1280);
	XV_demosaic_Set_HwReg_height(demosaicPtr, 720);
	XV_demosaic_Set_HwReg_bayer_phase(demosaicPtr, 1);
	XV_demosaic_EnableAutoRestart(demosaicPtr);
	XV_demosaic_Start(demosaicPtr);

	int length = sizeof(ov5640_config)/sizeof(config_word_t);
	xil_printf("%d\r\n", length);

	for(int i = 0; i < length; i++)
			writeReg(ov5640_config[i].addr, ov5640_config[i].data);


	xil_printf("IIC done!\r\n");

	XSobelfilter sobel;

	Status = XSobelfilter_Initialize(&sobel, 0);
	xil_printf("fast init %d\r\n", Status);
	XSobelfilter_Set_rows(&sobel, 720);
	XSobelfilter_Set_cols(&sobel, 1280);
	XSobelfilter_Set_order(&sobel, 0);
	XSobelfilter_InterruptGlobalDisable(&sobel);
	XSobelfilter_EnableAutoRestart(&sobel);
	XSobelfilter_Start(&sobel);

	xil_printf("vdma starts\r\n");
	Xil_Out32((VDMA_BASEADDR_0 + 0x030),0x0108b);
	Xil_Out32((VDMA_BASEADDR_0 + 0x0AC), 0x01000000);
	Xil_Out32((VDMA_BASEADDR_0 + 0x0B0), 0x02000000);
	Xil_Out32((VDMA_BASEADDR_0 + 0x0B4), 0x03000000);
	Xil_Out32((VDMA_BASEADDR_0 + 0x0A8), (1280 * CHANNEL));
	Xil_Out32((VDMA_BASEADDR_0 + 0x0A4), (1280 * CHANNEL));
	Xil_Out32((VDMA_BASEADDR_0 + 0x0A0), 720);

	Xil_Out32((VDMA_BASEADDR_0 + 0x000), 0x008b);
	Xil_Out32((VDMA_BASEADDR_0 + 0x05c), 0x01000000);
	Xil_Out32((VDMA_BASEADDR_0 + 0x060), 0x02000000);
	Xil_Out32((VDMA_BASEADDR_0 + 0x064), 0x03000000);
	Xil_Out32((VDMA_BASEADDR_0 + 0x058), (1280 * CHANNEL));
	Xil_Out32((VDMA_BASEADDR_0 + 0x054), (1280 * CHANNEL));
	Xil_Out32((VDMA_BASEADDR_0 + 0x050), 720);

	Xil_Out32((VDMA_BASEADDR_1 + 0x030),0x0108b);
	Xil_Out32((VDMA_BASEADDR_1 + 0x0AC), 0x04000000);
	Xil_Out32((VDMA_BASEADDR_1 + 0x0B0), 0x05000000);
	Xil_Out32((VDMA_BASEADDR_1 + 0x0B4), 0x06000000);
	Xil_Out32((VDMA_BASEADDR_1 + 0x0A8), (1280 * CHANNEL));
	Xil_Out32((VDMA_BASEADDR_1 + 0x0A4), (1280 * CHANNEL));
	Xil_Out32((VDMA_BASEADDR_1 + 0x0A0), 720);

	Xil_Out32((VDMA_BASEADDR_1 + 0x000), 0x008b);
	Xil_Out32((VDMA_BASEADDR_1 + 0x05c), 0x04000000);
	Xil_Out32((VDMA_BASEADDR_1 + 0x060), 0x05000000);
	Xil_Out32((VDMA_BASEADDR_1 + 0x064), 0x06000000);
	Xil_Out32((VDMA_BASEADDR_1 + 0x058), (1280 * CHANNEL));
	Xil_Out32((VDMA_BASEADDR_1 + 0x054), (1280 * CHANNEL));
	Xil_Out32((VDMA_BASEADDR_1 + 0x050), 720);

	while(1)
	{
		XSobelfilter_Set_order(&sobel, 0);
		sleep(3);

		XSobelfilter_Set_order(&sobel, 1);
		sleep(3);
	}


	xil_printf("config done\r\n");
}

void writeReg(u16 reg_addr, u8 reg_data)
{
	u8 buf[3];
	buf[0] = (reg_addr >> 8) & 0xff;
	buf[1] = reg_addr & 0xff;
	buf[2] = reg_data;

	XIic_Send(AXI_IIC_ADDR, CAM_DEV_ADDR, buf, 3, 0);

}

u8 readReg(u16 reg_addr)
{
	u8 write_buf[3];
	write_buf[0] = (reg_addr >> 8) & 0xff;
	write_buf[1] = reg_addr & 0xff;
	u8 read_buf;
	XIic_Send(AXI_IIC_ADDR, CAM_DEV_ADDR, write_buf, 2, 0);
	XIic_Recv(AXI_IIC_ADDR, CAM_DEV_ADDR, &read_buf, 1, 0);
	return read_buf;
}
