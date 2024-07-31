`timescale 1ns / 1ps

module PC_tb;

    reg clk;
    reg res;

   
    wire [7:0] pcout;

    
   CCT Ass(pcout,clk,res);

   
    always #5 clk = ~clk;

    initial begin
       
        clk = 0;
        res = 1;
        #9 res=0;
      
       
        #52 $finish;
    end

  
endmodule