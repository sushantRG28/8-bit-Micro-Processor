`timescale 1ns / 1ps

module CCT (
    output [7:0] pcout,  // Current PC value
    input clk,
    input res,
    input stall,
    input rollback,
    input branch1,
    input branch2,
    input [7:0] immdata 
);
    wire [7:0] next_pc;

   
    PC D (.PC_in(next_pc), .clk(clk), .reset(res), .stall(stall), .PC_out(pcout));


   NextPCLogic PC(clk,res,rollback,pcout,next_pc,branch1,branch2,immdata);
endmodule

module PC (PC_in,clk,reset,stall,PC_out);
    input [7:0] PC_in;     
    input clk;          
    input reset;
    input stall;         
    output reg [7:0] PC_out ;


    always @(posedge clk or posedge reset) begin
        if (reset) begin        
            PC_out <= 8'd0;
        end else if (stall == 1'b0)
         begin
            PC_out <= PC_in;
        end
    end

endmodule

module NextPCLogic (
    input wire clk,
    input wire rst,
    input wire rollback,
    input wire [7:0] current_pc,
    output reg [7:0] next_pc,
    input wire branch1,
    input wire branch2,
    input wire signed [7:0] immdata
);

     always @(*) begin
        if (rst) begin
            next_pc <= 8'b0;
        end else begin
            if (rollback) begin
                next_pc <= current_pc + 4;
            end else if (branch1) begin
                next_pc <= current_pc + (immdata * 4);
            end else if (branch2) begin
                next_pc <= current_pc + (immdata * 4) + 4;
            end else begin
                next_pc <= current_pc + 8;
            end
        end
    end
endmodule
