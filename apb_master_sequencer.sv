class apb_master_sequencer extends uvm_sequencer #(apb_packet);
`uvm_component_utils(apb_master_sequencer)
function new (string name, uvm_component parent);
		super.new(name, parent);
    `uvm_info(get_type_name(), "6", UVM_HIGH)

	endfunction
	
function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),{"start of simulation for ",get_full_name()},UVM_HIGH); 
endfunction
endclass:apb_master_sequencer