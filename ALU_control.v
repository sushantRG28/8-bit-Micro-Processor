`timescale 1ns / 1ps

module ALU_control(func,Op,ALUOp);
    input [3:0] func;
    input [1:0] Op;
    output reg [3:0] ALUOp;

    
    always @(*) begin
        case (Op)
            2'b00: ALUOp = 4'b0000; //addn of addresses
            2'b01: ALUOp = 4'b0001; //sub for comparision
            2'b10:
             begin
          case (func)
           4'b0000: ALUOp = 4'b0000; //addn
          4'b1000: ALUOp = 4'b0001;//sub
          4'b0111: ALUOp = 4'b0010; //and
          4'b0110: ALUOp = 4'b0011;//or
          4'b0100: ALUOp = 4'b0100; //xor
          4'b0001: ALUOp = 4'b0101; //LLS
          4'b0101: ALUOp = 4'b0110; //LRS
         default: ALUOp = 4'b1111; // Default 
         endcase
         end
        default: ALUOp = 4'b1111; // Default 
       endcase
    end
    
    
    
endmodule
