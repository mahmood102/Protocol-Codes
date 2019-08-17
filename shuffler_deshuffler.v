`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mahmood Azhar Qureshi
// 
// Create Date: 04/22/2019 12:59:32 PM
// Design Name: 
// Module Name: shuffler
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:	This module implements a Fisher-Yates shuffler/Deshuffler system. 
// 
//////////////////////////////////////////////////////////////////////////////////


module shuffler(
    input mclk,
    input rst,
    input shuffle_en,
	input deshuffle,			//0- shuffle the input 1-deshuffle the input
    input [63:0] data_in,
	input [63:0] key_in,
	
	
	//for debugging
	output reg wr_en_bram,
	output [5:0] seq_out_scaled,
	/////////////////////
	output reg done,
	output reg [63:0] shuffle_out
    );
	
	//FSM States
	parameter IDLE 			= 4'd0;
	parameter INIT      	= 4'd1;
	parameter BRAM 			= 4'd2;
	parameter WAIT			= 4'd3;
	parameter SHUFFLE_S1	= 4'd4;
	parameter SHUFFLE_S2	= 4'd5;
	parameter WAIT1			= 4'd6;
	parameter CHECK			= 4'd7;
	parameter FINAL			= 4'd8;
	
	reg [3:0] current_state,next_state;
	
	reg [63:0] data_in_reg;
	
	reg [63:0] seq_out;			
//	wire [5:0] seq_out_scaled;		//scaled seq out 
	reg [5:0] seq_counter;
	wire feedback;
	
	reg [6:0] dec_count;		//decrement counter
	
	//Control Signals
	reg idle;
	reg init;
	reg bram;
	reg wait0;
	reg wait1;
	reg check;
	reg shuffle1;
	reg shuffle2;
	reg final0;
	
	reg shuffle;
	
	wire [5:0] data_out_bram;
	reg [5:0] addr_bram;
	
	reg data_in_bit;
//	reg wr_en_bram;
	reg [5:0] data_in_bram;
	
	reg a,b;

	
	reg [1:0] delay_counter;		//start reading seq out after 2 cycle pipeline
	
	always@(posedge mclk)
	begin
		if(idle)
			delay_counter <= 2'd0;
		else if(init && (delay_counter < 2'd1))
			delay_counter <= delay_counter + 1'd1;
		else if(bram)
			delay_counter <= 0;
		else if(wait0)
			delay_counter <= delay_counter + 1'd1;
		else
			delay_counter <= delay_counter;
	end
	
	
	
	//mem addresses
	reg [5:0] address1;
	reg [5:0] address2;
	
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
		
		//IDLE state, waits for shuffle_en from main FSM
			IDLE:	//0
			begin	
				idle = 1;
				init = 0;
				bram = 0;
				wait0 = 0;
				wait1 = 0;
				shuffle1 = 0;
				shuffle2 = 0;
				check = 0;
				final0 = 0;
				
				wr_en_bram = 0;
				
				a = 0;
				b = 0;
				address1 = 6'd0;
				address2 = 6'd0;
				
				done = 0;
				if(shuffle_en)
					next_state = INIT;
				else
					next_state = IDLE;
			end
			
	//Initialize mem2 with all zeros. Also make prng seed equal to data_in	
			INIT:		//1
			begin
				idle = 0;
				init = 1;
				bram = 0;
				wait0 = 0;
				wait1 = 0;
				shuffle1 = 0;
				shuffle2 = 0;
				check = 0;
				final0 = 0;
				
				wr_en_bram = 0;
				
				a = 0;
				b = 0;
				address1 = 6'd0;
				address2 = 6'd0;
				
				done = 0;
				if(delay_counter == 2'd1)
					next_state = BRAM;
				else 
					next_state = INIT;
			end
			
			BRAM:		//2
			begin
				idle = 0;
				init = 0;
				bram = 1;
				wait0 = 0;
				wait1 = 0;
				shuffle1 = 0;
				shuffle2 = 0;
				check = 0;
				final0 = 0;
			
				wr_en_bram = 1;
				
				a = 0;
				b = 0;
				address1 = 6'd0;
				address2 = 6'd0;

				done = 0;
				if(!deshuffle && (addr_bram < 6'd63))
					next_state = BRAM;
				else if(deshuffle && (addr_bram > 6'd0))
					next_state = BRAM;
				else 
					next_state = WAIT;
			end
			
			WAIT:
			begin
				idle = 0;
				init = 0;
				bram = 0;
				wait0 = 1;
				wait1 = 0;
				shuffle1 = 0;
				shuffle2 = 0;
				check = 0;
				final0 = 0;
			
				wr_en_bram = 0;
				a = 0;
				b = 0;
				address1 = 6'd0;
				address2 = 6'd0;

				done = 0;
				if(delay_counter == 2'd3)
					next_state = SHUFFLE_S1;
				else
					next_state = WAIT;
			end
			
			SHUFFLE_S1:		//3
			begin
				idle = 0;
				init = 0;
				bram = 0;
				wait0 = 0;
				wait1 = 0;
				shuffle1 = 1;
				shuffle2 = 0;
				check = 0;
				final0 = 0;
				
				wr_en_bram = 0;
				address1 = data_out_bram;
				address2 = dec_count[5:0];
				a = data_in_bit;
				b = a;	
				
				done = 0;
				next_state = SHUFFLE_S2;
			end
			
			SHUFFLE_S2:		//4
			begin
				idle = 0;
				init = 0;
				bram = 0;
				wait0 = 0;
				wait1 = 0;
				shuffle1 = 0;
				shuffle2 = 1;
				check = 0;
				final0 = 0;
				
				wr_en_bram = 0;
				address1 = dec_count[5:0];
				address2 = data_out_bram;
				a = data_in_bit;
				b = a;
				
				done = 0;
				next_state = WAIT1;
			end
			
			WAIT1:
			begin
				idle = 0;
				init = 0;
				bram = 0;
				wait0 = 0;
				wait1 = 1;
				shuffle1 = 0;
				shuffle2 = 0;
				check = 0;
				final0 = 0;
				
				wr_en_bram = 0;
				address1 = 6'd0;
				address2 = 6'd0;
				a = 0;
				b = 0;
				
				done = 0;
				next_state = CHECK;
			end
			
			CHECK:		//5
			begin
				idle = 0;
				init = 0;
				bram = 0;
				wait0 = 0;
				wait1 = 0;
				shuffle1 = 0;
				shuffle2 = 0;
				check = 1;
				final0 = 0;
				
				wr_en_bram = 0;
				address1 = 6'd0;
				address2 = 6'd0;
				a = 0;
				b = 0;
				
	//			done = 0;
	//			next_state = SHUFFLE_S1;
				if((!deshuffle) && (dec_count == 7'd0))
				begin
					done = 1;
					next_state = IDLE;
				end
				else if((deshuffle) && (dec_count == 7'd64))
				begin
					done = 1;
					next_state = IDLE;
				end
				else
				begin
					done = 0;
					next_state = SHUFFLE_S1;
				end
			end	
		endcase
	end

//load the prng with data seed to begin transitioning 
	assign feedback = ((seq_out[63] ^ seq_out[62]) ^ seq_out[60]);
	
	always@(posedge mclk)
	begin
		if(idle)
		begin
			seq_out <= key_in;
			dec_count <= 7'd63;
			addr_bram <= 6'd0;
			seq_counter <= 6'd0;
		end
		else if(init)
		begin
			seq_counter <= seq_counter;
			seq_out <= seq_out;//{seq_out[62:0],feedback};
			dec_count <= 7'd63;
			if(!deshuffle)
				addr_bram <= 6'd0;
			else
				addr_bram <= 6'd63;
		end
		
		else if(bram)
		begin
			if(seq_counter != 6'd63)
			begin
				seq_counter <= seq_counter + 1;
				seq_out <= {seq_out[62:0],feedback};
				dec_count <= dec_count;
				addr_bram <= addr_bram;
			end
			else
			begin
				seq_counter <= 6'd0;
				seq_out <= seq_out;
				dec_count <= dec_count - 1'd1;
				if(!deshuffle)
					addr_bram <= addr_bram + 1'd1;
				else
					addr_bram <= addr_bram - 1'd1;
				end
		end
		
		else if(wait0)
		begin
			seq_counter <= 6'd0;
			seq_out <= seq_out;
			addr_bram <= 6'd0;
			if(!deshuffle)
				dec_count <= 7'd63;
			else
				dec_count <= 7'd0;
		end
		
		else if(shuffle2)
		begin
			seq_counter <= 6'd0;
			seq_out <= seq_out;
			addr_bram <= addr_bram + 1'd1;
			if(!deshuffle)
				dec_count <= dec_count - 1'd1;
			else
				dec_count <= dec_count + 1'd1;
		end
		
		else
		begin
			seq_counter <= seq_counter;
			seq_out <= seq_out;
			dec_count <= dec_count;
			addr_bram <= addr_bram;
		end
	end
			
//adjustment MULT
	mult_gen_0 mult_gen_0_inst (
	.CLK(mclk),  				// input wire CLK
	.A(seq_out),      			// input wire [7 : 0] A
	.B(dec_count[5:0]),      	// input wire [2 : 0] B
	.P(seq_out_scaled)      	// output wire [2 : 0] P
	);	
	
	///Mem 1 having the input data_in
	always@*
	begin
		case(address1)
			6'd0:	data_in_bit = data_in_reg[0];
			6'd1:	data_in_bit = data_in_reg[1];
			6'd2:	data_in_bit = data_in_reg[2];
			6'd3:	data_in_bit = data_in_reg[3];
			6'd4: 	data_in_bit = data_in_reg[4];
			6'd5:	data_in_bit = data_in_reg[5];
			6'd6: 	data_in_bit = data_in_reg[6];
			6'd7: 	data_in_bit = data_in_reg[7];
			6'd8:	data_in_bit = data_in_reg[8];
			6'd9:	data_in_bit = data_in_reg[9];
			6'd10:	data_in_bit = data_in_reg[10];
			6'd11:	data_in_bit = data_in_reg[11];
			6'd12: 	data_in_bit = data_in_reg[12];
			6'd13:	data_in_bit = data_in_reg[13];
			6'd14: 	data_in_bit = data_in_reg[14];
			6'd15: 	data_in_bit = data_in_reg[15];
			6'd16:	data_in_bit = data_in_reg[16];
			6'd17:	data_in_bit = data_in_reg[17];
			6'd18:	data_in_bit = data_in_reg[18];
			6'd19:	data_in_bit = data_in_reg[19];
			6'd20: 	data_in_bit = data_in_reg[20];
			6'd21:	data_in_bit = data_in_reg[21];
			6'd22: 	data_in_bit = data_in_reg[22];
			6'd23: 	data_in_bit = data_in_reg[23];
			6'd24:	data_in_bit = data_in_reg[24];
			6'd25:	data_in_bit = data_in_reg[25];
			6'd26:	data_in_bit = data_in_reg[26];
			6'd27:	data_in_bit = data_in_reg[27];
			6'd28: 	data_in_bit = data_in_reg[28];
			6'd29:	data_in_bit = data_in_reg[29];
			6'd30: 	data_in_bit = data_in_reg[30];
			6'd31: 	data_in_bit = data_in_reg[31];
			6'd32:	data_in_bit = data_in_reg[32];
			6'd33:	data_in_bit = data_in_reg[33];
			6'd34:	data_in_bit = data_in_reg[34];
			6'd35:	data_in_bit = data_in_reg[35];
			6'd36: 	data_in_bit = data_in_reg[36];
			6'd37:	data_in_bit = data_in_reg[37];
			6'd38: 	data_in_bit = data_in_reg[38];
			6'd39: 	data_in_bit = data_in_reg[39];
			6'd40:	data_in_bit = data_in_reg[40];
			6'd41:	data_in_bit = data_in_reg[41];
			6'd42:	data_in_bit = data_in_reg[42];
			6'd43:	data_in_bit = data_in_reg[43];
			6'd44: 	data_in_bit = data_in_reg[44];
			6'd45:	data_in_bit = data_in_reg[45];
			6'd46: 	data_in_bit = data_in_reg[46];
			6'd47: 	data_in_bit = data_in_reg[47];
			6'd48:	data_in_bit = data_in_reg[48];
			6'd49:	data_in_bit = data_in_reg[49];
			6'd50:	data_in_bit = data_in_reg[50];
			6'd51:	data_in_bit = data_in_reg[51];
			6'd52: 	data_in_bit = data_in_reg[52];
			6'd53:	data_in_bit = data_in_reg[53];
			6'd54: 	data_in_bit = data_in_reg[54];
			6'd55: 	data_in_bit = data_in_reg[55];
			6'd56:	data_in_bit = data_in_reg[56];
			6'd57:	data_in_bit = data_in_reg[57];
			6'd58:	data_in_bit = data_in_reg[58];
			6'd59:	data_in_bit = data_in_reg[59];
			6'd60: 	data_in_bit = data_in_reg[60];
			6'd61:	data_in_bit = data_in_reg[61];
			6'd62: 	data_in_bit = data_in_reg[62];
			6'd63: 	data_in_bit = data_in_reg[63];		
		endcase
	end
			
	///Mem 2 having the output shuffle_out
	always@(posedge mclk)
	begin
		if(idle)
		begin
			shuffle_out <= data_in;
			data_in_reg <= data_in;
		end
		else if(shuffle1 || shuffle2)
		begin
			case(address2)
				6'd0:	shuffle_out[0] <= b;
				6'd1:	shuffle_out[1] <= b;
				6'd2:	shuffle_out[2] <= b;
				6'd3:	shuffle_out[3] <= b;
				6'd4: 	shuffle_out[4] <= b;
				6'd5:	shuffle_out[5] <= b;
				6'd6: 	shuffle_out[6] <= b;
				6'd7: 	shuffle_out[7] <= b;
				6'd8:	shuffle_out[8] <= b;
				6'd9:	shuffle_out[9] <= b;
				6'd10:	shuffle_out[10] <= b;
				6'd11:	shuffle_out[11] <= b;
				6'd12: 	shuffle_out[12] <= b;
				6'd13:	shuffle_out[13] <= b;
				6'd14: 	shuffle_out[14] <= b;
				6'd15: 	shuffle_out[15] <= b;
				6'd16:	shuffle_out[16] <= b;
				6'd17:	shuffle_out[17] <= b;
				6'd18:	shuffle_out[18] <= b;
				6'd19:	shuffle_out[19] <= b;
				6'd20: 	shuffle_out[20] <= b;
				6'd21:	shuffle_out[21] <= b;
				6'd22: 	shuffle_out[22] <= b;
				6'd23: 	shuffle_out[23] <= b;
				6'd24:	shuffle_out[24] <= b;
				6'd25:	shuffle_out[25] <= b;
				6'd26:	shuffle_out[26] <= b;
				6'd27:	shuffle_out[27] <= b;
				6'd28: 	shuffle_out[28] <= b;
				6'd29:	shuffle_out[29] <= b;
				6'd30: 	shuffle_out[30] <= b;
				6'd31: 	shuffle_out[31] <= b;
				6'd32:	shuffle_out[32] <= b;
				6'd33:	shuffle_out[33] <= b;
				6'd34:	shuffle_out[34] <= b;
				6'd35:	shuffle_out[35] <= b;
				6'd36: 	shuffle_out[36] <= b;
				6'd37:	shuffle_out[37] <= b;
				6'd38: 	shuffle_out[38] <= b;
				6'd39: 	shuffle_out[39] <= b;
				6'd40:	shuffle_out[40] <= b;
				6'd41:	shuffle_out[41] <= b;
				6'd42:	shuffle_out[42] <= b;
				6'd43:	shuffle_out[43] <= b;
				6'd44: 	shuffle_out[44] <= b;
				6'd45:	shuffle_out[45] <= b;
				6'd46: 	shuffle_out[46] <= b;
				6'd47: 	shuffle_out[47] <= b;
				6'd48:	shuffle_out[48] <= b;
				6'd49:	shuffle_out[49] <= b;
				6'd50:	shuffle_out[50] <= b;
				6'd51:	shuffle_out[51] <= b;
				6'd52: 	shuffle_out[52] <= b;
				6'd53:	shuffle_out[53] <= b;
				6'd54: 	shuffle_out[54] <= b;
				6'd55: 	shuffle_out[55] <= b;
				6'd56:	shuffle_out[56] <= b;
				6'd57:	shuffle_out[57] <= b;
				6'd58:	shuffle_out[58] <= b;
				6'd59:	shuffle_out[59] <= b;
				6'd60: 	shuffle_out[60] <= b;
				6'd61:	shuffle_out[61] <= b;
				6'd62: 	shuffle_out[62] <= b;
				6'd63: 	shuffle_out[63] <= b;	
			endcase
			data_in_reg <= data_in_reg;
		end
		else if(wait1)
		begin
			shuffle_out <= shuffle_out;
			data_in_reg <= shuffle_out;
		end 
		else
		begin
			shuffle_out <= shuffle_out;
			data_in_reg <= data_in_reg;
		end
	end
	
	
	//BRAM for loading scaled lfsr sequence
	lfsr_seq_bram lfsr_seq_bram_inst (
		.clka(mclk),    				// input wire clka
		.wea(wr_en_bram),      			// input wire [0 : 0] wea
		.addra(addr_bram),  			// input wire [2 : 0] addra
		.dina(seq_out_scaled),    		// input wire [2 : 0] dina
		.douta(data_out_bram)  			// output wire [2 : 0] douta
	);

endmodule
