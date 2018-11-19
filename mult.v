// Name: mult.v
// Module: MULT32 , MULT32_U
//
// Output: HI: 32 higher bits
//         LO: 32 lower bits
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//
// Notes: 32-bit multiplication
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module MULT32(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A; // multiplicand
input [31:0] B; // multiplier

// TBD
wire [31:0] comp_res1;
wire [31:0] comp_res2;
wire [31:0] mux_res1;
wire [31:0] mux_res2;
wire xor_res;
wire [31:0] HiU;
wire [31:0] LoU;
wire [63:0] mux64_op0;
wire [63:0] mux64_op1;
wire [63:0] mux64_res;

TWOSCOMP32 complement1_inst(comp_res1, A);
TWOSCOMP32 complement2_inst(comp_res2, B);

MUX32_2x1 mux32_inst1(mux_res1, A, comp_res1, A[31]);
MUX32_2x1 mux32_inst2(mux_res2,  B, comp_res2, B[31]);

MULT32_U multiU_inst(HiU, LoU, mux_res1, mux_res2);
xor xor_inst(xor_res, A[31], B[31]);
assign mux64_op0 = {HiU, LoU};

TWOSCOMP64 compl64_inst(mux64_op1, mux64_op0);
MUX64_2x1 mux64_inst(mux64_res, mux64_op0, mux64_op1, xor_res);

assign HI = mux64_res[63:32];
assign LO = mux64_res[31:0];

endmodule

module MULT32_U(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A; // multiplicand
input [31:0] B; // multiplier

// TBD
wire [31:0] adder_op2 [31:0];
wire [31:0] carryout;
genvar i;

AND32_2x1 and32_inst1(adder_op2[0], A, {32{B[0]}});
assign LO[0] = adder_op2[0][0];

generate
for(i = 1; i < 32; i=i+1)
begin
	wire [31:0] adder_op1;
	AND32_2x1 and32_inst(adder_op1, A, {32{B[i]}});
	RC_ADD_SUB_32 addsub_inst(adder_op2[i], carryout[i], adder_op1,{carryout[i-1], adder_op2[i-1][31:1]}, 1'b0);
	assign LO[i] = adder_op2[i][0];
end
endgenerate

assign HI = {carryout[31], adder_op2[31][31:1]};

endmodule
