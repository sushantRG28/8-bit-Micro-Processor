`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2024 16:27:09
// Design Name: 
// Module Name: instr_register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instr_register(
input [31:0]instruction,
input clk,
input reset,
input irwrite,
output reg [31:0] inst_out

    );
    
    
    always@(posedge clk)
    begin
    if(reset)
    begin
    inst_out <= 32'b0;
    end
    else if(irwrite)
    begin
    inst_out<= instruction;
    end
    else
    begin
    inst_out = instruction;
    end
    end
endmodule
