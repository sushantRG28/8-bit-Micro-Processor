`timescale 1ns / 1ps
module hazard_unit(input branch,
input clk,
output reg ifidflush);

always @(*) begin
    if (branch) begin
        ifidflush = 1;
       
    end else begin
        ifidflush = 0;
        
    end
end
endmodule
