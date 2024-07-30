`timescale 1ns / 1ps

module registerFile(
    input clk,
    input reset,
    // First set of inputs
    input [4:0] rs1_1,
    input [4:0] rs2_1,
    input [4:0] rd_1,
    input [7:0] writedata_1,
    input reg_write_1,
    output reg [7:0] readdata1_1,
    output reg [7:0] readdata2_1,
    output reg [4:0] rd_out_1,
    output reg [7:0] writedata_out_1,
    output reg reg_write_out_1,
    // Second set of inputs
    input [4:0] rs1_2,
    input [4:0] rs2_2,
    input [4:0] rd_2,
    input [7:0] writedata_2,
    input reg_write_2,
    output reg [7:0] readdata1_2,
    output reg [7:0] readdata2_2,
    output reg [4:0] rd_out_2,
    output reg [7:0] writedata_out_2,
    output reg reg_write_out_2
);
    integer i;
    reg [7:0] registers [31:0];
    integer file;  // File descriptor
    reg first_write;  // Flag to indicate first write

    // Initialize registers and the first_write flag
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 8'd0;
        end
        first_write = 1;
    end
    
    // Ensure register 0 is always zero
    always @(*) begin
        registers[0] = 8'd0;
    end

    // Read Data Logic
    always @(*) begin
        if (reset) begin
            readdata1_1 = 8'd0;
            readdata2_1 = 8'd0;
            readdata1_2 = 8'd0;
            readdata2_2 = 8'd0;
        end else begin
            if (rd_1 == rs1_1) begin
                readdata1_1 = (reg_write_1) ? writedata_1 : registers[rs1_1];
            end else begin
                readdata1_1 = registers[rs1_1];
            end

            if (rd_1 == rs2_1) begin
                readdata2_1 = (reg_write_1) ? writedata_1 : registers[rs2_1];
            end else begin
                readdata2_1 = registers[rs2_1];
            end

            if (rd_2 == rs1_2) begin
                readdata1_2 = (reg_write_2) ? writedata_2 : registers[rs1_2];
            end else begin
                readdata1_2 = registers[rs1_2];
            end

            if (rd_2 == rs2_2) begin
                readdata2_2 = (reg_write_2) ? writedata_2 : registers[rs2_2];
            end else begin
                readdata2_2 = registers[rs2_2];
            end
        end
    end

    // Write Data Logic
    always @(posedge clk) begin
        if (reset) begin
            // Reset registers to default state if reset is asserted
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 8'd0;
            end
            rd_out_1 <= 5'd0;
            writedata_out_1 <= 8'd0;
            reg_write_out_1 <= 1'b0;
            rd_out_2 <= 5'd0;
            writedata_out_2 <= 8'd0;
            reg_write_out_2 <= 1'b0;
        end else begin
            // Write handling with priority to the second write
            if (reg_write_2 && rd_2 != 0) begin
                registers[rd_2] <= writedata_2;
                rd_out_2 <= rd_2;
                writedata_out_2 <= writedata_2;
                reg_write_out_2 <= reg_write_2;
            end
            if (reg_write_1 && rd_1 != 0 && rd_1 != rd_2) begin
                registers[rd_1] <= writedata_1;
                rd_out_1 <= rd_1;
                writedata_out_1 <= writedata_1;
                reg_write_out_1 <= reg_write_1;
            end
        end
    end

    // Write the contents of the register file to a text file
    always @(*) begin
        // Open file in write mode
        file = $fopen("register_contents.txt", "w");
        if (file) begin
            if (first_write) begin
                // Write headers to the file
                $fwrite(file, "%-10s %-10s %-10s\n", "regno.", "value", "deci");
                first_write = 0;  // Set flag to false after writing headers
            end
            for (i = 0; i < 32; i = i + 1) begin
                // Write register number, binary value, and decimal value to the file
                $fwrite(file, "%-10d %-10b (%d)\n", i, registers[i], registers[i]);
            end
            // Close the file
            $fclose(file);
        end else begin
            $display("Error: Could not open file for writing.");
        end
    end

endmodule
