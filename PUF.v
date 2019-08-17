`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mahmood Azhar Qureshi
// 
// Create Date: 07/01/2019 02:04:53 PM
// Design Name: 
// Module Name: PUF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:	This module implements the outline of the 2-1DAPUF circuit including the trigger FFs and Arbiter FF. An XOR operation is performed at the output of arbiter FFs 
// 
//////////////////////////////////////////////////////////////////////////////////


module PUF(
	input mclk,
//	input rst,
    input sig_C,
	input trng_trig,
    input [63:0]C_L_in_reg,
    input [63:0]C_R_in_reg,
	input [63:0]C_in_reg,
	input [7:0] T_C_L,
	input [7:0] T_C_R,
	input [7:0] T_R_L,
	input [7:0] T_R_R,
//	output ff1_out,
//	output ff2_out,
    output resp
    );

//4 individual trigger FFs
	wire sig_1;
	wire sig_2;
	wire sig_3;
	wire sig_4;
	

	
	(* BEL = "D5FF" *) (* LOC = "SLICE_X111Y250" *)
        FD#(.INIT(1'b0))
        trig_3(.Q(sig_1),.C(mclk),.D(sig_C));
        
    (* BEL = "D5FF" *) (* LOC = "SLICE_X115Y250" *)
        FD#(.INIT(1'b0))
        trig_4(.Q(sig_2),.C(mclk),.D(sig_C));
            
    (* BEL = "D5FF" *) (* LOC = "SLICE_X119Y250" *)
        FD#(.INIT(1'b0))
        trig_5(.Q(sig_3),.C(mclk),.D(sig_C));

    (* BEL = "D5FF" *) (* LOC = "SLICE_X123Y250" *)
	    FD#(.INIT(1'b0))
	    trig_6(.Q(sig_4),.C(mclk),.D(sig_C));
	
	
/*	PUF_left PUF_left_inst(
	   .sig_1(sig_1)
	   ,.sig_2(sig_2)
	   ,.C_L_in_reg(C_L_in_reg)
	   ,.C_R_in_reg(C_R_in_reg)
	   ,.T_L_in(T_L_L)
	   ,.T_R_in(T_L_R)
	   ,.O_1_68(O_L_L)
	   ,.O_2_68(O_L_R)
	   );
*/	
	PUF_center PUF_center_inst(				//challenge input MUXed with TRNG
       .sig_3(sig_1)
       ,.sig_4(sig_2)
       ,.C_L_in_reg(C_L_in_reg)				
	   ,.C_R_in_reg(C_R_in_reg)
       ,.T_L_in(T_C_L)
       ,.T_R_in(T_C_R)
       ,.O_1_72(O_C_L)
       ,.O_2_72(O_C_R)
       );
	
	PUF_right PUF_right_inst(
       .sig_5(sig_3)
       ,.sig_6(sig_4)
       ,.C_in_reg(C_in_reg)
       ,.T_L_in(T_R_L)
       ,.T_R_in(T_R_R)
       ,.O_1_72(O_R_L)
       ,.O_2_72(O_R_R)
       );
              



//Arbiter FF1 (Chain1_left <-> Chain2_left)
wire ff1_out;
FD#(.INIT(1'b0))
FD1_inst(.Q(ff1_out),.C(O_C_L),.D(O_R_L));
	
//Arbiter FF2 (Chain1_right <-> Chain2_right)
wire ff2_out;
FD#(.INIT(1'b0))
FD2_inst(.Q(ff2_out),.C(O_C_R),.D(O_R_R));
        

/*
(* dont_touch = "yes" *) (* allow_combinatorial_loops = "yes" *) wire ff1_out;
	(* BEL = "A6LUT" *) (* LOC = "SLICE_X114Y287" *)
		LUT3#(.INIT(8'h54))
		LUT3_arbiter1_inst(.O(ff1_out),.I0(O_C_L),.I1(ff1_out),.I2(O_R_L));

(* dont_touch = "yes" *) (* allow_combinatorial_loops = "yes" *) wire ff2_out;
	(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y287" *)
		LUT3#(.INIT(8'h54))
		LUT3_arbiter2_inst(.O(ff2_out),.I0(O_C_R),.I1(ff2_out),.I2(O_R_R));
*/

/*	(* BEL = "AFF" *) (* LOC = "SLICE_X100Y259" *)
	FD#(.INIT(1'b0))
	FD_inst(.Q(resp),.C(mclk),.D(ff_out));

wire ff1_out;
wire Qn_int;
 
assign  ff1_out = ~(O_C_L | Qn_int);
assign  Qn_int = ~(O_R_L | ff1_out);
*/
//XORing the 2 arbiter outputs and registering the final response
wire xor_out;
(* BEL = "A6LUT" *) (* LOC = "SLICE_X116Y288" *)
   LUT3#(.INIT(8'ha6))
   XOR_LUT(.O(xor_out),.I0(ff1_out),.I1(ff2_out),.I2(trng_trig));
   
(* BEL = "AFF" *) (* LOC = "SLICE_X116Y288" *)
    FD#(.INIT(1'b0))
    FD3_inst(.Q(resp),.C(mclk),.D(xor_out));
	
endmodule
