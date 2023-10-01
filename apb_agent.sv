class apb_agent extends uvm_agent;

	apb_master_driver driver;
	apb_master_sequencer sequencer;
	apb_master_monitor monitor;
	`uvm_component_utils_begin(apb_agent)
	`uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
	`uvm_component_utils_end
	function new (string name, uvm_component parent);
 		 super.new(name, parent);
    `uvm_info(get_type_name(), "4", UVM_HIGH)

 	endfunction
	//build phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		monitor= apb_master_monitor::type_id::create ("monitor", this);
		if(is_active==UVM_ACTIVE)
		begin
			sequencer=apb_master_sequencer::type_id::create  ("sequencer", this);

			driver=apb_master_driver::type_id::create  ("driver", this);
			end
	endfunction
	virtual function void connect_phase(uvm_phase phase);
		if(is_active==UVM_ACTIVE)
		begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
		end
	endfunction
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info(get_type_name(),{"start of simulation for ",get_full_name()},UVM_HIGH)
endfunction:start_of_simulation_phase

endclass:apb_agent