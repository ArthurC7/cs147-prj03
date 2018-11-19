`timescale 1ns/1ps
`include "prj_definition.v"

module rc_add_sub_32_tb; 
reg [`DATA_INDEX_LIMIT:0] A, B;
reg SnA;
wire CO;
wire [`DATA_INDEX_LIMIT:0] Y;

RC_ADD_SUB_32 rc_inst(.Y(Y), .CO(CO), .A(A), .B(B), .SnA(SnA));

initial
begin
#5 	A=32'b1111; 
	B=32'b1111; 
	SnA=0;

#5 	A=32'b1111; 
	B=32'b11; 
	SnA=1;

/*
#5 A=0; B=1; CI=0;
#5 A=1; B=0; CI=0;
#5 A=1; B=1; CI=0;
#5 A=0; B=0; CI=1;
#5 A=0; B=1; CI=1;
#5 A=1; B=0; CI=1;
#5 A=1; B=1; CI=1;
#5 A=0; B=0; CI=0; // dummy case for better viewing of waveform
*/
end

endmodule
