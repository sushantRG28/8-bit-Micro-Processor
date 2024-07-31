`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2024 23:22:40
// Design Name: 
// Module Name: im_data_tb
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


module im_data_tb(

    );
    
    
    reg [31:0] instruction;
    wire [7:0] imm_data;
    
    
    
    imm_data A(instruction,imm_data);
     initial
     begin
   //  instruction=32'h09000193;
   //  #5 instruction=32'h1000213;//2
    instruction=32'h10000213;
  #20  instruction=32'h09000193;
   #20  instruction=32'h0032A023;
    #20  instruction=32'h0042A223;
    #10 $finish;
    end
    
     initial begin
        $monitor("Time=%0t | imm_data=%b, instruction=%b", 
                 $time, imm_data,instruction);
    end

endmodule
