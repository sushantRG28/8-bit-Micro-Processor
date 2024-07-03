module IF_ID(input clk,
             input [7:0] pc_out, 
             input [31:0] instruction,
             input reset,
             output reg [31:0] instruction_out
             );
             
always @(posedge clk)
  begin
    if(reset==1'b1)
    begin
      instruction_out=32'b0;
   end
    else 
    begin
      instruction_out<=instruction;
    end
  end
endmodule
