`timescale 1ns / 1ps

module mux(a,b,s,y);
input [7:0]a,b;
input s;
output [7:0] y;

assign y=s?a:b;
endmodule
