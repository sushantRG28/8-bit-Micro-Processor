module ID_EX(
input clk,reset,
input memwrite_in1,memread_in1,memtoreg_in1,Alusrc_in1,regwrite_in1,//from CU
input [1:0] Aluop_in1,// from CU
input memwrite_in2,memread_in2,memtoreg_in2,Alusrc_in2,regwrite_in2,//from CU
input [1:0] Aluop_in2,
input [4:0] rd_in_1,
input [4:0] rd_in_2,
input [7:0] readdata1_in_1,readdata2_in_1,//from regfile
input [7:0] readdata1_in_2,readdata2_in_2,
input [7:0] imm_data_in_1,//imm data extractor
input [7:0] imm_data_in_2,
input  [2:0] func_in3_1,
input  [6:0] func_in7_1,
input  [2:0] func_in3_2,
input  [6:0] func_in7_2,
input [4:0] rs1_in_1,
input [4:0] rs2_in_1,
input [4:0] rs1_in_2,
input [4:0] rs2_in_2,

output  reg memwrite1,memread1,memtoreg1,Alusrc1,regwrite1,
output reg [1:0] Aluop1,
output  reg memwrite2,memread2,memtoreg2,Alusrc2,regwrite2,
output reg [1:0] Aluop2,
output  reg [4:0] rd_1,
output  reg [4:0] rd_2,
output  reg [7:0] readdata1_1,readdata2_1,
output  reg [7:0] readdata1_2,readdata2_2,
output  reg [7:0] imm_data_1,
output reg  [2:0] func_3_1,
output reg  [6:0] func_7_1,
output  reg [7:0] imm_data_2,
output reg  [2:0] func_3_2,
output reg  [6:0] func_7_2,
output reg [4:0] rs1_out_1,
output reg [4:0] rs2_out_1,
output reg [4:0] rs1_out_2,
output reg [4:0] rs2_out_2


    );
    always @(posedge clk)
    begin
    if(reset==1)
    begin
          rd_1 <= 5'b0;
           rd_2 <= 5'b0;
          imm_data_1 <= 8'b0;
           imm_data_2 <= 8'b0;
          readdata1_1 <= 8'b0;
          readdata2_1  <= 8'b0;
          readdata1_2 <= 8'b0;
          readdata2_2  <= 8'b0;
       
        func_3_1 <= 3'b0;
          func_7_1 <= 7'b0;
           func_3_2 <= 3'b0;
          func_7_2 <= 7'b0;
          memread1 <= 1'b0;
          memtoreg1 <=1'b0;
          memwrite1 <= 1'b0;
          regwrite1 <= 1'b0;
          Alusrc1 <= 1'b0;
          Aluop1 <= 2'b0;
              memread2 <= 1'b0;
          memtoreg2 <=1'b0;
          memwrite2 <= 1'b0;
          regwrite2 <= 1'b0;
          Alusrc2 <= 1'b0;
          Aluop2 <= 2'b0;
          rs1_out_1 <= 5'b0;
          rs2_out_1 <= 5'b0; 
          rs1_out_2 <= 5'b0;
          rs2_out_2 <= 5'b0;
          end
       
 else
        begin
          rd_1 <= rd_in_1;
          rd_2 <= rd_in_2;
          imm_data_1 <= imm_data_in_1;
           imm_data_2 <= imm_data_in_2;
          readdata1_1 <= readdata1_in_1;
          readdata2_1 <= readdata2_in_1;
             readdata1_2 <= readdata1_in_2;
          readdata2_2 <= readdata2_in_2;
          func_3_1 <= func_in3_1;
          func_7_1 <= func_in7_1;
          func_3_2 <= func_in3_2;
          func_7_2 <= func_in7_2;
          memread1 <= memread_in1;
         memtoreg1 <= memtoreg_in1;
          memwrite1 <= memwrite_in1;
         regwrite1 <= regwrite_in1;
          Alusrc1 <= Alusrc_in1;
          Aluop1 <= Aluop_in1;
           memread2 <= memread_in2;
         memtoreg2 <= memtoreg_in2;
          memwrite2 <= memwrite_in2;
         regwrite2 <= regwrite_in2;
          Alusrc2 <= Alusrc_in2;
          Aluop2 <= Aluop_in2;
           
          rs1_out_1 <= rs1_in_1;
          rs2_out_1 <= rs2_in_1;
          rs1_out_2 <= rs1_in_2;
          rs2_out_2 <= rs2_in_2;
          
        end
   end
endmodule
