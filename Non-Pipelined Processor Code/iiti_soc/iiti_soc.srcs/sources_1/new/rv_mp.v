`timescale 1ns / 1ps

module rv_mp(clk,reset);
     input clk;
    input reset;
     wire [31:0] instruction;
    wire [7:0] pcout;  
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;
    wire  memread;
  wire  memtoreg;
  wire  memwrite;
  wire  aluSrc;
  wire  regwrite;
  wire [1:0] Aluop;
  wire [7:0] writedata;
  wire [7:0] readdata1;
  wire [7:0] readdata2;
  wire [7:0] imm_data;
  wire [7:0]y;
  wire [3:0]aluopc;
  wire zero;
  wire [7:0]result;
  wire [3:0]func;
  wire [7:0] read_data; // for memory
    // Instantiate the modules
   CCT pccount (pcout,clk,reset);
    instruc_mem A (pcout,instruction);
    instruction_splitter parser (instruction,opcode,rd,funct3,rs1,rs2,funct7);
     control_unit CU (opcode,memread,memtoreg,memwrite,aluSrc,regwrite,Aluop);
     registerFile RF (
clk,
reset,
rs1,
rs2,
rd,
writedata,
regwrite,
readdata1,
readdata2
);
     imm_data IMM (instruction,imm_data);
      ALU_control Cualu (func,Aluop,aluopc);
     ALU calc(readdata1,y,aluopc,zero,result);
     mux rd2(readdata2,imm_data,aluSrc,y);
     data_mem Dmem
 (readdata2,
result,memwrite,clk,memread,
read_data);
     mux rdm(result,read_data,memtoreg,writedata);
       assign func = {funct7[5],funct3};
  
    
    endmodule