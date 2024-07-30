`timescale 1ns / 1ps

module ALU_control(funct3,funct7,Op,ALUOp);
    input [2:0] funct3;
    input [6:0] funct7;
    input [1:0] Op;
    output reg [4:0] ALUOp;
    
   always @(*) begin
        case (Op)
            2'b00: ALUOp = 5'b00000; // Add (for addresses)
            2'b01: ALUOp = 5'b00001; // Subtract (for comparison)
            2'b10: begin
                   case ({funct7, funct3})
                    10'b0000000000: ALUOp = 5'b00000; // Addition
                    10'b0100000000: ALUOp = 5'b00001; // Subtraction
                    10'b0000000111: ALUOp = 5'b00100; // AND
                    10'b0000000110: ALUOp = 5'b00101; // OR
                    10'b0000000100: ALUOp = 5'b00110; // XOR
                    10'b0000000001: ALUOp = 5'b00111; // Logical Left Shift (LLS)
                    10'b0000000101: ALUOp = 5'b01000; // Logical Right Shift (LRS)
                    10'b0000000011: ALUOp = 5'b01010; // Set Less Than (SLT)
                    10'b0000000010: ALUOp = 5'b01011; // Set Less Than (SLT) signed
                    10'b0000001000: ALUOp = 5'b01100; // signed Multiply LSB
                    10'b0000001001: ALUOp = 5'b01101; // signed Multiply MSB
                    10'b0000001010: ALUOp = 5'b10100; // Signed Multiply Unsigned Operand
                    10'b0000001011: ALUOp = 5'b10001; // Unsigned Multiply Signed Operand
                    10'b0000001100: ALUOp = 5'b10010; // Signed Division
                    10'b0000001101: ALUOp = 5'b01110; // Unsigned Division
                    10'b0000001110: ALUOp = 5'b10011; // Signed Remainder
                    10'b0000001111: ALUOp = 5'b01111; // Unsigned Remainder
                    10'b0100000101: ALUOp = 5'b01001; // Unsigned Remainder
                   default: ALUOp = 5'b11111; // Default
                endcase
            end
            2'b11: begin
                case (funct3)
                    3'b000: ALUOp = 5'b00000; // Immediate Addition
                    3'b111: ALUOp = 5'b00100; // Immediate AND
                    3'b110: ALUOp = 5'b00101; // Immediate OR
                    3'b100: ALUOp = 5'b00110; // Immediate XOR
                    3'b001: ALUOp = 5'b00111; // Immediate Logical Left Shift
                    3'b101: ALUOp = 5'b01000; // Immediate Logical Right Shift
                    3'b011: ALUOp = 5'b01010; // Immediate Set Less Than
                    3'b010: ALUOp = 5'b01011; // Immediate Set Less Than signed
                   default: ALUOp = 5'b11111; // Default 
                endcase
            end
           default: ALUOp = 5'b11111; // Default 
        endcase
    end
endmodule
