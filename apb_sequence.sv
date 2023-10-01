class apb_base_sequence extends uvm_sequence#(apb_packet);
`uvm_object_utils(apb_base_sequence)
apb_packet req;
function  new(string name="apb_base_sequence");
    super.new(name);
endfunction
task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body
  task post_body();
    
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : apb_base_sequence


class single_or_more_packet extends apb_base_sequence;
 `uvm_object_utils(single_or_more_packet)

rand int num_repeat;
int ok;
  constraint num_repeat_limit {num_repeat inside {[1:20]};}
  	function new(string name="single_or_more_packet");
    		super.new(name);   
 	endfunction
 	 virtual task body();
       `uvm_info(get_type_name(), $sformatf("Executing APB_RAND_SEQ %0d times...", num_repeat), UVM_LOW)
repeat(num_repeat)
begin
  /*req=apb_packet::type_id:: create("req");
     ok=req.randomize();
    	`uvm_info("SEQ", $sformatf("Generate new item: "), UVM_LOW)
    	req.print();
      
      	finish_item(req);*/
        `uvm_do(req)
end
	endtask
    endclass: single_or_more_packet
      
      