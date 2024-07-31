`timescale 1ns / 1ps



module cncn(a,b,ALuop,funcn,res,z


    );
    input [7:0]a,b;
    output [7:0]res;
    input [1:0]ALuop;
    input [3:0]funcn;
    output z;
    wire  [3:0]aluop;
    
    ALU_control K(funcn ,ALuop,aluop);
    ALU H(a,b,aluop,z,res);
    
        
    
    
endmodule
