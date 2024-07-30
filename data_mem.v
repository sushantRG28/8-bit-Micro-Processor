`timescale 1ns / 1ps

module data_mem(
  input [7:0] write_data_1,
  input [7:0] address_1,
  input memwrite_1, 
  input clk,
  input memread_1,
  output reg [7:0] read_data_1,

  input [7:0] write_data_2,
  input [7:0] address_2,
  input memwrite_2, 
  input memread_2,
  output reg [7:0] read_data_2
);

  reg [7:0] mem [255:0]; // Memory array, 256 rows of 8-bit data
  integer i;
  integer file; // File handle for writing

  // Initialize memory
  initial begin
    for (i = 0; i < 256; i = i + 1) begin
      mem[i] = i;
    end

    // Open a file for writing
    file = $fopen("datamemory.txt", "w");
    if (file == 0) begin
      $display("Error: Could not open file for writing.");
      $finish;
    end
  end

  // Read Data Logic for both datapaths
  always @(*) begin
    // Default values
    read_data_1 = 8'd0;
    read_data_2 = 8'd0;
    
    // Handle reads with priority for writes
    if (memread_1) begin
      if (memwrite_2 && address_1 == address_2) begin
        // Read data from the write port if the same address is written to
        read_data_1 = write_data_2;
      end else begin
        // Otherwise read from memory
        read_data_1 = mem[address_1];
      end
    end
    
    if (memread_2) begin
      if (memwrite_1 && address_2 == address_1) begin
        // Read data from the write port if the same address is written to
        read_data_2 = write_data_1;
      end else begin
        // Otherwise read from memory
        read_data_2 = mem[address_2];
      end
    end
  end

  // Write Data Logic for both datapaths
  always @(posedge clk) begin
    // Handle writes
    if (memwrite_1) begin
      mem[address_1] = write_data_1;
    end
    
    if (memwrite_2) begin
      mem[address_2] = write_data_2;
    end
  end

  // Write memory contents to file at the end of simulation
  initial begin
    #1000; 
    for (i = 0; i < 256; i = i + 1) begin
      $fdisplay(file, "mem[%0d] = %0d", i, mem[i]);
    end
    $fclose(file);
    $finish; 
  end

endmodule
