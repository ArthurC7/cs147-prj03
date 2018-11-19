`timescale 1ns/1ps

module mult_tb;

wire [31:0] HI;
wire [31:0] LO;
reg [31:0] MCND;
reg [31:0] MLPR;

MULT32_U unsigned_inst(HI, LO, MCND, MLPR);

initial
begin
#5 MCND = 32'b111; 
   MLPR = 32'b11;

end

endmodule
