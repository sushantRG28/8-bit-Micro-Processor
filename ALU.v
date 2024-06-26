`timescale 1ns / 1ps



module ALU(A,B,oper,zero,R);
    input [7:0]A,B;
    input [3:0] oper;
    output reg zero ;
    output reg [7:0]R;
    always @*
    begin
    case (oper)
    4'b0000 : R=A+B;//addition
    4'b0001 : R=A-B;//sub 
    4'b0010 : R=A&B;//and
    4'b0011 : R=A|B;//or
    4'b0100 : R=A^B;//xor
    4'b0101 : R=A<<B;//logical left shift
    4'b0110 : R=A>>B;//logical Right shift
    endcase
    
     if (R==0)
     zero =1'b1;
     else 
     zero=1'b0;
     end 
    
    
endmodule
