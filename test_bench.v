module test_bench();

  
    reg clk;
    reg reset;
     wire [31:0] instruction;
    wire [7:0] pcout;  // Changed to wire and corrected bit width
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
  wire [7:0]result_alu;
 
  
  wire [31:0] ifid_inst; //IFID pipeline module
  
  
  //////////////////////////////////IDEX///////////////////
  wire idex_regwrite;
  wire idex_memwrite;
  wire idex_memread;
  wire idex_memtoreg;
  wire idex_Alusrc;
  wire [1:0] idex_Aluop;
  wire [4:0] idex_rd;
  wire [7:0] idex_readdata1;
  wire [7:0] idex_readdata2;
  wire [7:0] idex_imm_data;
  wire [2:0] idex_funct3;
  wire [6:0] idex_funct7;
  //////////////////////////////////IDEX///////////////////
  
  ////////////////EXMEM && MEMWB////////////////////////////
  
  wire [7:0] exmem_result_alu;
  wire [7:0] writedata_out;
  wire [7:0] readdata;
  wire [7:0] memwb_readdata;
  wire [7:0] memwb_result_alu;
  wire [4:0] exmem_rd;
  wire [4:0] memwb_rd;
  wire exmem_memread;
  wire exmem_memtoreg;
  wire exmem_memwrite;
  wire exmem_regwrite;
  wire memwb_memtoreg;
  wire memwb_regwrite;
  
    ////////////////EXMEM && MEMWB////////////////////////////
  
  
  
    // Instantiate the modules
    CCT pccount (pcout,clk,reset);
    instruc_mem A (pcout,instruction);
    
   //IFID pipeline module
   IF_ID ifid(clk,pcout,instruction,reset,ifid_inst);
    
    instruction_splitter parser (ifid_inst,opcode,rd,funct3,rs1,rs2,funct7);
     control_unit CU (opcode,memread,memtoreg,memwrite,aluSrc,regwrite,Aluop);

     
     
//     //IDEX pipeline module //////////////////////////////////////////////////////////
     registerFile RF (clk,reset,rs1,rs2,memwb_rd,writedata,memwb_regwrite,readdata1,readdata2);
     imm_data IMM (ifid_inst,imm_data);
     ID_EX idex(clk,reset,memwrite,memread,memtoreg,aluSrc,regwrite,
                  Aluop,rd,readdata1,readdata2,imm_data,funct3,funct7,
                  
                  idex_memwrite,idex_memread,idex_memtoreg,idex_Alusrc,idex_regwrite,
                  idex_Aluop,
                  idex_rd,
                  idex_readdata1,idex_readdata2,
                  idex_imm_data,idex_funct3,idex_funct7);
      ALU_control Cualu (idex_funct3,idex_funct7,idex_Aluop,aluopc);   
      ALU calc(idex_readdata1,y,aluopc,zero,result_alu);
      mux rd2(idex_imm_data,idex_readdata2,idex_Alusrc,y);
               



//////////////////////EXMEM && MEMWB//////////////////////


EX_MEM exmem(clk,reset,result_alu,idex_readdata2,idex_rd,
       idex_memread,idex_memtoreg,idex_memwrite,idex_regwrite, 
  
       exmem_result_alu,
       writedata_out,
       exmem_rd,
       exmem_memread,exmem_memtoreg,exmem_memwrite,exmem_regwrite);
       
data_mem dmem(writedata_out,exmem_result_alu,exmem_memwrite,clk,exmem_memread,

             readdata);
       
MEM_WB memwb(clk,reset,readdata,exmem_result_alu,exmem_rd,
              exmem_memtoreg,exmem_regwrite,
              
              memwb_readdata,
              memwb_result_alu,
              memwb_rd,
              memwb_memtoreg,memwb_regwrite);
              
mux read(memwb_readdata,memwb_result_alu,memwb_memtoreg,
         writedata);


     
     

   

  
    
    // Generate clock signal
   
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        #6 reset=0;
        #200 $finish;
    end

    // Monitor the signals
    initial begin
        $monitor("Time=%0t | imm_data=%b, instruction=%b, opcode=%b, rd=%b, funct3=%b, rs1=%b, rs2=%b, funct7=%b", 
                 $time, imm_data,instruction,opcode, rd, funct3, rs1, rs2, funct7);
    end

endmodule
