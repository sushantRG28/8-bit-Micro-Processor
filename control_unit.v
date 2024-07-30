`timescale 1ns / 1ps

module control_unit(
  input [6:0] opcode1,
  input [6:0] opcode2,
  input stall, 
  output reg memread1,
  output reg memtoreg1,
  output reg memwrite1,
  output reg aluSrc1,
  output reg regwrite1,
  output reg [1:0] Aluop1,
  output reg memread2,
  output reg memtoreg2,
  output reg memwrite2,
  output reg aluSrc2,
  output reg regwrite2,
  output reg [1:0] Aluop2,
  output reg branch1,
  output reg branch2
);

  always @(*) begin
    // Control signals for first opcode
    if (opcode1 == 7'b0000011) // Load instruction
    begin
      memread1 = 1'b1;
      memtoreg1 = 1'b1;
      regwrite1 = 1'b1;
      aluSrc1 = 1'b1;
      memwrite1 = 1'b0;
      Aluop1 = 2'b00;
      branch1=1'b0;
    end
    else if (opcode1 == 7'b0100011) // Store instruction
    begin
      memread1 = 1'b0;
      memtoreg1 = 1'bx;
      regwrite1 = 1'b0;
      aluSrc1 = 1'b1;
      memwrite1 = 1'b1;
      Aluop1 = 2'b00;
      branch1=1'b0;
    end
    else if (opcode1 == 7'b0110011) // R-Type Arithmetic instruction
    begin
      memread1 = 1'b0;
      memtoreg1 = 1'b0;
      regwrite1 = 1'b1;
      aluSrc1 = 1'b0;
      memwrite1 = 1'b0;
      Aluop1 = 2'b10;
      branch1=1'b0;
    end
    else if (opcode1 == 7'b0010011) // I-Type Arithmetic Instruction
    begin
      memread1 = 1'b0;
      memtoreg1 = 1'b0;
      regwrite1 = 1'b1;
      aluSrc1 = 1'b1;
      memwrite1 = 1'b0;
      Aluop1 = 2'b11;
      branch1=1'b0;      
    end
    else if (opcode1 == 7'b1100011) // I-Type Arithmetic Instruction
    begin
      memread1 = 1'b0;
      memtoreg1 = 1'bx;
      regwrite1 = 1'b0;
      aluSrc1 = 1'b0;
      memwrite1 = 1'b0;
      Aluop1 = 2'b01;
      branch1=1'b1;
      end
    else // default case
    begin
      memread1 = 1'b0;
      memtoreg1 = 1'b0;
      regwrite1 = 1'b0;
      aluSrc1 = 1'b0;
      memwrite1 = 1'b0;
      Aluop1 = 2'b00;
      branch1=1'b0;
    end
    

    // Control signals for second opcode
    if (opcode2 == 7'b0000011) // Load instruction
    begin
      memread2 = 1'b1;
      memtoreg2 = 1'b1;
      regwrite2 = 1'b1;
      aluSrc2 = 1'b1;
      memwrite2 = 1'b0;
      Aluop2 = 2'b00;
      branch2=1'b0;
    end
    else if (opcode2 == 7'b0100011) // Store instruction
    begin
      memread2 = 1'b0;
      memtoreg2 = 1'bx;
      regwrite2 = 1'b0;
      aluSrc2 = 1'b1;
      memwrite2 = 1'b1;
      Aluop2 = 2'b00;
      branch2=1'b0;
    end
     else if (opcode2 == 7'b1100011) // B-Type  instruction
    begin
      memread2 = 1'b0;
      memtoreg2 = 1'bx;
      regwrite2 = 1'b0;
      aluSrc2 = 1'b0;
      memwrite2 = 1'b0;
      Aluop2 = 2'b01;
      branch2=1'b1;
    end
    else if (opcode2 == 7'b0110011) // R-Type Arithmetic instruction
    begin
      memread2 = 1'b0;
      memtoreg2 = 1'b0;
      regwrite2 = 1'b1;
      aluSrc2 = 1'b0;
      memwrite2 = 1'b0;
      Aluop2 = 2'b10;
      branch2=1'b0;
    end
    else if (opcode2 == 7'b0010011) // I-Type Arithmetic Instruction
    begin
      memread2 = 1'b0;
      memtoreg2 = 1'b0;
      regwrite2 = 1'b1;
      aluSrc2 = 1'b1;
      memwrite2 = 1'b0;
      Aluop2 = 2'b11;
      branch2=1'b0;
    end
    else // default case
    begin
      memread2 = 1'b0;
      memtoreg2 = 1'b0;
      regwrite2 = 1'b0;
      aluSrc2 = 1'b0;
      memwrite2 = 1'b0;
      Aluop2 = 2'b00;
      branch2=1'b0;
    end

    // Handle stall signal
    if (stall == 1'b1) begin
      memread1 = 1'b0;
      memtoreg1 = 1'b0;
      regwrite1 = 1'b0;
      aluSrc1 = 1'b0;
      memwrite1 = 1'b0;
      Aluop1 = 2'b00;
      branch2=1'b0;

      memread2 = 1'b0;
      memtoreg2 = 1'b0;
      regwrite2 = 1'b0;
      aluSrc2 = 1'b0;
      memwrite2 = 1'b0;
      Aluop2 = 2'b00;
      branch2=1'b0;
    end
  end
endmodule
