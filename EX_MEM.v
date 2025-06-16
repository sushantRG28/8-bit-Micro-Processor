module EX_MEM(
  input clk,reset,
  input [7:0] Result_in_alu_1,
  input [7:0] Result_in_alu_2,
  input [7:0] writedata_in_1, //2 bit mux2by1 output for load operation ig
  input [7:0] writedata_in_2,
  input [4:0] Rd_in_1, //IDEX output address of the destnation reg
  input [4:0] Rd_in_2,
  input memread_in1,memtoreg_in1,memwrite_in1,regwrite_in1,
  input memread_in2,memtoreg_in2,memwrite_in2,regwrite_in2, //IDEXX outputs control inputs 

  output reg [7:0] result_out_alu_1,
  output reg [7:0] writedata_out_1,
  output reg [4:0]rd_1,
  output reg Memread1,Memtoreg1, Memwrite1, Regwrite1,
   output reg [7:0] result_out_alu_2,
  output reg [7:0] writedata_out_2,
  output reg [4:0]rd_2,
  output reg Memread2,Memtoreg2, Memwrite2, Regwrite2);
  
  always @ (posedge clk)
    begin
      if (reset == 1'b1)
        begin
        
          result_out_alu_1 <= 8'b0;
          writedata_out_1 <= 8'b0;
          rd_1 <= 5'b0;
          
          Memread1 <= 1'b0;
          Memtoreg1 <=1'b0;
          Memwrite1 <= 1'b0;
          Regwrite1 <= 1'b0;
          result_out_alu_2 <= 8'b0;
          writedata_out_2 <= 8'b0;
          rd_2 <= 5'b0;
          
          Memread2 <= 1'b0;
          Memtoreg2 <=1'b0;
          Memwrite2 <= 1'b0;
          Regwrite2 <= 1'b0;
          
        end
      else
        begin
         
          result_out_alu_1 <= Result_in_alu_1;
          writedata_out_1 <= writedata_in_1;
          rd_1 <= Rd_in_1;
          Memread1 <= memread_in1;
          Memtoreg1 <= memtoreg_in1;
          Memwrite1 <= memwrite_in1;
          Regwrite1 <= regwrite_in1;
                   result_out_alu_2 <= Result_in_alu_2;
          writedata_out_2 <= writedata_in_2;
          rd_2 <= Rd_in_2;
          Memread2 <= memread_in2;
          Memtoreg2 <= memtoreg_in2;
          Memwrite2 <= memwrite_in2;
          Regwrite2 <= regwrite_in2;
          
        end
    end
endmodule
