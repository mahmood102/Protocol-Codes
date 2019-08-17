`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mahmood Azhar Qureshi
// 
// Create Date: 08/06/2019 07:28:57 PM
// Design Name: 
// Module Name: mainFSM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:	This file contains the design of the main controlling logic used to control all the sub-modules including the PUF circuit, shuffler and the TRNG.
// 
//////////////////////////////////////////////////////////////////////////////////


module mainFSM(
	//External inputs
	input mclk,
	input rst,
	input en,
	input [1:0] PStoPL_msg,
	input debug,
	input [63:0] data_in1,			//connected to concatenated [slvreg1[31:0],slvreg2[31:0]]
	input [63:0] data_in2,			//connected to concatenated [slvreg3[31:0],slvreg4[31:0]]	used only for Shuffled challenge (S1)

	//PUF module inputs
	input puf_done,
	input [63:0] resp_in,
	input [63:0] trng_in,
	//PUF module outputs
	output puf_en,
	output reg [63:0] C_out,
	output reg trng_trig,
	
	//external outputs to AXI slave
	output reg [63:0] data_out,
	output reg interrupt1,
	output reg interrupt2

    );
	
	parameter IDLE			=	5'd0;
	parameter INT1			=	5'd1;		//Interrupt the PS to send INIT command to server
	parameter TRNG			=	5'd2;		//Generate the device nonce
	parameter SHUFFLE_1		=	5'd3;		//Shuffle the device nonce
	parameter WAIT1			=	5'd4;		//wait for PS to get nonce from server and place it over AXI
	parameter SHUFFLE_2		=	5'd5;		//Acquire and Shuffle the server nonce
	parameter WAIT2			=	5'd6;		//wait for PL to write device nonce on AXI
	parameter INT2			= 	5'd7;		//Interrupt the PS to send device nonce to server
	parameter WAIT3			=	5'd8;		//wait for PS to get data(Nos||S1) from server and place it over AXI
	parameter DESHUFFLE_1 	= 	5'd9;		//Deshuffle the Nos received from server
	parameter C_GEN			=	5'd10;		//Gen challenge from deshuffled Nos
	parameter DESHUFFLE_2	=	5'd11;		//Deshuffle S1 
	parameter VALIDATE_INT3	=	5'd12;		//Validate the server by decision criteria
	parameter PUF_EN		=	5'd13;		//If validation criteria satisfied then EN the PUF for Resp generation
	parameter SHUFFLE_3		=	5'd14;		//Shuffle the generated response
	parameter FINAL			=	5'd15;		//Shuffled and XORed the final response
	parameter INT4			=	5'd16;		//Interrupt the PS to send shuffled response to the server
	
	
	
	reg idle;
	reg int1;
	reg trng;
	reg shuffle_1;
	reg wait1;
	reg shuffle_2;
	reg int2;
	reg wait2;
	reg wait3;
	reg deshuffle_1;
	reg c_gen;
	reg deshuffle_2;
	reg validate;
	reg puf;
	reg shuffle_3;
	reg final0;
	
	reg [4:0] current_state,next_state;
	
	wire feedback;
	wire success;
	
	reg [63:0] R_noisy_XORed;
	
	reg [63:0] serv_nonce;
	reg [63:0] serv_nonce_shuffled;
	reg [63:0] dev_nonce;
	reg [63:0] dev_nonce_shuffled; 
	
/////////////////////////////////////////////////////////////////////////////////
//////////////////////////////Shuffler/Deshuffler module signals/buses///////////
/////////////////////////////////////////////////////////////////////////////////
	wire shuffle_done;
	wire [63:0] shuffled_data;
	
	wire shuffle_en;
	reg deshuffle_en;
	reg [63:0] data_to_shuffle;
	reg [63:0] shuffle_key;
	
	//Generate a delayed pulse signal for shuffle_en 
	reg shuffle1_reg;
	reg shuffle2_reg;
	always@(posedge mclk)
	begin
		if(idle)
		begin
			shuffle1_reg <= 0;
			shuffle2_reg <= 0;
		end
		else if(shuffle_1||shuffle_2||shuffle_3||deshuffle_1||deshuffle_2)
		begin
			shuffle1_reg <= 1;
			shuffle2_reg <= shuffle1_reg;
		end
		else
		begin
			shuffle1_reg <= 0;
			shuffle2_reg <= 0;
		end
	end
	
	assign shuffle_en = shuffle1_reg & (!shuffle2_reg);
	
	always@(posedge mclk)
	begin
		if(idle)
			deshuffle_en <= 0;
		else
			deshuffle_en <= deshuffle_1||deshuffle_2;
	end
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
	

/////////////////////////////////////////////////////////////////////////////////
//////////////////////////////PUF and TRNG en signals////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
	
	//Generate a delayed pulse signal for shuffle_en 
	reg puf_reg1;
	reg puf_reg2;
	always@(posedge mclk)
	begin
		if(idle)
		begin
			puf_reg1 <= 0;
			puf_reg2 <= 0;
		end
		else if(puf||trng)
		begin
			puf_reg1 <= 1;
			puf_reg2 <= puf_reg1;
		end
		else
		begin
			puf_reg1 <= 0;
			puf_reg2 <= 0;
		end
	end
	
	assign puf_en = puf_reg1 & (!puf_reg2);
	
	always@(posedge mclk)
	begin
		if(idle)
			trng_trig <= 0;
		else
			trng_trig <= trng;
	end
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
	
	//delay interrupt1 and interrupt2 by 1 cycle
	always@(posedge mclk)
	begin
		if(idle)
		begin
			interrupt1 <= 0;
			interrupt2 <= 0;
		end
		else
		begin
			interrupt1 <= int1;
			interrupt2 <= int2;
		end
	end
	
/////////////////////////////////////////////////////////////////////////////////
//////////////////////////////Main FSM protocol//////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
	always@(posedge mclk or posedge rst)
	begin
		if(rst)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end
	
	always@*
	begin
		case(current_state)
			IDLE:
			begin
				idle = 1;
				int1 = 0;
				trng = 0;
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				if(en && !debug)
					next_state = INT1;
				else
					next_state = IDLE;
			end
		
//Interrupt the PS to send INIT command to server		
			INT1:
			begin
				idle = 0;
				int1 = 1;
				trng = 0;
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
		
				next_state = TRNG;
			end
	
//Generate the device nonce	
			TRNG:
			begin
				idle = 0;
				int1 = 0;
				trng = 1;		//generate a trng_trig and trng en logic from this signal
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				if(puf_done)
				begin
					trng = 0;
					next_state = SHUFFLE_1;
				end
				else
				begin
					trng = 1;
					next_state = TRNG;
				end
			end
	
//Shuffle the device nonce	
			SHUFFLE_1:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 1;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				if(shuffle_done)
				begin
					shuffle_1 = 0;
					next_state = WAIT1;
				end
				else
				begin
					shuffle_1 = 1;
					next_state = SHUFFLE_1;
				end
			end
		
//wait for PS to get nonce from server and place it over AXI		
			WAIT1:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 1;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				if(PStoPL_msg == 2'b01)				//PS successfully received something from server within a timeframe
					next_state = SHUFFLE_2;
				else if(PStoPL_msg == 2'b11)			//PS didn't recieve anything from PS. Reset everything
					next_state = IDLE;
				else
					next_state = WAIT1;
			end
	
//Acquire and Shuffle the server nonce	
			SHUFFLE_2:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 1;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				if(shuffle_done)
				begin
					shuffle_2 = 0;
					next_state = WAIT2;
				end
				else
				begin
					shuffle_2 = 1;
					next_state = SHUFFLE_2;
				end
			end
		
//wait for PL to write device nonce on AXI		
			WAIT2:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 1;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
	
				next_state = INT2;
			end
	
//Interrupt the PS to send device nonce to server	
			INT2:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 1;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
	
				next_state = WAIT3;
			end
		
//wait for PS to get data(Nos||S1) from server and place it over AXI		
			WAIT3:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 1;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				if(PStoPL_msg == 2'b01)				//PS successfully received something from server within a timeframe
					next_state = DESHUFFLE_1;
				else if(PStoPL_msg == 2'b11)			//PS didn't recieve anything from PS. Reset everything
					next_state = IDLE;
				else
					next_state = WAIT3;
			end	
			
//Deshuffle the Nos received from server
			DESHUFFLE_1:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 1;			//use this to generate deshuffle and deshuffle_en signals
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				if(shuffle_done)
				begin
					deshuffle_1 = 0;
					next_state = C_GEN;
				end
				else
				begin
					deshuffle_1 = 1;
					next_state = DESHUFFLE_1;
				end
			end
	
//Gen challenge from deshuffled Nos	
			C_GEN:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;			
				c_gen = 1;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				next_state = DESHUFFLE_2;
			end
			
//Deshuffle S1 
			DESHUFFLE_2:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;			
				c_gen = 0;
				deshuffle_2 = 1;		//use this to generate deshuffle and deshuffle_en signals
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				if(shuffle_done)
				begin
					deshuffle_2 = 0;
					next_state = VALIDATE_INT3;
				end
				else
				begin
					deshuffle_2 = 1;
					next_state = DESHUFFLE_2;
				end
			end
	
//Validate the server by decision criteria	
			VALIDATE_INT3:
			begin
				idle = 0;
				int1 = 1;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;			
				c_gen = 0;
				deshuffle_2 = 0;		//use this to generate deshuffle and deshuffle_en signals
				validate = 1;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
				
				if(success)
					next_state = PUF_EN;
				else
					next_state = IDLE;
			end
		
	//If validation criteria satisfied then EN the PUF for Resp generation
			PUF_EN:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;			
				c_gen = 0;
				deshuffle_2 = 0;		//use this to generate deshuffle and deshuffle_en signals
				validate = 0;
				puf = 1;
				shuffle_3 = 0;
				final0 = 0;

				if(puf_done)
				begin
					puf = 0;
					next_state = SHUFFLE_3;
				end
				else
				begin
					puf = 1;
					next_state = PUF_EN;
				end
			end
	
//Shuffle the generated response	
			SHUFFLE_3:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 1;
				final0 = 0;
				
				if(shuffle_done)
				begin
					shuffle_3 = 0;
					next_state = FINAL;
				end
				else
				begin
					shuffle_3 = 1;
					next_state = SHUFFLE_3;
				end
			end
	
//Shuffled and XORed the final response	
			FINAL:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 0;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 1;
	
				next_state = INT4;
			end
	
//Interrupt the PS to send shuffled response to the server	
			INT4:
			begin
				idle = 0;
				int1 = 0;
				trng = 0;		
				shuffle_1 = 0;
				wait1 = 0;
				shuffle_2 = 0;
				int2 = 1;
				wait2 = 0;
				wait3 = 0;
				deshuffle_1 = 0;
				c_gen = 0;
				deshuffle_2 = 0;
				validate = 0;
				puf = 0;
				shuffle_3 = 0;
				final0 = 0;
	
				next_state = FINAL;
			end
		endcase
	end
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

	
	//Original and Shuffled nonce from server
	always@(posedge mclk)
	begin
		if(idle)
		begin
			serv_nonce <= 64'd0;
			serv_nonce_shuffled <= 64'd0;
		end
		else if(wait1)
		begin
			serv_nonce <= data_in1;
			serv_nonce_shuffled <= serv_nonce_shuffled;
		end
		else if(shuffle_2)
		begin
			serv_nonce <= serv_nonce;
			serv_nonce_shuffled <= shuffled_data;
		end
		else
		begin
			serv_nonce <= serv_nonce;
			serv_nonce_shuffled <= serv_nonce_shuffled;
		end
	end
	
	//Original and Shuffled nonce from device
	always@(posedge mclk)
	begin
		if(idle)
		begin
			dev_nonce <= 64'd0;
			dev_nonce_shuffled <= 64'd0;
		end
		else if(trng_trig)
		begin
			dev_nonce <= trng_in;
			dev_nonce_shuffled <= dev_nonce_shuffled;
		end
		else if(shuffle_1)
		begin
			dev_nonce <= dev_nonce;
			dev_nonce_shuffled <= shuffled_data;
		end
		else
		begin
			dev_nonce <= dev_nonce;
			dev_nonce_shuffled <= dev_nonce_shuffled;
		end
	end
	
	//Providing data to shuffler
	always@(posedge mclk)
	begin
		if(idle)
		begin
			data_to_shuffle <= 64'd0;
			shuffle_key <= 64'd0;
		end
		else if(shuffle_1)		//shuffle the device nonce 
		begin
			data_to_shuffle <= dev_nonce;
			shuffle_key <= dev_nonce;
		end
		else if(shuffle_2)		//shuffle the server nonce
		begin
			data_to_shuffle <= serv_nonce;
			shuffle_key <= serv_nonce;
		end
		else if(deshuffle_1)	//deshuffle Nos received from the server
		begin
			data_to_shuffle <= data_in1;
			shuffle_key <= dev_nonce_shuffled;
		end
		else if(deshuffle_2)
		begin
			data_to_shuffle <= data_in2;
			shuffle_key <= dev_nonce_shuffled;
		end
		else if(shuffle_3)
		begin
			data_to_shuffle <= R_noisy_XORed;
			shuffle_key <= serv_nonce_shuffled;
		end
		else
		begin
			data_to_shuffle <= data_to_shuffle;
			shuffle_key <= shuffle_key;
		end
	end
		
		
				
//	assign R_noisy_XORed[63:0] = resp_in[63:0]^dev_nonce_shuffled[63:0];
	always@(posedge mclk)
	begin
		if(idle)
			R_noisy_XORed <= 64'd0;
		else
			R_noisy_XORed <= resp_in ^ dev_nonce_shuffled;
	end
	
	//Writing data onto the AXI data bus
	always@(posedge mclk)
	begin
		if(idle)
			data_out <= 64'b1010101010101010101010101010101010101010101010101010101010101010;	//init packet hardcoded
		else if(trng_trig)
			data_out <= dev_nonce;		//write 64 bit device nonce generated from TRNG
		else if(success)
			data_out <= 64'd65535;
		else if(shuffle_3)
			data_out <= shuffled_data;	//Write the shuffled and xored response on AXI
	end
	
	
//-> Currently used(Characteristic/primitive poly2 with xor ( x^64 + x^63 + x^61 + x^60)) Maximum length LFSR //https://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
	assign feedback = (((C_out[63] ^ C_out[62]) ^ C_out[60]) ^ C_out[59]);
	always@(posedge mclk)
	begin
		if(idle)
			C_out <= 64'd0;
		else if(deshuffle_1)
			C_out <= shuffled_data;
		else if(c_gen)
			C_out <= {C_out[62:0],feedback};
		else
			C_out <= C_out;
	end
	

//Validate the N0s|S1 received from server
	assign success = C_out == shuffled_data?1:0;
	
	
//Shuffler_deshuffler module
//Instantiate the shuffling/deshuffling system
shuffler shuffler_inst(
    //inputs
    .mclk(mclk)
    ,.rst(rst)
    ,.shuffle_en(shuffle_en)
	,.deshuffle(deshuffle_en)
    ,.data_in(data_to_shuffle)
    ,.key_in(shuffle_key)
    //outputs
    ,.shuffle_out(shuffled_data)
    ,.done(shuffle_done)
    );

	
endmodule
