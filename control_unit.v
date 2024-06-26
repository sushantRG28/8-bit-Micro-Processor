`timescale 1ns / 1ps

module control_unit(
  input [6:0] opcode, 
  output reg memread,
  output reg memtoreg,
  output reg memwrite,
  output reg aluSrc,
  output reg regwrite,
  output reg [1:0] Aluop);

       always @(*) begin
    if (opcode == 7'b0000011) // Load instruction
    begin
      memread = 1'b1;
      memtoreg = 1'b1;
      regwrite = 1'b1;
      aluSrc = 1'b1;
      memwrite = 1'b0;
      Aluop = 2'b00;
    end
    else if (opcode == 7'b0100011) // Store instruction
    begin
      memread = 1'b0;
      memtoreg = 1'bx;
      regwrite = 1'b0;
      aluSrc = 1'b1;
      memwrite = 1'b1;
      Aluop = 2'b00;
    end
    else if (opcode == 7'b0110011) // R-Type Arithmetic instruction
    begin
      memread = 1'b0;
      memtoreg = 1'b0;
      regwrite = 1'b1;
      aluSrc = 1'b0;
      memwrite = 1'b0;
      Aluop = 2'b10;
    end
    else if (opcode == 7'b0010011) // I-Type Arithmetic Instruction
    begin
      memread = 1'b0;
      memtoreg = 1'b0;
      regwrite = 1'b1;
      aluSrc = 1'b1;
      memwrite = 1'b0;
      Aluop = 2'b00;
    end
    else // default case
    begin
      memread = 1'b0;
      memtoreg = 1'b0;
      regwrite = 1'b0;
      aluSrc = 1'b0;
      memwrite = 1'b0;
      Aluop = 2'b00;
    end
  end
  
 


endmodule
