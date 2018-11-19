`timescale 1ns/1ps

module mux_tb_1; 
reg I0, I1, S;
wire Y;

MUX1_2x1 mux_1(.Y(Y),.I0(I0), .I1(I1), .S(S));

initial
begin
#5 I0=1; I1=0; S=0;
#5 I0=1; I1=0; S=1;
end

endmodule
