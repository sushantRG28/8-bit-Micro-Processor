module IF_ID(input clk,
             input [7:0] pc_out, 
             input [31:0] instruction1,
             input [31:0] instruction2,
             input reset,
             input stall,
             output reg [31:0] instruction_out1,
             output reg [31:0] instruction_out2,
             input flush
             );
             
always @(posedge clk)
  begin
    if(reset==1'b1|| flush)
    begin
      instruction_out1=32'b0;
       instruction_out2 =32'b0;
   end
    else if (stall == 1'b0)
    begin
      instruction_out1<=instruction1;
      instruction_out2<=instruction2;
    end
  end
endmodule
