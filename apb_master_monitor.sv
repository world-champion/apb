class apb_master_monitor extends uvm_monitor;
//We interface to the interface apb
   // virtual interface apb_if vif;
    virtual interface apb_if.master_monitor monitor_vif;
// Collected Data handle
    apb_packet pkt;
// Count packets collected
    int num_pkt_col;
  `uvm_component_utils_begin(apb_master_monitor)
  `uvm_field_int(num_pkt_col, UVM_ALL_ON)
  `uvm_component_utils_end
//------constructor--------
    function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction
//----------UVM CONNECT_PHASE()-------
    function void connect_phase(uvm_phase phase);
      	if (!uvm_config_db#(virtual interface apb_if.master_monitor)::get(this,"","master_monitor_vif", monitor_vif))
		        `uvm_error("NOVIF","vif not set")
    endfunction: connect_phase

// -------UVM run() phase----------
    task run_phase(uvm_phase phase);
    // Look for packets after reset
    @(posedge monitor_vif.rst_n)
    `uvm_info(get_type_name(), "Detected Reset Done", UVM_LOW)
      pkt = apb_packet::type_id::create("pkt", this);
forever 
begin
  // @(posedge monitor_vif.pready)void'(begin_tr(pkt, "Monitor_APB_Packet"));      // Create collected packet instance

    @(posedge monitor_vif.penable && monitor_vif.psel);

         `uvm_info(get_type_name(), "Start collecting Packet...", UVM_LOW)
         case(monitor_vif.pwrite)
         0: begin
              pkt.paddr=monitor_vif.paddr;
              pkt.pwdata='z;
              pkt.prdata=monitor_vif.prdata;
         end
         1: begin
              pkt.paddr=monitor_vif.paddr;
              pkt.pwdata=monitor_vif.pwdata;
              pkt.prdata='z;
         end
         endcase
       //end_tr(pkt); 
      num_pkt_col++;
      `uvm_info(get_type_name(), {"Packet Collected :\n%s", pkt.sprint()}, UVM_LOW)
end
  endtask : run_phase
  function void report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Report: APB Monitor Collected %0d Packets",num_pkt_col ), UVM_LOW)
  endfunction : report_phase
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),{"start of simulation for ",get_full_name()},UVM_HIGH); 
endfunction	

endclass: apb_master_monitor