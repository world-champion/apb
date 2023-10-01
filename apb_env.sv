class apb_env extends uvm_env;

    apb_agent agent;

	`uvm_component_utils(apb_env)
	function new (string name, uvm_component parent);
		super.new(name, parent);
    `uvm_info(get_type_name(),{"2"},UVM_HIGH); 

	endfunction

    virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent=apb_agent::type_id:: create ("agent", this);
	endfunction

    function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),{"start of simulation for ",get_full_name()},UVM_HIGH); 
    endfunction

endclass:apb_env