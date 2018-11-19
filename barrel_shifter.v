// Name: barrel_shifter.v
// Module: SHIFT32_L , SHIFT32_R, SHIFT32
//
// Notes: 32-bit barrel shifter
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

// 32-bit shift amount shifter
module SHIFT32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [31:0] S;
input LnR;

// TBD
wire[31:0] barrel_res;
wire or27_res;

BARREL_SHIFTER32 barrel_inst(barrel_res, D, S, LnR);
OR27 or_inst(or27_res, S[31:5]);
MUX32_2x1 mux_inst(Y, barrel_res, 32'b0, or27_res);

endmodule

// 27x1 1-bit OR gate
module OR27(Y, A);
output Y;
input [27:0] A;
wire[27:0] or_res;
genvar i;

or or_inst1(or_res[1], A[0], A[1]);
generate
for(i=2;i<28;i=i+1)
begin 
	or or_inst(or_res[i], A[i], or_res[i-1]);
end
endgenerate

assign Y = or_res[27];

endmodule

// Shift with control L or R shift
module BARREL_SHIFTER32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;
input LnR;

// TBD
wire [31:0] right_shift_res;
wire [31:0] left_shift_res;

SHIFT32_R right_inst(right_shift_res, D, S);
SHIFT32_L left_inst(left_shift_res, D, S);
MUX32_2x1 mux_inst(Y, right_shift_res, left_shift_res, LnR);

endmodule

// Right shifter
module SHIFT32_R(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

// TBD
genvar i;
wire [31:0] mux0_res;
wire [31:0] mux1_res;
wire [31:0] mux2_res;
wire [31:0] mux3_res;

// 1-bit shift
MUX1_2x1 mux_inst0(mux0_res[31], D[31], 1'b0, S[0]);
generate
for(i = 0; i < 31; i=i+1)
begin
	MUX1_2x1 mux_inst1(mux0_res[i], D[i], D[i+1], S[0]);
end
endgenerate

// 2-bit shift
MUX1_2x1 mux_inst2(mux1_res[31], mux0_res[31], 1'b0, S[1]);
MUX1_2x1 mux_inst3(mux1_res[30], mux0_res[30], 1'b0, S[1]);
generate
for(i = 0; i < 30; i=i+1)
begin
	MUX1_2x1 mux_inst4(mux1_res[i], mux0_res[i], mux0_res[i-2], S[1]);
end
endgenerate

// 3-bit shift
generate
for(i = 28; i < 32; i=i+1)
begin 
	MUX1_2x1 mux_inst5(mux2_res[i], mux1_res[i], 1'b0, S[2]);
end

endgenerate

generate
for(i = 0; i < 28; i=i+1)
begin 
	MUX1_2x1 mux_inst6(mux2_res[i], mux1_res[i], mux1_res[i+4], S[2]);
end

endgenerate

// 4-bit shift 
generate
for(i = 24; i < 32; i=i+1)
begin 
	MUX1_2x1 mux_inst7(mux3_res[i], mux2_res[i], 1'b0, S[3]);
end

endgenerate

generate
for(i = 0; i < 24; i=i+1)
begin 
	MUX1_2x1 mux_inst8(mux3_res[i], mux2_res[i], mux2_res[i+8], S[3]);
end

endgenerate

// 5-bit shift 
generate
for(i = 16; i < 32; i=i+1)
begin 
	MUX1_2x1 mux_inst9(Y[i], mux3_res[i], 1'b0, S[4]);
end

endgenerate

generate
for(i = 0; i < 16; i=i+1)
begin 
	MUX1_2x1 mux_inst10(Y[i], mux3_res[i], mux3_res[i+16], S[4]);
end

endgenerate

endmodule



// Left shifter
module SHIFT32_L(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

// TBD
genvar i;
wire [31:0] mux0_res;
wire [31:0] mux1_res;
wire [31:0] mux2_res;
wire [31:0] mux3_res;

// 1-bit shift
MUX1_2x1 mux_inst0(mux0_res[0], D[0], 1'b0, S[0]);
generate
for(i = 1; i < 32; i=i+1)
begin
	MUX1_2x1 mux_inst1(mux0_res[i], D[i], D[i-1], S[0]);
end
endgenerate

// 2-bit shift
MUX1_2x1 mux_inst2(mux1_res[0], mux0_res[0], 1'b0, S[1]);
MUX1_2x1 mux_inst3(mux1_res[1], mux0_res[1], 1'b0, S[1]);
generate
for(i = 2; i < 32; i=i+1)
begin
	MUX1_2x1 mux_inst4(mux1_res[i], mux0_res[i], mux0_res[i-2], S[1]);
end
endgenerate

// 3-bit shift
generate
for(i = 0; i < 4; i=i+1)
begin 
	MUX1_2x1 mux_inst5(mux2_res[i], mux1_res[i], 1'b0, S[2]);
end

endgenerate

generate
for(i = 4; i < 32; i=i+1)
begin 
	MUX1_2x1 mux_inst6(mux2_res[i], mux1_res[i], mux1_res[i-4], S[2]);
end

endgenerate

// 4-bit shift 
generate
for(i = 0; i < 8; i=i+1)
begin 
	MUX1_2x1 mux_inst7(mux3_res[i], mux2_res[i], 1'b0, S[3]);
end

endgenerate

generate
for(i = 8; i < 32; i=i+1)
begin 
	MUX1_2x1 mux_inst8(mux3_res[i], mux2_res[i], mux2_res[i-8], S[3]);
end

endgenerate

// 5-bit shift 
generate
for(i = 0; i < 16; i=i+1)
begin 
	MUX1_2x1 mux_inst9(Y[i], mux3_res[i], 1'b0, S[4]);
end

endgenerate

generate
for(i = 16; i < 32; i=i+1)
begin 
	MUX1_2x1 mux_inst10(Y[i], mux3_res[i], mux3_res[i-16], S[4]);
end

endgenerate

endmodule

