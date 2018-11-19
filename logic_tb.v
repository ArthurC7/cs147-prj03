`timescale 1ns/1ps

module logic_tb;

wire [31:0] Y;
reg [31:0] A;

TWOSCOMP32 complement32(Y, A);

initial
begin
#5 A = 32'b1011;

end

endmodule
