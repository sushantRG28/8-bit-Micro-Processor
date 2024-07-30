`timescale 1ns / 1ps

module ALU(A, B,oper,R,flag);
input [7:0] A, B;                
    input [4:0] oper;          
    reg carry;
    wire overflow;
    output reg [7:0] R;        
    reg [15:0] mul_res;       
    output  [7:0]flag;
    
     flagreg F(A,B,oper,R,carry,flag,overflow);  
   

    always @* begin
        case (oper)
            
            5'b00000 : {carry,R} = A + B;                // unsigned addition
            5'b00001 : {carry,R} = A - B;                // unsigned subtraction
            5'b00010 :   begin
             R = $signed(A) + $signed(B);
             end                     // signed addition

            5'b00011 :  begin
             R = $signed(A) - $signed(B); // signed subtraction
             end

            
            5'b00100 : R = A & B;                // bitwise AND
            5'b00101 : R = A | B;                // bitwise OR
            5'b00110 : R = A ^ B;                // bitwise XOR
            
            5'b00111 : R = A << B[4:0];          // logical left shift (5 bits for shift)
            5'b01000 : R = A >> B[4:0];          // logical right shift (5 bits for shift)
            5'b01001 : R = $signed(A) >>> B[4:0]; // arithmetic right shift
            5'b01010 : R = (A < B) ? 8'b1 : 8'b0; // unsigned comparison (SLT)
            5'b01011 : R = ($signed(A) < $signed(B)) ? 8'b1 : 8'b0; // signed comparison (SLT) 
            
            5'b01100 : begin                       // MUL LSB
                mul_res = $signed( A) *$signed(B);
                R = mul_res[7:0];
            end
            5'b01101 : begin                       // MUL MSB
                mul_res = $signed( A) *$signed(B);
                R = mul_res[15:8];
            end
            5'b01110 : begin
            if (B==0)
            R=8'b11111111;
            else
             R = A / B;
             end                // unsigned division

            5'b01111 : begin
            if (B==0)
            R=8'b0;
            else
             R = A % B;
             end                           // unsigned remainder

            
           
            // Store operations 
            5'b10000 : R = A + B;                  // store address calculation with base and offset
           // 5'b11011 : R = A + imm;                // store address calculation with base and immediate
            
            
            5'b10001 : begin                       // MUL MSB(signed)
                mul_res = A * B;
                R = mul_res[15:8];
            end
             5'b10100 : begin                       // MUL MSB(signed)
                mul_res =$signed( A) *(B);
                R = mul_res[15:8];
            end
            
             5'b10010 : begin
             if(B==0)
             R=0;
             else
             R = $signed(A) /( B);                  // signed division
            end
            5'b10011: begin
            if (B==0)
            R=8'b0;
            else
            R =$signed( A )% $signed( B);  end                // signed remainder
                 // signed remainder
            
            default : R = 8'b0;                     // default case
        endcase
       
          
   end 
endmodule
