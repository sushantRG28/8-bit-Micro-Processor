`timescale 1ns / 1ps

module control_unit(
    input [6:0] opcode,
    input clk,
    input reset,
    input enable,
    output reg memread,
    output reg memtoreg,
    output reg memwrite,
    output reg aluSrc,
    output reg regwrite,
    output reg [1:0] Aluop,
    output reg pcwrite,
    output reg irwrite
);

    // State encoding
    parameter FETCH    = 3'b000,
              DECODE   = 3'b001,
              EXECUTE  = 3'b010,
              MEMORY   = 3'b011,
              WRITEBACK= 3'b100;

    reg [2:0] current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= FETCH;
        else if (enable)
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            FETCH: next_state = DECODE;
            DECODE: next_state = EXECUTE;
            EXECUTE: next_state = MEMORY;
            MEMORY: next_state = WRITEBACK;
            WRITEBACK: next_state = FETCH;
            default: next_state = FETCH;
        endcase
    end

    // Output logic
    always @(*) begin
        // Default values
        memread  = 1'b0;
        memtoreg = 1'b0;
        memwrite = 1'b0;
        aluSrc   = 1'b0;
        regwrite = 1'b0;
        Aluop   = 2'b00;
        pcwrite = 1'b0;
        irwrite = 1'b0;

        if (enable) begin
            case (current_state)
                FETCH: begin
                    pcwrite = 1'b1;  // Enable program counter to fetch the instruction
                    irwrite = 1'b1;  // Enable instruction register to capture the fetched instruction
                end
                DECODE: begin
                    // Decode stage control signals
                    // Typically, no control signals need to be set here; decoding happens implicitly
                end
                EXECUTE: begin
                    // Execute stage control signals
                    aluSrc = (opcode == 7'b0000011 || opcode == 7'b0010011); // Load or I-Type
                    Aluop = (opcode == 7'b0110011) ? 2'b10 : 2'b00; // R-Type or other
                end
                MEMORY: begin
                    // Memory stage control signals
                      aluSrc = (opcode == 7'b0000011 || opcode == 7'b0010011); // Load or I-Type
                    Aluop = (opcode == 7'b0110011) ? 2'b10 : 2'b00; 
                    if (opcode == 7'b0000011) begin // Load
                        memread = 1'b1;
                    end else if (opcode == 7'b0100011) begin // Store
                        memwrite = 1'b1;
                    end
                end
                WRITEBACK: begin
                    // Writeback stage control signals
                    aluSrc = (opcode == 7'b0000011 || opcode == 7'b0010011); // Load or I-Type
                    Aluop = (opcode == 7'b0110011) ? 2'b10 : 2'b00; 
                    if (opcode == 7'b0000011) begin // Load
                         memread = 1'b1;
                        memtoreg = 1'b1;
                        regwrite = 1'b1;
                    end else if (opcode == 7'b0110011 || opcode == 7'b0010011) begin // R-Type or I-Type
                        regwrite = 1'b1;
                    end
                end
                default: begin
                    memread = 1'b0;
                    memtoreg = 1'b0;
                    memwrite = 1'b0;
                    aluSrc = 1'b0;
                    regwrite = 1'b0;
                    Aluop = 2'b00;
                    pcwrite = 1'b0;
                    irwrite = 1'b0;
                end
            endcase
        end
    end
endmodule
