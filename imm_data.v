`timescale 1ns / 1ps
module imm_data(
    input [31:0] instruction,
    output reg [7:0] imm_data
);

  always @(*)
    begin
      case (instruction[6:5])
        2'b00: // I-type/Load
          begin
            imm_data = instruction[31:24]; 
          end
        2'b01: // S-type
          begin
            imm_data = {instruction[27:25], instruction[11:7]}; 
          end
        2'b11: // FOR B TYPE INSTRUCTIONS
        begin
        imm_data={instruction[28:25],instruction[11:8]};
        end
        2'b10: //not used values
          begin
            imm_data = 8'b0; 
          end
        default:
          begin
            imm_data = 8'b0; 
          end
      endcase
    end  

endmodule
