
`timescale 1ns / 1ps



module CCT (pcout,clk,res,pcwrite);
      
    input clk;
   input pcwrite;        
    input res;           
    wire [7:0] out;    
 output [7:0] pcout;  // Current PC value
    // Instantiate the PC module
    PC D (out,clk,res,pcout,pcwrite);
       
    // Instantiate the PC_addr module
    PC_addr K (pcout,out);
    
endmodule

module PC (PC_in,clk,reset,PC_out,pcwrite);
    input [7:0] PC_in;   
    input clk;
  input pcwrite ;         
    input reset;         
    output reg [7:0] PC_out ;


    always @(posedge clk or posedge reset) begin
        if (reset) begin        
            PC_out <= 8'd0; 
        end else begin
        if(pcwrite)
        begin
            PC_out <= PC_in;
            end
        end
    end

endmodule





module PC_addr (a,b);
    input  [7:0] a;// Current PC value
    output [7:0] b;  // Next PC value
 assign b = a + 8'd4;  //  next instruction is given by adding 4 to the previous one
endmodule




