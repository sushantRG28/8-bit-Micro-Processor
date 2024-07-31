`timescale 1ns / 1ps

module branch_unit(input branch_in1,branch_in2,
input [2:0] funct3_1,
input [2:0] funct3_2,
input [7:0] rd1_1,
input [7:0] rd1_2,
input [7:0] rd2_1,
input [7:0] rd2_2,
output reg branch1out, branch2out);

always @(*)
begin
    // Default values for outputs
    branch1out = 1'b0;
    branch2out = 1'b0;
    
 if (branch_in1) begin
    case (funct3_1)
      3'b000: // BEQ
        branch1out = (rd1_1 == rd2_1);
      3'b001: // BNE
        branch1out = (rd1_1 != rd2_1);
      3'b100: // BLT
        branch1out = ($signed(rd1_1) < $signed(rd2_1));
      3'b101: // BGE
        branch1out = ($signed(rd1_1) >= $signed(rd2_1));
      3'b110: // BLTU
        branch1out = (rd1_1 < rd2_1);
      3'b111: // BGTU
        branch1out = (rd1_1 > rd2_1);
      default:
        branch1out = 1'b0;
    endcase     
  end
  if(branch_in2) begin
  case (funct3_2)    
      3'b000: // BEQ
        branch2out = (rd1_2 == rd2_2);
      3'b001: // BNE
        branch2out = (rd1_2!= rd2_2);
      3'b100: // BLT
        branch2out = ($signed(rd1_2) < $signed(rd2_2));
      3'b101: // BGE
        branch2out = ($signed(rd1_2) >= $signed(rd2_2));
      3'b110: // BLTU
        branch2out = (rd1_2 < rd2_2);
      3'b111: // BGTU
        branch2out = (rd1_2 > rd2_2);
      default:
        branch2out = 1'b0;
    endcase
  end
  end
endmodule
