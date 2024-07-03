module IF_ID(input clk,
             input [7:0] pc_out, 
             input [31:0] instruction,
             input reset,
//             input IFIDwrite,
             //input flush,
            // output reg [7:0] A_out,
             output reg [31:0] instruction_out
             );
             
always @(posedge clk)
  begin
    if(reset==1'b1)
    begin
     // A_out=8'b0;
      instruction_out=32'b0;
   end
    else 
    begin
     // A_out=pc_out;
      instruction_out<=instruction;
    end
  end
endmodule