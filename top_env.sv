class top_env extends uvm_env;

    `uvm_component_utils(top_env)
    //UVC's
    apb_env apb;
     
    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        //APB UVC
        apb=apb_env::type_id::create("apb",this);
       
        `uvm_info(get_type_name(), "build phase execution in router_tb", UVM_HIGH)
    endfunction:build_phase



endclass:top_env