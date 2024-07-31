`timescale 1ns / 1ps

module eight_by_one_mux(input [7:0] a,
                        input [7:0] b,
                        input [7:0] c,
                        input [7:0] d,
                        input [7:0] e,
                        input [7:0] f,
                        input [7:0] g,
                        
                        input [2:0] s,
                        
                        output reg [7:0] o
                        );
                        
always @ (*)
 begin
  case (s)
   3'b000: o=a;
   3'b001: o=b;
   3'b010: o=c;
   3'b011: o=d;
   3'b100: o=e;
   3'b101: o=f;
   3'b110: o=g;
  endcase
 end
endmodule
