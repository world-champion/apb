module apb_slave(input pclk , rst_n, paddr, psel, penable, pwrite, pwdata,output pready ,prdata);
import uvm_pkg :: * ;
	`include "uvm_macros.svh"
 logic pclk;
 logic rst_n;
 logic [31:0] paddr;
 logic psel;
 logic penable;
 logic pwrite;
 logic [31:0] pwdata;
 logic pready;
 logic [31:0] prdata;
 logic [28:0] mem [0:256];
 logic [1:0] apb_st;
 const logic [1:0] SETUP=0;
 const logic [1:0] W_ENABLE=1;
 const logic [1:0] R_ENABLE=2;
 
 always @(posedge pclk or negedge rst_n) begin
    
 if (rst_n==0) begin
 apb_st <=0;
 prdata <=0;
 pready <=1;
 for(int i=0;i<256;i++) mem[i]=i;
 end
 else begin
 case (apb_st)
 SETUP: begin
 prdata <= 0;
 if (psel && !penable) begin
 if (pwrite) begin
 apb_st <= W_ENABLE;
 end
 else begin
 apb_st <= R_ENABLE;
 prdata <= mem[paddr];
 end
 end
 end
 W_ENABLE: begin
 if (psel && penable && pwrite) begin
 mem[paddr] <= pwdata;
 end
 apb_st <= SETUP;
 end
 R_ENABLE: begin
 apb_st <= SETUP;
 end
 endcase
 end
 end
endmodule