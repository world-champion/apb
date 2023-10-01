class top extends uvm_env;
  apb_env apb;
  `uvm_component_utils(top)
  function new (string name, uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //`uvm_info(get_type_name(), "Build phase of the testbench is being executed", UVM_HIGH)

    apb = apb_env::type_id::create("apb", this);
    //`uvm_info(get_type_name(), "build phase execution", UVM_HIGH)

  endfunction : build_phase

endclass : top

  