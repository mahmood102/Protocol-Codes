`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mahmood Azhar
// 
// Create Date: 07/02/2019 02:26:03 PM
// Design Name: 
// Module Name: PUF_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:	This module implements the controlling FSM. The FSM controls the operation of the DAPUF by switching between the TRNG and CRP generation
// 
//////////////////////////////////////////////////////////////////////////////////



module PUF_ctrl(
    input mclk,
    input rst,
    input en_pulse,
    input en_pulse_trng,        //enable for TRNG
	input trng_trig,
	
	input [7:0] T_C_L,
	input [7:0] T_C_R,
	input [7:0] T_R_L,
	input [7:0] T_R_R,
	input [63:0] C_in,
	input [47:0] C_in_trng,
	
//	output ff1_out,                                 //3rd
//	output ff2_out,                                  //3rd    

//	output reg [3:0] current_state,      //1st
//	output reg [6:0] iter_count,         //1st
	output reg [6:0] ones_count,
    output reg [63:0] resp_out,
    output reg [63:0] trng_out,
//	output [1:0] trng_bit_pair,
//    output reg [7:0] post_process_count,
//	output reg add_en,
//	output reg sub_en,
//	output reg [15:0] C_L_trng_msb,
//	output reg [15:0] C_R_trng_msb,
	output reg done,
	output reg [16:0] trng_iterations,
//	output reg trng_trig,
//	output ff1_out,
    output  resp
//    output reg puf_trig
//	output [63:0] C_L_in
//	output [63:0] C_R_in
    );
    
	wire sig_C;
	reg puf_trig;
//	wire resp;
	
	wire [63:0] C_L_in;
	wire [63:0] C_R_in;
//	reg [63:0] resp_out; 
//PRNG circuit buses and signals 
	reg [63:0] lfsr_reg;
	wire feedback;
	reg [6:0] lfsr_counter;
	
	//FSM States for PUF CRP
	parameter IDLE 		= 4'd0;
	parameter PRNG 		= 4'd1;
	parameter PUF_EN 	= 4'd2;
	parameter WAIT		= 4'd3;
	parameter PUF_RESP	= 4'd4;
	parameter VOTER		= 4'd5;
	parameter LFSR_SHIFT= 4'd6;
	parameter FINAL		= 4'd7;
	//FSM states for PUF TRNG (State traversal should look like 0->(8->2->3->4->9)repeated 64 times. last (9->10->0)
	parameter TRNG      		= 4'd8;
	parameter TRNG_POST_PROCESS	= 4'd9;
	parameter TRNG_CHECK		= 4'd10;
	
	reg idle;
	reg prng;
	reg puf_en;
	reg wait0;
	reg puf_resp;
	reg voter;
	reg lfsr_shift;
	reg final0;
	reg trng;
	reg trng_post_process;
	reg trng_check;
	
	
	parameter RESP_LENGTH = 7'd64;		//length of output responses
	parameter ITERATIONS  = 7'd10;		//Total iterations to get one resp bit
	parameter MAJORITY_VOTE = 7'd5;		//voting for one or zero for a single bit resp
	
	
	reg [3:0] current_state;
	reg [3:0] next_state;
	
	reg [6:0] iter_count;
	reg [6:0] maj_count;
	reg resp_final;
	
    //signals for TRNG operation
	wire [1:0] trng_bit_pair;
	reg [7:0] post_process_count;
	
//	reg [6:0] ones_count;
	
	reg [16:0] C_L_trng_msb;
	reg [16:0] C_R_trng_msb;
	reg add_en;
	reg sub_en;
	
	
	
	
	
////////////////////////////////////////////////////////////////
//////////FSM for testing of PUF circuit////////////////////////
////////////////////////////////////////////////////////////////
	always@(posedge mclk or posedge rst)
	begin
		if(rst)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end
	
	always@(*)
	begin
		case(current_state)
			IDLE:				//0
			begin
			    idle = 1;
			    prng = 0;
			    puf_en = 0;
			    wait0 = 0;
			    puf_resp = 0 ;
			    voter = 0;
			    lfsr_shift = 0;
			    final0 = 0;
			    trng = 0;
			    trng_post_process = 0;
			    trng_check = 0;
	
				puf_trig = 0;
				resp_final = 0;
				done = 0;
				
				add_en = 0;
				sub_en = 0;
				
				if(en_pulse)
					next_state = PRNG;
			    else if(en_pulse_trng)       //go to TRNG state in en is for trng
			        next_state = TRNG;
				else
					next_state = IDLE;
			end
			
			
			PRNG:				//1	        //only PUF-CRP state
			begin
				idle = 0;
			    prng = 1;
			    puf_en = 0;
			    wait0 = 0;
			    puf_resp = 0 ;
			    voter = 0;
			    lfsr_shift = 0;
			    final0 = 0;
			    trng = 0;
			    trng_post_process = 0;
			    trng_check = 0;
				
				puf_trig = 0;
				resp_final = 0;
				done = 0;

				add_en = 0;
				sub_en = 0;
				
				next_state = PUF_EN;
			end
			
			
			TRNG:                  //8          //only TRNG state
			begin
				idle = 0;
			    prng = 0;
			    puf_en = 0;
			    wait0 = 0;
			    puf_resp = 0 ;
			    voter = 0;
			    lfsr_shift = 0;
			    final0 = 0;
			    trng = 1;
			    trng_post_process = 0;
			    trng_check = 0;
				
			    puf_trig = 0;
				resp_final = 0;
				done = 0;
				
				add_en = 0;
				sub_en = 0;
				
			    next_state = PUF_EN;
			end
			
			
			
			PUF_EN:				//2			//shared state
			begin
				idle = 0;
			    prng = 0;
			    puf_en = 1;
			    wait0 = 0;
			    puf_resp = 0 ;
			    voter = 0;
			    lfsr_shift = 0;
			    final0 = 0;
			    trng = 0;
			    trng_post_process = 0;
			    trng_check = 0;
				
				puf_trig = 1;
				resp_final = 0;
				done = 0;
				
				add_en = 0;
				sub_en = 0;

				next_state = WAIT;	
			end
			
			
			WAIT:				//3			//shared state
			begin
				idle = 0;
			    prng = 0;
			    puf_en = 0;
			    wait0 = 1;
			    puf_resp = 0 ;
			    voter = 0;
			    lfsr_shift = 0;
			    final0 = 0;
			    trng = 0;
			    trng_post_process = 0;
			    trng_check = 0;
				
				puf_trig = 0;
				resp_final = 0;
				done = 0;
				
				add_en = 0;
				sub_en = 0;
				
				next_state = PUF_RESP;
			end
			
			
			PUF_RESP:			//4			//shared state
			begin
				idle = 0;
			    prng = 0;
			    puf_en = 0;
			    wait0 = 0;
			    puf_resp = 1;
			    voter = 0;
			    lfsr_shift = 0;
			    final0 = 0;
			    trng = 0;
			    trng_post_process = 0;
			    trng_check = 0;
				
				puf_trig = 0;
				resp_final = 0;
				done = 0;
				
				add_en = 0;
				sub_en = 0;
				
				
				if((iter_count < ITERATIONS) && (!trng_trig))			//take a single bit response 'ITERATIONS' times and do majority vote for PUF CRP
					next_state = PUF_EN;
				else if((trng_trig) && (iter_count < 7'd64))			//generate 2 bits for the TRNG
					next_state = TRNG_POST_PROCESS;
				else if((trng_trig) && (iter_count == 7'd64))
					next_state = TRNG_CHECK;
				else
					next_state = VOTER;
			end
			
			
			TRNG_POST_PROCESS:		//9
			begin
				idle = 0;
			    prng = 0;
			    puf_en = 0;
			    wait0 = 0;
			    puf_resp = 0 ;
			    voter = 0;
			    lfsr_shift = 0;
			    final0 = 0;
			    trng = 0;
			    trng_post_process = 1;
			    trng_check = 0;
				
				puf_trig = 0;
				resp_final = 0;
				done = 0;
				
				add_en = 0;
				sub_en = 0;
				
				next_state = PUF_EN;
			end
				
			
			
			TRNG_CHECK:			//10			//TRNG only state. Check whether the post process count finished or not
			begin
				idle = 0;
			    prng = 0;
			    puf_en = 0;
			    wait0 = 0;
			    puf_resp = 0 ;
			    voter = 0;
			    lfsr_shift = 0;
			    final0 = 0;
			    trng = 0;
			    trng_post_process = 0;
			    trng_check = 1;
				
				puf_trig = 0;
				resp_final = 0;
				done = 0;
				
				if(post_process_count < 7'd64)
				begin
					if(ones_count > 7'd40)
					begin
						add_en = 0;
						sub_en = 1;
					end
					else if(ones_count < 7'd30)
					begin
						add_en = 1;
						sub_en = 0;
					end
					else
					begin
						add_en = 0;
						sub_en = 0;
					end
					next_state = TRNG;
				end
				else
				begin
					add_en = 0;
					sub_en = 0;
					next_state = FINAL;
				end
			end
							
			
			VOTER:         		//5
			begin
				idle = 0;
			    prng = 0;
			    puf_en = 0;
			    wait0 = 0;
			    puf_resp = 0 ;
			    voter = 1;
			    lfsr_shift = 0;
			    final0 = 0;
			    trng = 0;
			    trng_post_process = 0;
			    trng_check = 0;
				
				puf_trig = 0;
				if(maj_count > MAJORITY_VOTE)
					resp_final = 1;
				else
					resp_final = 0;
				done = 0;
				
				add_en = 0;
				sub_en = 0;
						
				next_state = LFSR_SHIFT;
			end
			
			
			LFSR_SHIFT:         //6
			begin
				idle = 0;
			    prng = 0;
			    puf_en = 0;
			    wait0 = 0;
			    puf_resp = 0 ;
			    voter = 0;
			    lfsr_shift = 1;
			    final0 = 0;
			    trng = 0;
			    trng_post_process = 0;
			    trng_check = 0;
				
                puf_trig = 0;
                done = 0;
                resp_final = 0;
				
				add_en = 0;
				sub_en = 0;
				if(lfsr_counter < RESP_LENGTH)
					next_state = PRNG;
				else
					next_state = FINAL;
			end				
			
			FINAL:				//7
			begin
				idle = 0;
			    prng = 0;
			    puf_en = 0;
			    wait0 = 0;
			    puf_resp = 0 ;
			    voter = 0;
			    lfsr_shift = 0;
			    final0 = 1;
			    trng = 0;
			    trng_post_process = 0;
			    trng_check = 0;
				
				puf_trig = 0;
				done = 1;
				resp_final = 0;
			
				add_en = 0;
				sub_en = 0;
				
				next_state = IDLE;
			end
		endcase
	end
////////////////////////////////////////////////////////////////


	
////////////////////////////////////////////////////////////////
////////////////////Majority voter and iteration circuit////////
////////////////////////////////////////////////////////////////	

//wire prng_trng = prng|trng;

	always@(posedge mclk)
	begin
		if(idle)
		begin
			iter_count <= 7'd0;
			maj_count <= 7'd0;
		end
		
		else if(prng)
		begin
			iter_count <= 7'd0;
			maj_count  <= 7'd0;
		end
		
		else if(wait0)
		begin
			iter_count <= iter_count + 1'd1;
			maj_count  <= maj_count;
		end
		
		else if(puf_resp && (!trng_trig))
		begin
			iter_count <= iter_count;
			if(resp == 1)
				maj_count <= maj_count + 1'd1;
			else
				maj_count <= maj_count;
		end
		
		else if(trng)
		begin
			iter_count <= 7'd0;
			maj_count  <= 7'd0;
		end
		
		else
		begin
			iter_count <= iter_count;
			maj_count  <= maj_count;
		end
		
	end
////////////////////////////////////////////////////////////////
	

////////////////////////////////////////////////////////////////
///////////////	Instantiate the PUF ////////////////////////////
////////////////////////////////////////////////////////////////
	//trig FF
//	FD#(.INIT(1'b0))
//	trig_C(.Q(sig_C),.C(mclk),.D(puf_trig));	
	
	PUF PUF_inst (
    //inputs
		.mclk(mclk)
		,.sig_C(puf_trig/*sig_C*/)
		,.trng_trig(trng_trig)
		,.C_L_in_reg(C_L_in)
		,.C_R_in_reg(C_R_in)
		,.C_in_reg(lfsr_reg)
		,.T_C_L(T_C_L)
		,.T_C_R(T_C_R)
		,.T_R_L(T_R_L)
		,.T_R_R(T_R_R)
    //outputs
 //       ,.ff1_out(ff1_out)
 //       ,.ff2_out(ff2_out)
		,.resp(resp)
    );	
////////////////////////////////////////////////////////////////


assign C_L_in = trng_trig? {C_L_trng_msb,C_in_trng}:lfsr_reg;
assign C_R_in = trng_trig? {C_R_trng_msb,C_in_trng}:lfsr_reg;
 
//////////////////////////////////////////////////////////////////////////////////
/////////////////Random PRNG circuit for generation of subchallenges//////////////
//////////////////////////////////////////////////////////////////////////////////
//(Characteristic/primitive poly1 ( x^64 + x^4 + x^3 + x + 1)) Maximum length LFSR //https://www.ams.org/journals/mcom/1962-16-079/S0025-5718-1962-0148256-1/S0025-5718-1962-0148256-1.pdf
//-> Currently used(Characteristic/primitive poly2 with xnor ( x^64 + x^63 + x^61 + x^60)) Maximum length LFSR //https://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
	assign feedback = (((lfsr_reg[63] ~^ lfsr_reg[62]) ~^ lfsr_reg[60]) ~^ lfsr_reg[59]);
	always@(posedge mclk)
	begin
		if(idle)
		begin
			lfsr_reg <= C_in;
			lfsr_counter <= 7'd0;
		end
		
		else if(prng)
		begin
			lfsr_reg <= {lfsr_reg[62:0],feedback};
			lfsr_counter <= lfsr_counter;
		end
		
		else if(voter)
		begin
			lfsr_reg <= lfsr_reg;
			lfsr_counter <= lfsr_counter + 1'd1;
		end
		
		else
		begin
			lfsr_reg <= lfsr_reg;
			lfsr_counter <= lfsr_counter;
		end
	end
//////////////////////////////////////////////////////////////////////////////////
	
	
 /////////////////////////////////////////////////////////////////////////////////
 ///////////////////Output response register shifter//////////////////////////////
 /////////////////////////////////////////////////////////////////////////////////
	always@(posedge mclk)
	begin
		if(idle)
		begin
		    resp_out <= 64'd0;
		    ones_count <= 7'd0;
		end
		
		else if(voter)
		begin
		    if(resp_final == 1)
		      ones_count <= ones_count + 1'd1;
		    else
		      ones_count <= ones_count;
			resp_out  <= {resp_final,resp_out[63:1]};
		end
		
		else if(puf_resp && (trng_trig))
		begin
			if(resp == 1)
				ones_count <= ones_count + 1'd1;
			else
				ones_count <= ones_count;
			resp_out <= {resp,resp_out[63:1]};
		end
		
		else if(trng)
		begin
			ones_count <= 7'd0;
			resp_out <= resp_out;
		end
		
		else
		begin
			resp_out <= resp_out;
			ones_count <= ones_count;
		end
	end
	
	
 /////////////////////////////////////////////////////////////////////////////////
 ///////////////TRNG Post Processing filter (Von Neuman)//////////////////////////
 /////////////////////////////////////////////////////////////////////////////////
	//will merge this entire block later. Don't need trng_out register. Resp_out can be used for trng output as well
	assign trng_bit_pair = resp_out[63:62]; 
	
	always@(posedge mclk)
	begin
		if(idle)
		begin
			post_process_count <= 7'd0;
			trng_out <= 64'd0;
		end
		
		else if(trng_post_process && (iter_count[0] == 1'b0))
		begin
			if(trng_bit_pair == 2'b01)
			begin
				post_process_count <= post_process_count + 1'd1;
				trng_out <= {1'b0,trng_out[63:1]};
			end
			else if(trng_bit_pair == 2'b10)
			begin
				post_process_count <= post_process_count + 1'd1;
				trng_out <= {1'b1,trng_out[63:1]};
			end
			else
			begin
				post_process_count <= post_process_count;
				trng_out <= trng_out;
			end
		end
		else
		begin
			post_process_count <= post_process_count;
			trng_out <= trng_out;
		end
	end
/////////////////////////////////////////////////////////////////////////////////				
			
/////////////////////////////////////////////////////////////////////////////////
///////////////////////////addr/subtrctr/////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
	always@(posedge mclk or posedge rst)
	begin
		if(rst)
		begin
			C_R_trng_msb <= 16'd65535;
			C_L_trng_msb <= 16'd0;
		end
		
		else if(idle)
		begin
			C_R_trng_msb <= C_R_trng_msb;
			C_L_trng_msb <= C_L_trng_msb;
		end
		
		else if(trng_check && sub_en)
		begin
			C_L_trng_msb <= C_L_trng_msb + 16'd50;
			C_R_trng_msb <= C_R_trng_msb;//- 16'd50;
		end
		
		else if(trng_check && add_en)
		begin
			C_L_trng_msb <= C_L_trng_msb;// 16'd50;
			C_R_trng_msb <= C_R_trng_msb - 16'd50;
		end
		
		else
		begin
			C_L_trng_msb <= C_L_trng_msb;
			C_R_trng_msb <= C_R_trng_msb;
		end
	end
/////////////////////////////////////////////////////////////////////////////////


//test counter to see when trng produces final result
	always@(posedge mclk)
	begin
		if(idle)
			trng_iterations <= 17'd0;
		else if(trng==1'b1)
			trng_iterations <= trng_iterations + 1'd1;
		else
			trng_iterations <= trng_iterations;
	end
	
	
 /////////////////////////////////////////////////////////////////////////////////


	 
endmodule
