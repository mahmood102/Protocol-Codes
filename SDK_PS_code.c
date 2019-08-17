/* Mahmood Azhar Qureshi
Desciption: This file is tested on Xilinx SDK and used for communication between the ARM PS and PL of Zynq SoC. Different peripherels within Zynq PS including
Timers, UART and Interrupts are configured and made to work with the PL. Also, the PS has the capability to Tx and Rx data from PL over AXI peripheral implemented 
in the PL. 
The interrupt works in a ping pong fashion. ISR0 disables its own interrupt and enables the isr1 interrupt and vice versa. This was added because of spurios interrupts received by PS.
Future modifications: Verify the integrity of data RXed and TXed over the UART connected to MATLAB so that the data can be sent and received from Matlab.
*/


#include <stdio.h>
#include "xuartps.h"
#include "platform.h"
#include "xil_printf.h"
#include "xbasic_types.h"
#include "xscugic.h"
#include "xil_io.h"
#include "xil_exception.h"
#include "platform_config.h"
#include "xparameters.h"
#include "xscutimer.h"




//#define UART_DEVICE_ID   XPAR_XUARTPS_0_DEVICE_ID
#define TIMER_DEVICE_ID		XPAR_SCUTIMER_DEVICE_ID
#define INTC_INTERRUPT_ID_0 61 // IRQ_F2P[0]
#define INTC_INTERRUPT_ID_1 62 // IRQ_F2P[1]

#define PS_ADDR 0x43C00000		//address of PS



XScuGic intc;				/* instance of interrupt controller*/
XScuGic_Config *intc_config;
XScuGic *intc_instance_ptr = &intc;

XUartPs Uart_Ps;					/* The instance of the UART Driver */
static XScuTimer TimerInstance;		/* instance of timer*/

int setup_interrupt_system();
int setup_uart_system();
void setup_timer();

void isr0();						//Called from IRQ_F2P[0]
void isr1();						//Called from IRQ_F2P[1]

int main()
{
    init_platform();

    int status1 = setup_interrupt_system();
    int status2 = setup_uart_system();



    if(status1 != XST_SUCCESS)
    {
    	print("Problem with Interrupts init\n\r");
    	return 0;
    }

    if(status2 != XST_SUCCESS)
    {
       	print("Problem with UART init\n\r");
       	return 0;
    }

    print("Inside main\n\r");

    setup_timer();		//setting up the timer

    u32 timer_CntValue = XScuTimer_GetCounterValue(&TimerInstance);

//    xil_printf("Started the timer with initial timer value: %d\n\r", timer_CntValue);

    XScuTimer_Start(&TimerInstance);		//start the timer

    while(1)		//This is a polling timer. Waits 3 secs for system to set up completely and avoid spurios (unknown) interrupts
    {
    	timer_CntValue = XScuTimer_GetCounterValue(&TimerInstance);
    	if(timer_CntValue == 0)				
    	{
    		break;
    	}
    }

  //  xil_printf("Timer stopped with value: %d\n\r", timer_CntValue);


    //Enable the interrupts after 3 secs to prevent transient interrupts
    XScuGic_Enable(&intc, INTC_INTERRUPT_ID_0);
    XScuGic_Enable(&intc, INTC_INTERRUPT_ID_1);

    while(1);	//go into infinite loop (Processor can do whatever it wants, The entire protocol is interrupt based)

    cleanup_platform();
    return 0;
}

// interrupt service routine for IRQ_F2P[15] (91)
void isr0 () {
	XScuGic_Disconnect(&intc, INTC_INTERRUPT_ID_0);
	XScuGic_Disable(&intc, INTC_INTERRUPT_ID_0);		//Disable this interrupt to prevent multiple triggers


//	print("isr0 called\n\r");

/*	u8 dataPLtoPS[8];
	for(int i = 0; i<8;i++)
	{
		dataPLtoPS[i] = Xil_In8(PS_ADDR + i);
		XUartPs_Send(&Uart_Ps, &dataPLtoPS[i], 1);
//		xil_printf("%02X", dataPLtoPS[i]);
	}*/


	int recv_count = 0;
	u8 dataPStoPL[8];
	while (recv_count < 8)
	{
		recv_count += XUartPs_Recv(&Uart_Ps, &dataPStoPL[recv_count], 1);
	}

	u32 *PLptr1 = dataPStoPL;
	u32 *PLptr2 = (dataPStoPL + 4);

	Xil_Out32(PS_ADDR , *PLptr1);
//	Xil_Out32(PS_ADDR + 2, *PLptr2);

/* Used for UART Tx. Make another function which TXes 64 bits using Xil_In8 8 times from PL address space */
/*    u8 recv_buffer[4];
    for (int i = 0;i<4;i++)
    {
    	recv_buffer[i] = Xil_In8(PS_ADDR + i);
   // 	xil_printf("Recv buffer: %02X\n\r",recv_buffer[i]);
    	XUartPs_Send(&Uart_Ps, &recv_buffer[i], 1);
    }*/

	XScuGic_Connect(&intc, INTC_INTERRUPT_ID_1, (Xil_ExceptionHandler)isr1, (void *)&intc_instance_ptr);
	XScuGic_Enable(&intc, INTC_INTERRUPT_ID_1);			//Enable 2nd interrupt

}

// interrupt service routine for IRQ_F2P[14] (90)
void isr1()
{
	XScuGic_Disconnect(&intc, INTC_INTERRUPT_ID_1);
	XScuGic_Disable(&intc, INTC_INTERRUPT_ID_1);		//Disable this interrupt to prevent multiple triggers

//	print("isr1 called\n\r");

	u8 dataPStoPL[8] = {0x01,0x23,0x45,0x67,0x89,0xab,0xcd,0xef};

	for(int i = 0; i<4;i++)
	{
		Xil_Out8(PS_ADDR + i + 8, dataPStoPL[i]);
	}



	/* Used for UART Tx. Make another function which TXes 64 bits using Xil_In8 8 times from PL address space */
	/*    u8 recv_buffer[4];
	    for (int i = 0;i<4;i++)
	    {
	    	recv_buffer[i] = Xil_In8(PS_ADDR + i);
	   // 	xil_printf("Recv buffer: %02X\n\r",recv_buffer[i]);
	    	XUartPs_Send(&Uart_Ps, &recv_buffer[i], 1);
	    }*/

	XScuGic_Connect(&intc, INTC_INTERRUPT_ID_0, (Xil_ExceptionHandler)isr0, (void *)&intc_instance_ptr);
	XScuGic_Enable(&intc, INTC_INTERRUPT_ID_0);		//Enable 1st interrupt
}

// sets up the interrupt system and enables interrupts for IRQ_F2P
int setup_interrupt_system() {

    int result;
//    XScuGic *intc_instance_ptr = &intc;


    // get config for interrupt controller
    intc_config = XScuGic_LookupConfig(XPAR_PS7_SCUGIC_0_DEVICE_ID);
    if (NULL == intc_config) {
        return XST_FAILURE;
    }

    result = XScuGic_CfgInitialize(&intc, intc_config, intc_config->CpuBaseAddress);

    if (result != XST_SUCCESS)
    {
         return result;
    }

    // initialize the exception table and register the interrupt controller handler with the exception table
    Xil_ExceptionInit();



    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler)XScuGic_InterruptHandler, &intc);


    Xil_ExceptionEnable();


    // set the priority of interrupt 0 (INT_ID = 61), priority = 28 (formerly A0), edge triggered
    XScuGic_SetPriorityTriggerType(&intc, INTC_INTERRUPT_ID_0, 40, 1);

    // connect the interrupt service routine isr0 to the interrupt controller
    result = XScuGic_Connect(&intc, INTC_INTERRUPT_ID_0, (Xil_ExceptionHandler)isr0, (void *)&intc_instance_ptr);

    if (result != XST_SUCCESS)
    {
        return result;
    }

    // set the priority of interrupt 2 (INT_ID = 62), priority = 20, edge triggered
    XScuGic_SetPriorityTriggerType(&intc, INTC_INTERRUPT_ID_1, 48, 1);

    // connect the interrupt service routine isr1 to the interrupt controller
    result = XScuGic_Connect(&intc, INTC_INTERRUPT_ID_1, (Xil_ExceptionHandler)isr1, (void *)&intc_instance_ptr);

    if (result != XST_SUCCESS)
    {
        return result;
    }


    return XST_SUCCESS;
}

// sets up UART1
int setup_uart_system()
{
	int Status;
	XUartPs_Config *Config;
	Config = XUartPs_LookupConfig(UART_DEVICE_ID);
	if (NULL == Config) {
		return XST_FAILURE;
	}

	Status = XUartPs_CfgInitialize(&Uart_Ps, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XUartPs_SetBaudRate(&Uart_Ps, 9600);
	return Status;
}

void setup_timer()
{
	int Status = XST_SUCCESS;
	XScuTimer_Config *ConfigPtr;

	u32 TimerLoadValue = 0;		//counter value for the timer

	ConfigPtr = XScuTimer_LookupConfig(TIMER_DEVICE_ID);
	Status = XScuTimer_CfgInitialize(&TimerInstance, ConfigPtr,	ConfigPtr->BaseAddr);

	if (Status != XST_SUCCESS)
	{
		xil_printf("In %s: Scutimer Cfg initialization failed...\r\n",	__func__);
		return;
	}

	Status = XScuTimer_SelfTest(&TimerInstance);
	if (Status != XST_SUCCESS)
	{
		xil_printf("In %s: Scutimer Self test failed...\r\n", __func__);
		return;

	}

	XScuTimer_DisableAutoReload(&TimerInstance);		//No need for auto reload (Timer only runs at the start to prevent transient interrupts)

	TimerLoadValue = XPAR_CPU_CORTEXA9_0_CPU_CLK_FREQ_HZ *3 ;		//timer to run for 3s initially

	XScuTimer_LoadTimer(&TimerInstance, TimerLoadValue);
	return;
}

