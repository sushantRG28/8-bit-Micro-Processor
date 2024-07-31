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
            imm_data = instruction[27:20]; 
          end
        2'b01: // S-type
          begin
            imm_data = {instruction[27:25], instruction[11:7]}; // Combining the two parts of the S-type immediate
          end
        2'b10, 2'b11: // These are not be used, so we set it to default
          begin
            imm_data = 8'b0; // Default case to handle unused values
          end
        default:
          begin
            imm_data = 8'b0; 
          end
      endcase
    end  

endmodule
