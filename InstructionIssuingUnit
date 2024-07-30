module InstructionIssuingUnit (
    input wire clk,
    input wire rst,
    input wire [31:0] instr1,  // First instruction from I-Cache
    input wire [31:0] instr2,  // Second instruction from I-Cache
    output reg [31:0] issue_instr1, // First instruction to be issued
    output reg [31:0] issue_instr2, // Second instruction to be issued
    output reg rollback
);
    reg [31:0] hold_instr;
    reg has_dependency;
    integer cycle_count;  // Counter for clock cycles

    // Initialize the counter
    initial begin
        cycle_count = 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            issue_instr1 <= 32'b0;
            issue_instr2 <= 32'b0;
            hold_instr <= 32'b0;
            rollback <= 1'b0;
            has_dependency <= 1'b0;
            cycle_count <= 0;  // Reset cycle count on reset
        end else begin
            // Dependency check (simplified example)
            if (instr1[11:7] == instr2[19:15] || instr1[11:7] == instr2[24:20] || instr1[6:0]==7'b1100011) begin
                has_dependency <= 1'b1;
                hold_instr <= instr2;
                rollback <= 1'b1;
                issue_instr1 <= instr1;
                issue_instr2 <= 32'b0;  // Only issue instr1, delay instr2
            end else if (has_dependency) begin
                issue_instr1 <= hold_instr;
                issue_instr2 <= instr1;  // Issue held instruction and next instruction in sequence
                rollback <= 1'b0;
                has_dependency <= 1'b0;
            end else begin
                issue_instr1 <= instr1;
                issue_instr2 <= instr2;  // Issue both instructions
                rollback <= 1'b0;
            end

            // Increment the clock cycle counter
            cycle_count <= cycle_count + 1;
        end
    end

endmodule
