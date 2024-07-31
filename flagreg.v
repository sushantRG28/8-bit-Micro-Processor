`timescale 1ns / 1ps

module flagreg(A,B,Oper,R,carry,flag,overflow);
 
    input [7:0]R,A,B;
    input [4:0]Oper;
    input carry,overflow;
    output reg [7:0]flag;
    
    ovrflw O(A,B,Oper,R,overflow);
    
    always @*
   begin
   flag[0]=carry;   // carry flag 
   
   if(R[7])
   flag[1]=1'b1;    // sign flag
   else flag[1]=1'b0;
   
   if (R==0)
   flag[2]=1'b1;    //zero flag
   else flag[2]=1'b0;
   
  flag[3]=~^R;    //even parity flag
  
 
  flag[4]=overflow; //overflow flag
  
  
  
  flag[5]=0;
  flag[6]=0;
  flag[7]=0;
  
     
    
  
    
    
 end   
endmodule



module ovrflw( A,B,Oper,R,overflow);
input [7:0] A,B,R;
input [4:0]Oper;
output  reg overflow;
 
 
 always@*
 begin
 if (Oper==00000)
 overflow = (~A[7] & ~B[7] & R[7]) | (A[7] & B[7] & ~R[7]);
 
 else if(Oper==00001)
   overflow = (~A[7] & B[7] & R[7]) | (A[7] & ~B[7] & ~R[7]);
 else 
 overflow=0;
 end
 endmodule
