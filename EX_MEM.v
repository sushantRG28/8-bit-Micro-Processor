module EX_MEM(
  input clk,reset,
 // input [63:0] Adder_out  //adder output----> for the branch instructions to caluclte the next branch 
  input [7:0] Result_in_alu,
 // input Zero_in,
  input [7:0] writedata_in, //2 bit mux2by1 output for load operation ig
  input [4:0] Rd_in, //IDEX output address of the destnation reg
  input memread_in,memtoreg_in,memwrite_in,regwrite_in, //IDEXX outputs control inputs 
  
//  output reg zero,
  output reg [7:0] result_out_alu,
  output reg [7:0] writedata_out,
  output reg [4:0]rd,
  output reg Memread,Memtoreg, Memwrite, Regwrite);
  
  always @ (posedge clk)
    begin
      if (reset == 1'b1)
        begin
          
       //   zero <= 1'b0;
          result_out_alu <= 8'b0;
          writedata_out <= 8'b0;
          rd <= 5'b0;
          
          Memread <= 1'b0;
          Memtoreg <=1'b0;
          Memwrite <= 1'b0;
          Regwrite <= 1'b0;
          
        end
      else
        begin
         
    //      zero <= Zero_in;
          result_out_alu <= Result_in_alu;
          writedata_out <= writedata_in;
          rd <= Rd_in;
          Memread <= memread_in;
          Memtoreg <= memtoreg_in;
          Memwrite <= memwrite_in;
          Regwrite <= regwrite_in;
          
        end
    end
endmodule