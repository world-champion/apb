class base_test extends uvm_test;
   `uvm_component_utils(base_test)
   top env;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);  
    super.build_phase(phase);
    env=top::type_id::create("env", this);
     `uvm_info(get_type_name(), "Build phase of the test is being executed", UVM_HIGH)
		uvm_config_int::set( this, "*", "recording_detail", 1); 
                   
    endfunction
function void end_of_elaboration_phase(uvm_phase phase);
		`uvm_info("Packet:\n%s", "end_of_elaboration_phase",UVM_DEBUG)
		uvm_top.print_topology();
	endfunction
    function void check_phase(uvm_phase phase);
        check_config_usage();
    endfunction

    task run_phase(uvm_phase phase);
        uvm_objection obj = phase.get_objection();
        obj.set_drain_time(this, 200ns);
    endtask
    
endclass:base_test

class simple_test extends base_test;
    `uvm_component_utils(simple_test)
    function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction
    virtual function void build_phase(uvm_phase phase);

     uvm_config_wrapper::set(this, "env.apb.agent.sequencer.run_phase",
                           "default_sequence",
                            single_or_more_packet::get_type());
        super.build_phase(phase);    
    endfunction
endclass


