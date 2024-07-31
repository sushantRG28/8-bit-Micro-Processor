`timescale 1ns / 1ps

module registerFile(
    input clk,
    input reset,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [7:0] writedata,
    input reg_write,
    output reg [7:0] readdata1,
    output reg [7:0] readdata2
);
    integer i;
    reg [7:0] registers [31:0];

    // Initialize registers
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 8'd0;
        end
    end
    
    // Keeping the register 0 is always zero
    always @(*) begin
        registers[0] = 8'd0;
    end

    // Read Data Logic
    always @(*) begin
        if (reset) begin
            readdata1 = 8'd0;
            readdata2 = 8'd0;
        end else begin
            readdata1 = registers[rs1];
            readdata2 = registers[rs2];
        end
    end

    // Write Data Logic
    always @(negedge clk) begin
        if (reg_write && rd != 0) begin
            registers[rd] <= writedata;
        end
    end

endmodule
