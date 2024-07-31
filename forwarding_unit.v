`timescale 1ns / 1ps

module forwarding_unit(
                       input [4:0] rs_1,
                       input [4:0] rs_2,
                       input [4:0] exmem_rd1,
                       input [4:0] exmem_rd2,
                       input [4:0] memwb_rd1,
                       input [4:0] memwb_rd2,
                       input [4:0] reg_rd1, 
                       input [4:0] reg_rd2,
                       
                       input rgw1_mem,
                       input rgw2_mem,
                       input rgw1_wb,
                       input rgw2_wb,
                       input rgw1_reg,
                       input rgw2_reg,
                       
                       output reg [2:0] fa,
                       output reg [2:0] fb
                       );


always @(*)
 begin
   
   if(rgw2_mem && rs_1==exmem_rd2)
    begin
     fa = 3'b001;
    end
   else if(rgw1_mem && rs_1==exmem_rd1)
    begin
     fa = 3'b010;
    end
   else if(rgw2_wb && rs_1==memwb_rd2)
    begin
     fa = 3'b011;
    end
   else if(rgw1_wb && rs_1==memwb_rd1)
    begin
     fa = 3'b100;
    end
   else if(rgw2_reg && rs_1==reg_rd2)
    begin
     fa = 3'b101;
    end
   else if(rgw1_reg && rs_1==reg_rd1)
    begin
     fa = 3'b110;
    end
   else
    begin
     fa = 3'b000;
    end
    

   if(rgw2_mem && rs_2==exmem_rd2)
    begin
     fb = 3'b001;
    end
   else if(rgw1_mem && rs_2==exmem_rd1)
    begin
     fb = 3'b010;
    end
   else if(rgw2_wb && rs_2==memwb_rd2)
    begin
     fb = 3'b011;
    end
   else if(rgw1_wb && rs_2==memwb_rd1)
    begin
     fb = 3'b100;
    end
   else if(rgw2_reg && rs_2==reg_rd2)
    begin
     fb = 3'b101;
    end
   else if(rgw1_reg && rs_2==reg_rd1)
    begin
     fb = 3'b110;
    end
   else
    begin
     fb = 3'b000;
    end

       
 end
endmodule
