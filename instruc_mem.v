module instruc_mem(input [7:0] inst_address,
    output reg [31:0] instruction);
    
 
    reg [7:0] inst_mem[87:0]; // inst_mem size/4 = nomber of instructions passed
     
    initial
    begin
    
    // Initializing Registers
        {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'b00000101000000000000000010010011 ;   //LI x1, 5
        {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'b00001010000000000000000100010011 ;   //LI x2, 10
      {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'b00010100000000000000001010010011 ;   //LI x5, 20
    {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'b00011110000000000000001100010011 ;   //LI x6, 30
    {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'b00101000000000000000010000010011 ;   //LI x8, 40
    {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'b00110010000000000000010010010011 ;   //LI x9, 50
    {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'b00111100000000000000010110010011 ;   //LI x11, 60
    {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'b01000110000000000000011000010011 ;   //LI x12, 70

    // Performing Operation
    {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'b00000101000010111000101100010011  ; // ADDI x22, x23, 5
    {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'b00000100000000101101110010010011  ; // LRSI x25, x5, 4 : 20(10100) shifted right by 4
    {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'b00000011000000101001110000010011  ; // LLSI x24, x5, 3 : 20(10100) shifter left 3 times
    {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'b00000101000000110100110100010011  ; // XORI x22, x6, 5 : 30(11110) xored with 5(00101)
    {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'b00000000101101100011011010110011   ; // SLT x13, x12, x11
    
    
//    {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'b00000000001000001000000110110011   ; // ADD x3, x1, x2
//    {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'b00000000011000101111001000110011   ; // AND x4, x5, x6
//    {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'b00000000100101000110001110110011   ; // OR x7, x8, x9
//    {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'b00000000110001011100010100110011   ; // XOR x10, x11, x12
//    {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'b00000000111101110001011010110011   ; // SLL x13, x14, x15
//    {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'b00000001001010001101100000110011   ; // SRL x16, x17, x18
//    {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'b00000101000010111000101100010011  ; // ADDI x22, x23, 5


        end
    
  always @ (inst_address)
    begin
      instruction[7:0] = inst_mem[inst_address+0];
      instruction[15:8] = inst_mem[inst_address+1];
      instruction[23:16] = inst_mem[inst_address+2];
      instruction[31:24] = inst_mem[inst_address+3];
    end
endmodule
