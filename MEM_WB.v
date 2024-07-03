module MEM_WB(input clk,reset,
              input [7:0] readdata_in, resultalu_in,
              input [4:0] rd_in,
              input memtoreg_in, regwrite_in, // first control signal: fetches data either from memory or alu; second: for writing result back to register file
              output reg [7:0] readdata_out, //data from memory to be written
              output reg [7:0] resultalu_out, //data from alu
              output reg [4:0] rd_out,
              output reg memtoreg_out, regwrite_out);
             
  always @(posedge clk)
    begin
      if (reset == 1'b1)
        begin
          readdata_out = 8'b0;
          resultalu_out = 8'b0;
          rd_out = 5'b0;
          memtoreg_out = 1'b0;
          regwrite_out = 1'b0;
          
        end
      else
        begin
          readdata_out <= readdata_in;
          resultalu_out <= resultalu_in;
          rd_out <= rd_in;
          memtoreg_out <= memtoreg_in;
          regwrite_out <= regwrite_in;
        end
    end
endmodule