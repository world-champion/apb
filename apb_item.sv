
class apb_item extends uvm_sequence_item;
// `uvm_object_utils(apb_item)
 
//request
 rand logic [31:0] addr;
 rand logic [31:0] wdata;
 rand bit read_n_write;
 rand int delay;
 
//response
 bit error;
 logic [31:0] rdata;
 
 function new (string name="apb_item");
  super.new(name);
 endfunction

 `uvm_object_utils_begin(apb_item)
    `uvm_field_int(addr,UVM_ALL_ON)   
    `uvm_field_int(wdata,UVM_ALL_ON) 
    `uvm_field_int(read_n_write,UVM_ALL_ON + UVM_BIN) 
    `uvm_field_int(delay,UVM_ALL_ON +UVM_NOCOMPARE)  
    `uvm_field_int(rdata,UVM_ALL_ON)  
    `uvm_field_int(error,UVM_ALL_ON) 
  `uvm_object_utils_end
 
 
 //constraints
 constraint addr_limit {addr<256;}
 constraint del_bet_pac {delay inside {[1:20]};}
 constraint read_n_write_freq{read_n_write dist {0:=50,1:=50};}



endclass