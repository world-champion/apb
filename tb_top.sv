module tb_top;
import uvm_pkg:: *;
`include "uvm_macros.svh"
import apb_pkg :: * ;
`include "top.sv"
`include "test_lib.sv"
initial
begin
    
 // apb_vif_config::set(null, "*.env.apb.*",  "vif",  hw_top.apb); 
  //apb_vif_config::set(null, "*.env.apb.*",  "master_driver_vif",  hw_top.apb); 
    uvm_config_db#(virtual interface apb_if.master_driver)::set( null,"*.env.apb.*",  "master_driver_vif",hw_top.apb); 
    uvm_config_db#(virtual interface apb_if.master_monitor)::set( null,"uvm_test_top.env.apb.*",  "master_monitor_vif",hw_top.apb);
     run_test("simple_test");

 end
endmodule 