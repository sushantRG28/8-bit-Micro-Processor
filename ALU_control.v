`timescale 1ns / 1ps

module ALU_control(funct3,funct7,Op,ALUOp);
    input [2:0] funct3;
    input [6:0] funct7;
    input [1:0] Op;
    output reg [3:0] ALUOp;
    wire [3:0] func;
    assign func = {funct7[5],funct3};
    
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
          4'b0011: ALUOp = 4'b0111; //SLT
            default: ALUOp = 4'b1111; // Default 
         endcase
         case ({funct7,funct3})
         10'b0000001000: ALUOp = 4'b1000;//Multiply lsb
         10'b0000001011: ALUOp = 4'b1001;//Multiply hsb
         10'b0000001101: ALUOp = 4'b1010;//div unsign 
         10'b0000001111: ALUOp = 4'b1011;//rem unsign
         default: ALUOp = 4'b1111; // Default 
         endcase
         end
         2'b11:
         begin
         case (funct3)
          3'b000: ALUOp = 4'b0000; //addni
          3'b111: ALUOp = 4'b0010; //andi
          3'b110: ALUOp = 4'b0011;//ori
          3'b100: ALUOp = 4'b0100; //xori
          3'b001: ALUOp = 4'b0101; //LLSi dbt
          3'b101: ALUOp = 4'b0110; //LRSi dbt
          3'b011: ALUOp = 4'b0111; //SLTi
            default: ALUOp = 4'b1111; // Default 
         
      
         endcase
         
         
         
         
         end
        default: ALUOp = 4'b1111; // Default 
       endcase
    end
    
    
    
endmodule

