module instruc_mem(
    input [7:0] inst_address,
    output reg [31:0] instruction1,
    output reg [31:0] instruction2
);

    reg [7:0] inst_mem[255:0];

    initial begin
        {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h00500093;  // LI x1, 5
        {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'hff200113;  // LI x2, -14
        {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h00f00193; // LI x3, 15
        {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h01200213; // LI x4, 18
        {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'h01400293; // LI x5, 20
        {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'h01900313; // LI x6, 25
        {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h02800393; // LI x7, 40
        {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'hff400413; // LI x8, -12
        
        {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h00608223; // SB x6, 4(x1)
        {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h00438023; // SB x4, 0(x7)

        // R-Type
        {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h002085b3; // ADD x11, x1, x2
        {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'h00b18633; // ADD x12, x3, x11 //
        {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'h0053f6b3; // AND x13, x5, x7
        {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'h00664733; // XOR x14, x12, x6
        {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h0070e7b3; // OR x15, x1, x7
        {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'h00418f33; // ADD x30, x3, x4
        {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'h00730f33; // ADD x30, x6, x7 // 

        // I-Type 
        {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'h00c10813; // ADDI x16, x2, 12
        {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'h01e27893; // ANDI x17, x4, 30
        {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'h0140ca13; // XORI x20, x1, 20
        {inst_mem[83], inst_mem[82], inst_mem[81], inst_mem[80]} = 32'h00379a93; // SLLI x21, x15, 3
        {inst_mem[87], inst_mem[86], inst_mem[85], inst_mem[84]} = 32'h00755b13; // SRLI x22, x10, 7
        {inst_mem[91], inst_mem[90], inst_mem[89], inst_mem[88]} = 32'h40665b93; // SRAI x23, x12, 6
        
        // M-Type 
        {inst_mem[95], inst_mem[94], inst_mem[93], inst_mem[92]} = 32'h02208d33; // MUL x26, x1, x2
        {inst_mem[99], inst_mem[98], inst_mem[97], inst_mem[96]} = 32'h02859db3; // MULH x27, x11, x8
        {inst_mem[103], inst_mem[102], inst_mem[101], inst_mem[100]} = 32'h0276b9b3; // MULHU x19, x13, x7
        {inst_mem[107], inst_mem[106], inst_mem[105], inst_mem[104]} = 32'h0267a933; // MULHSU x18, x15, x6
        {inst_mem[111], inst_mem[110], inst_mem[109], inst_mem[108]} = 32'h0260d533; // DIVU x10, x1, x6
        {inst_mem[115], inst_mem[114], inst_mem[113], inst_mem[112]} = 32'h0220e4b3; // REM x9, x1, x2
        {inst_mem[119], inst_mem[118], inst_mem[117], inst_mem[116]} = 32'h0217fe33; // REMU x28, x15, x1
        {inst_mem[123], inst_mem[122], inst_mem[121], inst_mem[120]} = 32'h02244eb3; // DIV x29, x8, x2
    end

    always @ (inst_address) begin
        instruction1[7:0] = inst_mem[inst_address + 0]; 
        instruction1[15:8] = inst_mem[inst_address + 1]; 
        instruction1[23:16] = inst_mem[inst_address + 2]; 
        instruction1[31:24] = inst_mem[inst_address + 3]; 

        instruction2[7:0] = inst_mem[inst_address + 4]; 
        instruction2[15:8] = inst_mem[inst_address + 5]; 
        instruction2[23:16] = inst_mem[inst_address + 6]; 
        instruction2[31:24] = inst_mem[inst_address + 7]; 
    end
endmodule
