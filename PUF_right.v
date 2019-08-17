`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mahmood Azhar Qureshi
// 
// Create Date: 07/10/2019 03:35:19 PM
// Design Name: 
// Module Name: PUF_right
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:	This module implements the right chain of the DAPUF. Floorplanning was done to ensure symmteric routing.
// 
//////////////////////////////////////////////////////////////////////////////////


module PUF_right(
    input sig_5,
    input sig_6,
    input [63:0] C_in_reg,
	input [7:0] T_L_in,
	input [7:0] T_R_in,
    output O_1_72,
    output O_2_72
    );
    
    
///////////////////////////////////////////////////Left PDL chain
        
        //SLICE_X118Y251
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y251" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_1(.O(O_1_1),.I0(sig_5),.I1(C_in_reg[0]),.I2(C_in_reg[0]),.I3(C_in_reg[0]),.I4(C_in_reg[0]),.I5(C_in_reg[0]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y251" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_2(.O(O_1_2),.I0(O_1_1),.I1(C_in_reg[1]),.I2(C_in_reg[1]),.I3(C_in_reg[1]),.I4(C_in_reg[1]),.I5(C_in_reg[1]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y252" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_3(.O(O_1_3),.I0(O_1_2),.I1(C_in_reg[2]),.I2(C_in_reg[2]),.I3(C_in_reg[2]),.I4(C_in_reg[2]),.I5(C_in_reg[2]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y252" *) (* LOCK_PINS = "I0:A3" *)    
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_4(.O(O_1_4),.I0(O_1_3),.I1(C_in_reg[3]),.I2(C_in_reg[3]),.I3(C_in_reg[3]),.I4(C_in_reg[3]),.I5(C_in_reg[3]));    
        //SLICE_X119Y251
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y253" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_5(.O(O_1_5),.I0(O_1_4),.I1(C_in_reg[4]),.I2(C_in_reg[4]),.I3(C_in_reg[4]),.I4(C_in_reg[4]),.I5(C_in_reg[4]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y253" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_6(.O(O_1_6),.I0(O_1_5),.I1(C_in_reg[5]),.I2(C_in_reg[5]),.I3(C_in_reg[5]),.I4(C_in_reg[5]),.I5(C_in_reg[5]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y254" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_7(.O(O_1_7),.I0(O_1_6),.I1(C_in_reg[6]),.I2(C_in_reg[6]),.I3(C_in_reg[6]),.I4(C_in_reg[6]),.I5(C_in_reg[6]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y254" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_8(.O(O_1_8),.I0(O_1_7),.I1(C_in_reg[7]),.I2(C_in_reg[7]),.I3(C_in_reg[7]),.I4(C_in_reg[7]),.I5(C_in_reg[7]));
        
        //SLICE_X118Y252
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y255" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_9(.O(O_1_9),.I0(O_1_8),.I1(C_in_reg[8]),.I2(C_in_reg[8]),.I3(C_in_reg[8]),.I4(C_in_reg[8]),.I5(C_in_reg[8]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y255" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_10(.O(O_1_10),.I0(O_1_9),.I1(C_in_reg[9]),.I2(C_in_reg[9]),.I3(C_in_reg[9]),.I4(C_in_reg[9]),.I5(C_in_reg[9]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y256" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_11(.O(O_1_11),.I0(O_1_10),.I1(C_in_reg[10]),.I2(C_in_reg[10]),.I3(C_in_reg[10]),.I4(C_in_reg[10]),.I5(C_in_reg[10]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y256" *)     (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_12(.O(O_1_12),.I0(O_1_11),.I1(C_in_reg[11]),.I2(C_in_reg[11]),.I3(C_in_reg[11]),.I4(C_in_reg[11]),.I5(C_in_reg[11]));
        //SLICE_X119Y252
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y257" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_13(.O(O_1_13),.I0(O_1_12),.I1(C_in_reg[12]),.I2(C_in_reg[12]),.I3(C_in_reg[12]),.I4(C_in_reg[12]),.I5(C_in_reg[12]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y257" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_14(.O(O_1_14),.I0(O_1_13),.I1(C_in_reg[13]),.I2(C_in_reg[13]),.I3(C_in_reg[13]),.I4(C_in_reg[13]),.I5(C_in_reg[13]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y258" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_15(.O(O_1_15),.I0(O_1_14),.I1(C_in_reg[14]),.I2(C_in_reg[14]),.I3(C_in_reg[14]),.I4(C_in_reg[14]),.I5(C_in_reg[14]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y258" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_16(.O(O_1_16),.I0(O_1_15),.I1(C_in_reg[15]),.I2(C_in_reg[15]),.I3(C_in_reg[15]),.I4(C_in_reg[15]),.I5(C_in_reg[15]));        
        
        //SLICE_X118Y253
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y259" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_17(.O(O_1_17),.I0(O_1_16),.I1(C_in_reg[16]),.I2(C_in_reg[16]),.I3(C_in_reg[16]),.I4(C_in_reg[16]),.I5(C_in_reg[16]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y259" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_18(.O(O_1_18),.I0(O_1_17),.I1(C_in_reg[17]),.I2(C_in_reg[17]),.I3(C_in_reg[17]),.I4(C_in_reg[17]),.I5(C_in_reg[17]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y260" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_19(.O(O_1_19),.I0(O_1_18),.I1(C_in_reg[18]),.I2(C_in_reg[18]),.I3(C_in_reg[18]),.I4(C_in_reg[18]),.I5(C_in_reg[18]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y260" *) (* LOCK_PINS = "I0:A3" *)    
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_20(.O(O_1_20),.I0(O_1_19),.I1(C_in_reg[19]),.I2(C_in_reg[19]),.I3(C_in_reg[19]),.I4(C_in_reg[19]),.I5(C_in_reg[19]));    
        //SLICE_X119Y253
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y261" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_21(.O(O_1_21),.I0(O_1_20),.I1(C_in_reg[20]),.I2(C_in_reg[20]),.I3(C_in_reg[20]),.I4(C_in_reg[20]),.I5(C_in_reg[20]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y261" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_22(.O(O_1_22),.I0(O_1_21),.I1(C_in_reg[21]),.I2(C_in_reg[21]),.I3(C_in_reg[21]),.I4(C_in_reg[21]),.I5(C_in_reg[21]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y262" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_23(.O(O_1_23),.I0(O_1_22),.I1(C_in_reg[22]),.I2(C_in_reg[22]),.I3(C_in_reg[22]),.I4(C_in_reg[22]),.I5(C_in_reg[22]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y262" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_24(.O(O_1_24),.I0(O_1_23),.I1(C_in_reg[23]),.I2(C_in_reg[23]),.I3(C_in_reg[23]),.I4(C_in_reg[23]),.I5(C_in_reg[23]));
        
        //SLICE_X118Y254
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y263" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_25(.O(O_1_25),.I0(O_1_24),.I1(C_in_reg[24]),.I2(C_in_reg[24]),.I3(C_in_reg[24]),.I4(C_in_reg[24]),.I5(C_in_reg[24]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y263" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_26(.O(O_1_26),.I0(O_1_25),.I1(C_in_reg[25]),.I2(C_in_reg[25]),.I3(C_in_reg[25]),.I4(C_in_reg[25]),.I5(C_in_reg[25]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y264" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_27(.O(O_1_27),.I0(O_1_26),.I1(C_in_reg[26]),.I2(C_in_reg[26]),.I3(C_in_reg[26]),.I4(C_in_reg[26]),.I5(C_in_reg[26]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y264" *)     (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_28(.O(O_1_28),.I0(O_1_27),.I1(C_in_reg[27]),.I2(C_in_reg[27]),.I3(C_in_reg[27]),.I4(C_in_reg[27]),.I5(C_in_reg[27]));
        //SLICE_X119Y254
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y265" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_29(.O(O_1_29),.I0(O_1_28),.I1(C_in_reg[28]),.I2(C_in_reg[28]),.I3(C_in_reg[28]),.I4(C_in_reg[28]),.I5(C_in_reg[28]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y265" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_30(.O(O_1_30),.I0(O_1_29),.I1(C_in_reg[29]),.I2(C_in_reg[29]),.I3(C_in_reg[29]),.I4(C_in_reg[29]),.I5(C_in_reg[29]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y266" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_31(.O(O_1_31),.I0(O_1_30),.I1(C_in_reg[30]),.I2(C_in_reg[30]),.I3(C_in_reg[30]),.I4(C_in_reg[30]),.I5(C_in_reg[30]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y266" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_1_32(.O(O_1_32),.I0(O_1_31),.I1(C_in_reg[31]),.I2(C_in_reg[31]),.I3(C_in_reg[31]),.I4(C_in_reg[31]),.I5(C_in_reg[31]));
				
			
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y267" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_33(.O(O_1_33),.I0(O_1_32),.I1(C_in_reg[32]),.I2(C_in_reg[32]),.I3(C_in_reg[32]),.I4(C_in_reg[32]),.I5(C_in_reg[32]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y267" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_34(.O(O_1_34),.I0(O_1_33),.I1(C_in_reg[33]),.I2(C_in_reg[33]),.I3(C_in_reg[33]),.I4(C_in_reg[33]),.I5(C_in_reg[33]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y268" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_35(.O(O_1_35),.I0(O_1_34),.I1(C_in_reg[34]),.I2(C_in_reg[34]),.I3(C_in_reg[34]),.I4(C_in_reg[34]),.I5(C_in_reg[34]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y268" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_36(.O(O_1_36),.I0(O_1_35),.I1(C_in_reg[35]),.I2(C_in_reg[35]),.I3(C_in_reg[35]),.I4(C_in_reg[35]),.I5(C_in_reg[35]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y269" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_37(.O(O_1_37),.I0(O_1_36),.I1(C_in_reg[36]),.I2(C_in_reg[36]),.I3(C_in_reg[36]),.I4(C_in_reg[36]),.I5(C_in_reg[36]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y269" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_38(.O(O_1_38),.I0(O_1_37),.I1(C_in_reg[37]),.I2(C_in_reg[37]),.I3(C_in_reg[37]),.I4(C_in_reg[37]),.I5(C_in_reg[37]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y270" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_39(.O(O_1_39),.I0(O_1_38),.I1(C_in_reg[38]),.I2(C_in_reg[38]),.I3(C_in_reg[38]),.I4(C_in_reg[38]),.I5(C_in_reg[38]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y270" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_40(.O(O_1_40),.I0(O_1_39),.I1(C_in_reg[39]),.I2(C_in_reg[39]),.I3(C_in_reg[39]),.I4(C_in_reg[39]),.I5(C_in_reg[39]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y271" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_41(.O(O_1_41),.I0(O_1_40),.I1(C_in_reg[40]),.I2(C_in_reg[40]),.I3(C_in_reg[40]),.I4(C_in_reg[40]),.I5(C_in_reg[40]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y271" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_42(.O(O_1_42),.I0(O_1_41),.I1(C_in_reg[41]),.I2(C_in_reg[41]),.I3(C_in_reg[41]),.I4(C_in_reg[41]),.I5(C_in_reg[41]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y272" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_43(.O(O_1_43),.I0(O_1_42),.I1(C_in_reg[42]),.I2(C_in_reg[42]),.I3(C_in_reg[42]),.I4(C_in_reg[42]),.I5(C_in_reg[42]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y272" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_44(.O(O_1_44),.I0(O_1_43),.I1(C_in_reg[43]),.I2(C_in_reg[43]),.I3(C_in_reg[43]),.I4(C_in_reg[43]),.I5(C_in_reg[43]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y273" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_45(.O(O_1_45),.I0(O_1_44),.I1(C_in_reg[44]),.I2(C_in_reg[44]),.I3(C_in_reg[44]),.I4(C_in_reg[44]),.I5(C_in_reg[44]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y273" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_46(.O(O_1_46),.I0(O_1_45),.I1(C_in_reg[45]),.I2(C_in_reg[45]),.I3(C_in_reg[45]),.I4(C_in_reg[45]),.I5(C_in_reg[45]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y274" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_47(.O(O_1_47),.I0(O_1_46),.I1(C_in_reg[46]),.I2(C_in_reg[46]),.I3(C_in_reg[46]),.I4(C_in_reg[46]),.I5(C_in_reg[46]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y274" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_48(.O(O_1_48),.I0(O_1_47),.I1(C_in_reg[47]),.I2(C_in_reg[47]),.I3(C_in_reg[47]),.I4(C_in_reg[47]),.I5(C_in_reg[47]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y275" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_49(.O(O_1_49),.I0(O_1_48),.I1(C_in_reg[48]),.I2(C_in_reg[48]),.I3(C_in_reg[48]),.I4(C_in_reg[48]),.I5(C_in_reg[48]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y275" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_50(.O(O_1_50),.I0(O_1_49),.I1(C_in_reg[49]),.I2(C_in_reg[49]),.I3(C_in_reg[49]),.I4(C_in_reg[49]),.I5(C_in_reg[49]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y276" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_51(.O(O_1_51),.I0(O_1_50),.I1(C_in_reg[50]),.I2(C_in_reg[50]),.I3(C_in_reg[50]),.I4(C_in_reg[50]),.I5(C_in_reg[50]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y276" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_52(.O(O_1_52),.I0(O_1_51),.I1(C_in_reg[51]),.I2(C_in_reg[51]),.I3(C_in_reg[51]),.I4(C_in_reg[51]),.I5(C_in_reg[51]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y277" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_53(.O(O_1_53),.I0(O_1_52),.I1(C_in_reg[52]),.I2(C_in_reg[52]),.I3(C_in_reg[52]),.I4(C_in_reg[52]),.I5(C_in_reg[52]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y277" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_54(.O(O_1_54),.I0(O_1_53),.I1(C_in_reg[53]),.I2(C_in_reg[53]),.I3(C_in_reg[53]),.I4(C_in_reg[53]),.I5(C_in_reg[53]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y278" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_55(.O(O_1_55),.I0(O_1_54),.I1(C_in_reg[54]),.I2(C_in_reg[54]),.I3(C_in_reg[54]),.I4(C_in_reg[54]),.I5(C_in_reg[54]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y278" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_56(.O(O_1_56),.I0(O_1_55),.I1(C_in_reg[55]),.I2(C_in_reg[55]),.I3(C_in_reg[55]),.I4(C_in_reg[55]),.I5(C_in_reg[55]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y279" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_57(.O(O_1_57),.I0(O_1_56),.I1(C_in_reg[56]),.I2(C_in_reg[56]),.I3(C_in_reg[56]),.I4(C_in_reg[56]),.I5(C_in_reg[56]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y279" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_58(.O(O_1_58),.I0(O_1_57),.I1(C_in_reg[57]),.I2(C_in_reg[57]),.I3(C_in_reg[57]),.I4(C_in_reg[57]),.I5(C_in_reg[57]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y280" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_59(.O(O_1_59),.I0(O_1_58),.I1(C_in_reg[58]),.I2(C_in_reg[58]),.I3(C_in_reg[58]),.I4(C_in_reg[58]),.I5(C_in_reg[58]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y280" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_60(.O(O_1_60),.I0(O_1_59),.I1(C_in_reg[59]),.I2(C_in_reg[59]),.I3(C_in_reg[59]),.I4(C_in_reg[59]),.I5(C_in_reg[59]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y281" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_61(.O(O_1_61),.I0(O_1_60),.I1(C_in_reg[60]),.I2(C_in_reg[60]),.I3(C_in_reg[60]),.I4(C_in_reg[60]),.I5(C_in_reg[60]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y281" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_62(.O(O_1_62),.I0(O_1_61),.I1(C_in_reg[61]),.I2(C_in_reg[61]),.I3(C_in_reg[61]),.I4(C_in_reg[61]),.I5(C_in_reg[61]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y282" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_63(.O(O_1_63),.I0(O_1_62),.I1(C_in_reg[62]),.I2(C_in_reg[62]),.I3(C_in_reg[62]),.I4(C_in_reg[62]),.I5(C_in_reg[62]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y282" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_64(.O(O_1_64),.I0(O_1_63),.I1(C_in_reg[63]),.I2(C_in_reg[63]),.I3(C_in_reg[63]),.I4(C_in_reg[63]),.I5(C_in_reg[63]));
            
			
		//Tuner PDLs
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y283" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_65(.O(O_1_65),.I0(O_1_64),.I1(T_L_in[0]),.I2(T_L_in[0]),.I3(T_L_in[0]),.I4(T_L_in[0]),.I5(T_L_in[0]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y283" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_66(.O(O_1_66),.I0(O_1_65),.I1(T_L_in[1]),.I2(T_L_in[1]),.I3(T_L_in[1]),.I4(T_L_in[1]),.I5(T_L_in[1]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y284" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_67(.O(O_1_67),.I0(O_1_66),.I1(T_L_in[2]),.I2(T_L_in[2]),.I3(T_L_in[2]),.I4(T_L_in[2]),.I5(T_L_in[2]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y284" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_68(.O(O_1_68),.I0(O_1_67),.I1(T_L_in[3]),.I2(T_L_in[3]),.I3(T_L_in[3]),.I4(T_L_in[3]),.I5(T_L_in[3]));
			
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y285" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_69(.O(O_1_69),.I0(O_1_68),.I1(T_L_in[4]),.I2(T_L_in[4]),.I3(T_L_in[4]),.I4(T_L_in[4]),.I5(T_L_in[4]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y285" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_70(.O(O_1_70),.I0(O_1_69),.I1(T_L_in[5]),.I2(T_L_in[5]),.I3(T_L_in[5]),.I4(T_L_in[5]),.I5(T_L_in[5]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X118Y286" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_71(.O(O_1_71),.I0(O_1_70),.I1(T_L_in[6]),.I2(T_L_in[6]),.I3(T_L_in[6]),.I4(T_L_in[6]),.I5(T_L_in[6]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X119Y286" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_1_72(.O(O_1_72),.I0(O_1_71),.I1(T_L_in[7]),.I2(T_L_in[7]),.I3(T_L_in[7]),.I4(T_L_in[7]),.I5(T_L_in[7]));
        ///////////////////////////////////////////////////End of left chain PDL    
        
            
        ///////////////////////////////////////////////////Right chain PDL    
        //SLICE_X122Y251
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y251" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_1(.O(O_2_1),.I0(sig_6),.I1(C_in_reg[0]),.I2(C_in_reg[0]),.I3(C_in_reg[0]),.I4(C_in_reg[0]),.I5(C_in_reg[0]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y251" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_2(.O(O_2_2),.I0(O_2_1),.I1(C_in_reg[1]),.I2(C_in_reg[1]),.I3(C_in_reg[1]),.I4(C_in_reg[1]),.I5(C_in_reg[1]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y252" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_3(.O(O_2_3),.I0(O_2_2),.I1(C_in_reg[2]),.I2(C_in_reg[2]),.I3(C_in_reg[2]),.I4(C_in_reg[2]),.I5(C_in_reg[2]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y252" *) (* LOCK_PINS = "I0:A3" *)    
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_4(.O(O_2_4),.I0(O_2_3),.I1(C_in_reg[3]),.I2(C_in_reg[3]),.I3(C_in_reg[3]),.I4(C_in_reg[3]),.I5(C_in_reg[3]));    
        //SLICE_X123Y251
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y253" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_5(.O(O_2_5),.I0(O_2_4),.I1(C_in_reg[4]),.I2(C_in_reg[4]),.I3(C_in_reg[4]),.I4(C_in_reg[4]),.I5(C_in_reg[4]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y253" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_6(.O(O_2_6),.I0(O_2_5),.I1(C_in_reg[5]),.I2(C_in_reg[5]),.I3(C_in_reg[5]),.I4(C_in_reg[5]),.I5(C_in_reg[5]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y254" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_7(.O(O_2_7),.I0(O_2_6),.I1(C_in_reg[6]),.I2(C_in_reg[6]),.I3(C_in_reg[6]),.I4(C_in_reg[6]),.I5(C_in_reg[6]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y254" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_8(.O(O_2_8),.I0(O_2_7),.I1(C_in_reg[7]),.I2(C_in_reg[7]),.I3(C_in_reg[7]),.I4(C_in_reg[7]),.I5(C_in_reg[7]));
        
        //SLICE_X122Y252
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y255" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_9(.O(O_2_9),.I0(O_2_8),.I1(C_in_reg[8]),.I2(C_in_reg[8]),.I3(C_in_reg[8]),.I4(C_in_reg[8]),.I5(C_in_reg[8]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y255" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_10(.O(O_2_10),.I0(O_2_9),.I1(C_in_reg[9]),.I2(C_in_reg[9]),.I3(C_in_reg[9]),.I4(C_in_reg[9]),.I5(C_in_reg[9]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y256" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_11(.O(O_2_11),.I0(O_2_10),.I1(C_in_reg[10]),.I2(C_in_reg[10]),.I3(C_in_reg[10]),.I4(C_in_reg[10]),.I5(C_in_reg[10]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y256" *) (* LOCK_PINS = "I0:A3" *)    
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_12(.O(O_2_12),.I0(O_2_11),.I1(C_in_reg[11]),.I2(C_in_reg[11]),.I3(C_in_reg[11]),.I4(C_in_reg[11]),.I5(C_in_reg[11]));
        //SLICE_X123Y252
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y257" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_13(.O(O_2_13),.I0(O_2_12),.I1(C_in_reg[12]),.I2(C_in_reg[12]),.I3(C_in_reg[12]),.I4(C_in_reg[12]),.I5(C_in_reg[12]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y257" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_14(.O(O_2_14),.I0(O_2_13),.I1(C_in_reg[13]),.I2(C_in_reg[13]),.I3(C_in_reg[13]),.I4(C_in_reg[13]),.I5(C_in_reg[13]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y258" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_15(.O(O_2_15),.I0(O_2_14),.I1(C_in_reg[14]),.I2(C_in_reg[14]),.I3(C_in_reg[14]),.I4(C_in_reg[14]),.I5(C_in_reg[14]));
            (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y258" *) (* LOCK_PINS = "I0:A3" *)
                LUT6#(.INIT(64'h6555555555555555))
                LUT1_2_16(.O(O_2_16),.I0(O_2_15),.I1(C_in_reg[15]),.I2(C_in_reg[15]),.I3(C_in_reg[15]),.I4(C_in_reg[15]),.I5(C_in_reg[15]));
                
        //SLICE_X122Y253
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y259" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_17(.O(O_2_17),.I0(O_2_16),.I1(C_in_reg[16]),.I2(C_in_reg[16]),.I3(C_in_reg[16]),.I4(C_in_reg[16]),.I5(C_in_reg[16]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y259" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_18(.O(O_2_18),.I0(O_2_17),.I1(C_in_reg[17]),.I2(C_in_reg[17]),.I3(C_in_reg[17]),.I4(C_in_reg[17]),.I5(C_in_reg[17]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y260" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_19(.O(O_2_19),.I0(O_2_18),.I1(C_in_reg[18]),.I2(C_in_reg[18]),.I3(C_in_reg[18]),.I4(C_in_reg[18]),.I5(C_in_reg[18]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y260" *) (* LOCK_PINS = "I0:A3" *)    
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_20(.O(O_2_20),.I0(O_2_19),.I1(C_in_reg[19]),.I2(C_in_reg[19]),.I3(C_in_reg[19]),.I4(C_in_reg[19]),.I5(C_in_reg[19]));    
         //SLICE_X123Y253
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y261" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_21(.O(O_2_21),.I0(O_2_20),.I1(C_in_reg[20]),.I2(C_in_reg[20]),.I3(C_in_reg[20]),.I4(C_in_reg[20]),.I5(C_in_reg[20]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y261" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_22(.O(O_2_22),.I0(O_2_21),.I1(C_in_reg[21]),.I2(C_in_reg[21]),.I3(C_in_reg[21]),.I4(C_in_reg[21]),.I5(C_in_reg[21]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y262" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_23(.O(O_2_23),.I0(O_2_22),.I1(C_in_reg[22]),.I2(C_in_reg[22]),.I3(C_in_reg[22]),.I4(C_in_reg[22]),.I5(C_in_reg[22]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y262" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_24(.O(O_2_24),.I0(O_2_23),.I1(C_in_reg[23]),.I2(C_in_reg[23]),.I3(C_in_reg[23]),.I4(C_in_reg[23]),.I5(C_in_reg[23]));
                
         //SLICE_X122Y254
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y263" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_25(.O(O_2_25),.I0(O_2_24),.I1(C_in_reg[24]),.I2(C_in_reg[24]),.I3(C_in_reg[24]),.I4(C_in_reg[24]),.I5(C_in_reg[24]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y263" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_26(.O(O_2_26),.I0(O_2_25),.I1(C_in_reg[25]),.I2(C_in_reg[25]),.I3(C_in_reg[25]),.I4(C_in_reg[25]),.I5(C_in_reg[25]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y264" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_27(.O(O_2_27),.I0(O_2_26),.I1(C_in_reg[26]),.I2(C_in_reg[26]),.I3(C_in_reg[26]),.I4(C_in_reg[26]),.I5(C_in_reg[26]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y264" *)     (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_28(.O(O_2_28),.I0(O_2_27),.I1(C_in_reg[27]),.I2(C_in_reg[27]),.I3(C_in_reg[27]),.I4(C_in_reg[27]),.I5(C_in_reg[27]));
         //SLICE_X123Y254
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y265" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_29(.O(O_2_29),.I0(O_2_28),.I1(C_in_reg[28]),.I2(C_in_reg[28]),.I3(C_in_reg[28]),.I4(C_in_reg[28]),.I5(C_in_reg[28]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y265" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_30(.O(O_2_30),.I0(O_2_29),.I1(C_in_reg[29]),.I2(C_in_reg[29]),.I3(C_in_reg[29]),.I4(C_in_reg[29]),.I5(C_in_reg[29]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y266" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_31(.O(O_2_31),.I0(O_2_30),.I1(C_in_reg[30]),.I2(C_in_reg[30]),.I3(C_in_reg[30]),.I4(C_in_reg[30]),.I5(C_in_reg[30]));
                    (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y266" *) (* LOCK_PINS = "I0:A3" *)
                        LUT6#(.INIT(64'h6555555555555555))
                        LUT1_2_32(.O(O_2_32),.I0(O_2_31),.I1(C_in_reg[31]),.I2(C_in_reg[31]),.I3(C_in_reg[31]),.I4(C_in_reg[31]),.I5(C_in_reg[31]));
						
					
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y267" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_33(.O(O_2_33),.I0(O_2_32),.I1(C_in_reg[32]),.I2(C_in_reg[32]),.I3(C_in_reg[32]),.I4(C_in_reg[32]),.I5(C_in_reg[32]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y267" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_34(.O(O_2_34),.I0(O_2_33),.I1(C_in_reg[33]),.I2(C_in_reg[33]),.I3(C_in_reg[33]),.I4(C_in_reg[33]),.I5(C_in_reg[33]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y268" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_35(.O(O_2_35),.I0(O_2_34),.I1(C_in_reg[34]),.I2(C_in_reg[34]),.I3(C_in_reg[34]),.I4(C_in_reg[34]),.I5(C_in_reg[34]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y268" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_36(.O(O_2_36),.I0(O_2_35),.I1(C_in_reg[35]),.I2(C_in_reg[35]),.I3(C_in_reg[35]),.I4(C_in_reg[35]),.I5(C_in_reg[35]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y269" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_37(.O(O_2_37),.I0(O_2_36),.I1(C_in_reg[36]),.I2(C_in_reg[36]),.I3(C_in_reg[36]),.I4(C_in_reg[36]),.I5(C_in_reg[36]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y269" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_38(.O(O_2_38),.I0(O_2_37),.I1(C_in_reg[37]),.I2(C_in_reg[37]),.I3(C_in_reg[37]),.I4(C_in_reg[37]),.I5(C_in_reg[37]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y270" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_39(.O(O_2_39),.I0(O_2_38),.I1(C_in_reg[38]),.I2(C_in_reg[38]),.I3(C_in_reg[38]),.I4(C_in_reg[38]),.I5(C_in_reg[38]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y270" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_40(.O(O_2_40),.I0(O_2_39),.I1(C_in_reg[39]),.I2(C_in_reg[39]),.I3(C_in_reg[39]),.I4(C_in_reg[39]),.I5(C_in_reg[39]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y271" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_41(.O(O_2_41),.I0(O_2_40),.I1(C_in_reg[40]),.I2(C_in_reg[40]),.I3(C_in_reg[40]),.I4(C_in_reg[40]),.I5(C_in_reg[40]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y271" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_42(.O(O_2_42),.I0(O_2_41),.I1(C_in_reg[41]),.I2(C_in_reg[41]),.I3(C_in_reg[41]),.I4(C_in_reg[41]),.I5(C_in_reg[41]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y272" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_43(.O(O_2_43),.I0(O_2_42),.I1(C_in_reg[42]),.I2(C_in_reg[42]),.I3(C_in_reg[42]),.I4(C_in_reg[42]),.I5(C_in_reg[42]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y272" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_44(.O(O_2_44),.I0(O_2_43),.I1(C_in_reg[43]),.I2(C_in_reg[43]),.I3(C_in_reg[43]),.I4(C_in_reg[43]),.I5(C_in_reg[43]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y273" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_45(.O(O_2_45),.I0(O_2_44),.I1(C_in_reg[44]),.I2(C_in_reg[44]),.I3(C_in_reg[44]),.I4(C_in_reg[44]),.I5(C_in_reg[44]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y273" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_46(.O(O_2_46),.I0(O_2_45),.I1(C_in_reg[45]),.I2(C_in_reg[45]),.I3(C_in_reg[45]),.I4(C_in_reg[45]),.I5(C_in_reg[45]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y274" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_47(.O(O_2_47),.I0(O_2_46),.I1(C_in_reg[46]),.I2(C_in_reg[46]),.I3(C_in_reg[46]),.I4(C_in_reg[46]),.I5(C_in_reg[46]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y274" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_48(.O(O_2_48),.I0(O_2_47),.I1(C_in_reg[47]),.I2(C_in_reg[47]),.I3(C_in_reg[47]),.I4(C_in_reg[47]),.I5(C_in_reg[47]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y275" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_49(.O(O_2_49),.I0(O_2_48),.I1(C_in_reg[48]),.I2(C_in_reg[48]),.I3(C_in_reg[48]),.I4(C_in_reg[48]),.I5(C_in_reg[48]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y275" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_50(.O(O_2_50),.I0(O_2_49),.I1(C_in_reg[49]),.I2(C_in_reg[49]),.I3(C_in_reg[49]),.I4(C_in_reg[49]),.I5(C_in_reg[49]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y276" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_51(.O(O_2_51),.I0(O_2_50),.I1(C_in_reg[50]),.I2(C_in_reg[50]),.I3(C_in_reg[50]),.I4(C_in_reg[50]),.I5(C_in_reg[50]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y276" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_52(.O(O_2_52),.I0(O_2_51),.I1(C_in_reg[51]),.I2(C_in_reg[51]),.I3(C_in_reg[51]),.I4(C_in_reg[51]),.I5(C_in_reg[51]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y277" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_53(.O(O_2_53),.I0(O_2_52),.I1(C_in_reg[52]),.I2(C_in_reg[52]),.I3(C_in_reg[52]),.I4(C_in_reg[52]),.I5(C_in_reg[52]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y277" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_54(.O(O_2_54),.I0(O_2_53),.I1(C_in_reg[53]),.I2(C_in_reg[53]),.I3(C_in_reg[53]),.I4(C_in_reg[53]),.I5(C_in_reg[53]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y278" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_55(.O(O_2_55),.I0(O_2_54),.I1(C_in_reg[54]),.I2(C_in_reg[54]),.I3(C_in_reg[54]),.I4(C_in_reg[54]),.I5(C_in_reg[54]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y278" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_56(.O(O_2_56),.I0(O_2_55),.I1(C_in_reg[55]),.I2(C_in_reg[55]),.I3(C_in_reg[55]),.I4(C_in_reg[55]),.I5(C_in_reg[55]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y279" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_57(.O(O_2_57),.I0(O_2_56),.I1(C_in_reg[56]),.I2(C_in_reg[56]),.I3(C_in_reg[56]),.I4(C_in_reg[56]),.I5(C_in_reg[56]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y279" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_58(.O(O_2_58),.I0(O_2_57),.I1(C_in_reg[57]),.I2(C_in_reg[57]),.I3(C_in_reg[57]),.I4(C_in_reg[57]),.I5(C_in_reg[57]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y280" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_59(.O(O_2_59),.I0(O_2_58),.I1(C_in_reg[58]),.I2(C_in_reg[58]),.I3(C_in_reg[58]),.I4(C_in_reg[58]),.I5(C_in_reg[58]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y280" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_60(.O(O_2_60),.I0(O_2_59),.I1(C_in_reg[59]),.I2(C_in_reg[59]),.I3(C_in_reg[59]),.I4(C_in_reg[59]),.I5(C_in_reg[59]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y281" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_61(.O(O_2_61),.I0(O_2_60),.I1(C_in_reg[60]),.I2(C_in_reg[60]),.I3(C_in_reg[60]),.I4(C_in_reg[60]),.I5(C_in_reg[60]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y281" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_62(.O(O_2_62),.I0(O_2_61),.I1(C_in_reg[61]),.I2(C_in_reg[61]),.I3(C_in_reg[61]),.I4(C_in_reg[61]),.I5(C_in_reg[61]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y282" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_63(.O(O_2_63),.I0(O_2_62),.I1(C_in_reg[62]),.I2(C_in_reg[62]),.I3(C_in_reg[62]),.I4(C_in_reg[62]),.I5(C_in_reg[62]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y282" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_64(.O(O_2_64),.I0(O_2_63),.I1(C_in_reg[63]),.I2(C_in_reg[63]),.I3(C_in_reg[63]),.I4(C_in_reg[63]),.I5(C_in_reg[63]));
			
			
		//Tuner PDLs
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y283" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_65(.O(O_2_65),.I0(O_2_64),.I1(T_R_in[0]),.I2(T_R_in[0]),.I3(T_R_in[0]),.I4(T_R_in[0]),.I5(T_R_in[0]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y283" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_66(.O(O_2_66),.I0(O_2_65),.I1(T_R_in[1]),.I2(T_R_in[1]),.I3(T_R_in[1]),.I4(T_R_in[1]),.I5(T_R_in[1]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y284" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_67(.O(O_2_67),.I0(O_2_66),.I1(T_R_in[2]),.I2(T_R_in[2]),.I3(T_R_in[2]),.I4(T_R_in[2]),.I5(T_R_in[2]));
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y284" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_68(.O(O_2_68),.I0(O_2_67),.I1(T_R_in[3]),.I2(T_R_in[3]),.I3(T_R_in[3]),.I4(T_R_in[3]),.I5(T_R_in[3]));
			
		(* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y285" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_69(.O(O_2_69),.I0(O_2_68),.I1(T_R_in[4]),.I2(T_R_in[4]),.I3(T_R_in[4]),.I4(T_R_in[4]),.I5(T_R_in[4]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y285" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_70(.O(O_2_70),.I0(O_2_69),.I1(T_R_in[5]),.I2(T_R_in[5]),.I3(T_R_in[5]),.I4(T_R_in[5]),.I5(T_R_in[5]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X122Y286" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_71(.O(O_2_71),.I0(O_2_70),.I1(T_R_in[6]),.I2(T_R_in[6]),.I3(T_R_in[6]),.I4(T_R_in[6]),.I5(T_R_in[6]));
        (* BEL = "A6LUT" *) (* LOC = "SLICE_X123Y286" *) (* LOCK_PINS = "I0:A3" *)
            LUT6#(.INIT(64'h6555555555555555))
            LUT1_2_72(.O(O_2_72),.I0(O_2_71),.I1(T_R_in[7]),.I2(T_R_in[7]),.I3(T_R_in[7]),.I4(T_R_in[7]),.I5(T_R_in[7]));
        ///////////////////////////////////////////////////End of right chain
        
        
        
endmodule
