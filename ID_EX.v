module ID_EX(
input clk,reset,
input memwrite_in,memread_in,memtoreg_in,Alusrc_in,regwrite_in,//from CU
input [1:0] Aluop_in,// from CU
input [4:0] rd_in,
input [7:0] readdata1_in,readdata2_in,//from regfile
input [7:0] imm_data_in,//imm data extractor
input  [2:0] func_in3,
input  [6:0] func_in7,
output  reg memwrite,memread,memtoreg,Alusrc,regwrite,
output reg [1:0] Aluop,
output  reg [4:0] rd,
output  reg [7:0] readdata1,readdata2,
output  reg [7:0] imm_data,
output reg  [2:0] func_3,
output reg  [6:0] func_7



    );
    always @(posedge clk)
    begin
    if(reset==1)
    begin
          rd <= 5'b0;
          imm_data <= 8'b0;
          readdata1 <= 8'b0;
          readdata2  <= 8'b0;
       
        func_3 <= 3'b0;
          func_7 <= 7'b0;
          memread <= 1'b0;
          memtoreg <=1'b0;
          memwrite <= 1'b0;
          regwrite <= 1'b0;
          Alusrc <= 1'b0;
          Aluop <= 2'b0;
          end
       
 else
        begin
          rd <= rd_in;
          imm_data <= imm_data_in;
          readdata1 <= readdata1_in;
          readdata2 <= readdata2_in;
          func_3 <= func_in3;
          func_7 <= func_in7;
          memread <= memread_in;
         memtoreg <= memtoreg_in;
          memwrite <= memwrite_in;
         regwrite <= regwrite_in;
          Alusrc <= Alusrc_in;
          Aluop <= Aluop_in;
          
        end
   end
endmodule
