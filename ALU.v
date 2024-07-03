`timescale 1ns / 1ps
module ALU(A, B, oper, zero, R);
    input [7:0] A, B;
    input [3:0] oper;
    output reg zero;
    output reg [7:0] R;
    reg [15:0] mul_res; 

    always @*
    begin
        case (oper)
            4'b0000 : R = A + B;           // addition 0 
            4'b0001 : R = A - B;           // subtraction 1
            4'b0010 : R = A & B;           // bitwise AND 2
            4'b0011 : R = A | B;           // bitwise OR 3
            4'b0100 : R = A ^ B;           // bitwise XOR 4
            4'b0101 : R = A << B[4:0];          // logical left shift 5
            4'b0110 : R = A >> B[4:0];          // logical right shift 6
            4'b1000 :
            begin
             mul_res = A * B;
             R = mul_res[7:0];
             end           // MUL lsb 8
            4'b1001 : 
            begin
             mul_res = A * B;
             R = mul_res[15:8];
             end    // MULHSB (extracting MSB of A * B) 9
            4'b1010 : R = A / B;           // division 10
            4'b1011 : R = A % B;           // remainder 11
            4'b0111 : R = (A < B) ? 8'b1 : 8'b0; // unsigned comparison (SLT) 7
            default : R = 8'b0;            // default case

        endcase

        if (R == 8'b0)
            zero = 1'b1;
        else
            zero = 1'b0;
    end
endmodule
