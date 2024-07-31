`timescale 1ns / 1ps



module instructionmem(

    );
    reg clk;
    reg res;
    wire out;
    
    
 //   instruc_mem A (inst_address,instruction);
    CCT A (out,clk,res);
    initial
    begin
    clk=0;
    forever #5 clk=~clk;
end

initial
begin
res=1;
#9 res=0;
end
endmodule
