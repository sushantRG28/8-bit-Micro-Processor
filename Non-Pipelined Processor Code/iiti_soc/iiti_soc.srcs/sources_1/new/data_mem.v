`timescale 1ns / 1ps
module data_mem
  (input [7:0] write_data,
   input [7:0] address,
   input memwrite, clk,memread,
   output reg [7:0] read_data);
  
  reg [7:0] mem [63:0]; //memory array there are 64 rows of 8bit data, there are 64 memory spaces
  integer i;
  initial
    begin
      for (i=0; i<64; i=i+1)
        begin
          mem[i] = i;
    
        end
   
    end
 
  
  always @ (*)
    begin
      if (memread)
        begin
          read_data[7:0] = mem[address];
        end
    end
  always @(posedge clk)
    begin
      if (memwrite)
        begin
          mem[address] = write_data[7:0];
          
        end
    end
endmodule