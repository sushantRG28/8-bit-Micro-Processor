`timescale 1ns / 1ps

module hazard_detector(input memread,
                       input [4:0] rd,
                       input [31:0] instruction,
                       output reg stall);

initial begin
 stall = 1'b0;
end
                       
always @ *
 begin
  if(memread == 1'b1 && ((rd == instruction[19:15]) || (rd == instruction[24:20])))
   stall = 1'b1;
  else
   stall = 1'b0;
 end

endmodule
