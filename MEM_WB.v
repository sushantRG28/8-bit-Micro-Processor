module MEM_WB(input clk,reset,
              input [7:0] readdata_in_1, resultalu_in_1,
              input [4:0] rd_in_1,
              input memtoreg_in1, regwrite_in1, // first control signal: fetches data either from memory or alu; second: for writing result back to register file
              output reg [7:0] readdata_out_1, //data from memory to be written
              output reg [7:0] resultalu_out_1, //data from alu
              output reg [4:0] rd_out_1,
              output reg memtoreg_out1, regwrite_out1,
              input [7:0] readdata_in_2, resultalu_in_2,
              input [4:0] rd_in_2,
              input memtoreg_in2, regwrite_in2, // first control signal: fetches data either from memory or alu; second: for writing result back to register file
              output reg [7:0] readdata_out_2, //data from memory to be written
              output reg [7:0] resultalu_out_2, //data from alu
              output reg [4:0] rd_out_2,
              output reg memtoreg_out2, regwrite_out2);
             
  always @(posedge clk)
    begin
      if (reset == 1'b1)
        begin
          readdata_out_1 = 8'b0;
          resultalu_out_1 = 8'b0;
          rd_out_1 = 5'b0;
          memtoreg_out1 = 1'b0;
          regwrite_out1 = 1'b0;
            readdata_out_2 = 8'b0;
          resultalu_out_2 = 8'b0;
          rd_out_2 = 5'b0;
          memtoreg_out2 = 1'b0;
          regwrite_out2 = 1'b0;
          
        end
      else
        begin
          readdata_out_1 <= readdata_in_1;
          resultalu_out_1 <= resultalu_in_1;
          rd_out_1 <= rd_in_1;
          memtoreg_out1 <= memtoreg_in1;
          regwrite_out1 <= regwrite_in1;
           readdata_out_2 <= readdata_in_2;
          resultalu_out_2 <= resultalu_in_2;
          rd_out_2 <= rd_in_2;
          memtoreg_out2 <= memtoreg_in2;
          regwrite_out2 <= regwrite_in2;
        end
    end
endmodule
