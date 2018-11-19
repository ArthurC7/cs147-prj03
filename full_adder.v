// Name: full_adder.v
// Module: FULL_ADDER
//
// Output: S : Sum
//         CO : Carry Out
//
// Input: A : Bit 1
//        B : Bit 2
//        CI : Carry In
//
// Notes: 1-bit full adder implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module FULL_ADDER(Y,CO,A,B, CI);
output Y,CO;
input A,B, CI;

// wire list
wire hf1_res_Y;
wire hf1_res_C;
wire hf2_res_Y;
wire hf2_res_C;

// internal register list
//reg CO;
//reg Y;

HALF_ADDER hs_int_1(.Y(hf1_res_Y), .C(hf1_res_C), .A(A), .B(B));

HALF_ADDER hs_int_2(.Y(hf2_res_Y), .C(hf2_res_C), .A(hf1_res_Y), .B(CI));

or inst_1(CO, hf2_res_C, hf1_res_C); 
assign Y = hf2_res_Y;

endmodule;
