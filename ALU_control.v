`timescale 1ns / 1ps

module ALU_control(funct3, funct7, Op, ALUOp);
    input [2:0] funct3;
    input [6:0] funct7;
    input [1:0] Op;
    output reg [3:0] ALUOp;
    
    always @(*) begin
        case (Op)
            2'b00: ALUOp = 4'b0000; // addn of addresses
            2'b01: ALUOp = 4'b0001; // sub for comparison
            2'b10: begin
                case ({funct7, funct3})
                    10'b0000000000: ALUOp = 4'b0000; // addn
                    10'b0100000000: ALUOp = 4'b0001; // sub
                    10'b0000000111: ALUOp = 4'b0010; // and
                    10'b0000000110: ALUOp = 4'b0011; // or
                    10'b0000000100: ALUOp = 4'b0100; // xor
                    10'b0000000001: ALUOp = 4'b0101; // LLS
                    10'b0000000101: ALUOp = 4'b0110; // LRS
                    10'b0000000011: ALUOp = 4'b0111; // SLT
                    10'b0000001000: ALUOp = 4'b1000; // Multiply lsb
                    10'b0000001011: ALUOp = 4'b1001; // Multiply hsb
                    10'b0000001101: ALUOp = 4'b1010; // div unsigned
                    10'b0000001111: ALUOp = 4'b1011; // rem unsigned
                    default: ALUOp = 4'b1111; // Default
                endcase
            end
            2'b11: begin
                case (funct3)
                    3'b000: ALUOp = 4'b0000; // addni
                    3'b111: ALUOp = 4'b0010; // andi
                    3'b110: ALUOp = 4'b0011; // ori
                    3'b100: ALUOp = 4'b0100; // xori
                    3'b001: ALUOp = 4'b0101; // LLSi
                    3'b101: ALUOp = 4'b0110; // LRSI
                    3'b011: ALUOp = 4'b0111; // SLTi
                    default: ALUOp = 4'b1111; // Default
                endcase
            end
            default: ALUOp = 4'b1111; // Default
        endcase
    end
endmodule
