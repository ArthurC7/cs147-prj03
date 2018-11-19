// Name: rc_add_sub_32.v
// Module: RC_ADD_SUB_32
//
// Output: Y : Output 32-bit
//         CO : Carry Out
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//        SnA : if SnA=0 it is add, subtraction otherwise
//
// Notes: 32-bit adder / subtractor implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module RC_ADD_SUB_64(Y, CO, A, B, SnA);
// output list
output [63:0] Y;
output CO;
// input list
input [63:0] A;
input [63:0] B;
input SnA;

// TBD
genvar i; // For iteration of bits 0 through 31
wire [63:0] b_xor;
wire [63:0] CI;

xor xor_inst_0(b_xor[0], SnA, B[0]);
FULL_ADDER full_adder_inst(.Y(Y[0]), .CO(CI[0]), .A(A[0]), .B(b_xor[0]), .CI(SnA));

generate
for(i = 1; i < 31; i=i+1)
begin
	xor xor_inst(b_xor[i], SnA, B[i]);
	FULL_ADDER full_adder_inst(.Y(Y[i]), .CO(CI[i]), .A(A[i]), .B(b_xor[i]), .CI(CI[i-1]));
end
endgenerate

xor xor_inst_31(b_xor[63], CI, B[63]);
FULL_ADDER full_adder_inst_31(.Y(Y[63]), .CO(CO), .A(A[63]), .B(b_xor[63]), .CI(CI[62]));

endmodule



module RC_ADD_SUB_32(Y, CO, A, B, SnA);
// output list
output [`DATA_INDEX_LIMIT:0] Y;
output CO;
// input list
input [`DATA_INDEX_LIMIT:0] A;
input [`DATA_INDEX_LIMIT:0] B;
input SnA;

// TBD
genvar i; // For iteration of bits 0 through 31
wire [31:0] b_xor;
wire [31:0] CI;

xor xor_inst_0(b_xor[0], SnA, B[0]);
FULL_ADDER full_adder_inst(.Y(Y[0]), .CO(CI[0]), .A(A[0]), .B(b_xor[0]), .CI(SnA));

generate
for(i = 1; i < 31; i=i+1)
begin
	xor xor_inst(b_xor[i], SnA, B[i]);
	FULL_ADDER full_adder_inst(.Y(Y[i]), .CO(CI[i]), .A(A[i]), .B(b_xor[i]), .CI(CI[i-1]));
end
endgenerate

xor xor_inst_31(b_xor[31], SnA, B[31]);
FULL_ADDER full_adder_inst_31(.Y(Y[31]), .CO(CO), .A(A[31]), .B(b_xor[31]), .CI(CI[30]));

endmodule

