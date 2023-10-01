class apb_master_driver extends uvm_driver #(apb_packet);
	apb_packet req;
	int num_sent;
	//virtual interface apb_if vif;
    virtual interface apb_if.master_driver driver_vif;
	`uvm_component_utils_begin(apb_master_driver)
    `uvm_field_int(num_sent,UVM_ALL_ON)
    `uvm_component_utils_end

//-----------constructor-------------
	function new (string name, uvm_component parent);		
	super.new(name, parent);
	endfunction

// ----------UVM connect_phase------------
		function void connect_phase(uvm_phase phase);
		if(!uvm_config_db#(virtual interface apb_if.master_driver)::get(this,"","master_driver_vif", driver_vif))
		 `uvm_error("NOVIF", "Missing virtual I/F" )
		endfunction:connect_phase

// ----------UVM run_phase------------
	task run_phase(uvm_phase phase);
    driver_vif.psel<=0;
    driver_vif.penable<=0;
        /// we get the packet
      @(posedge driver_vif.rst_n)
    `uvm_info(get_type_name(), "Detected Reset Done", UVM_LOW)
        forever   begin
            seq_item_port.get_next_item(req);
             `uvm_info(get_type_name(), {"Sending Packet :\n%s", req.sprint()}, UVM_LOW)
             void'(begin_tr(req, "Driver_APB_Packet"));
           // fork
            repeat(req.deley) begin
                @(posedge driver_vif.pclock);
            end
			// We check whether the request contains a write or read transaction
            case (req.pwrite)
                0:drive_read(req);
                1:drive_write(req);
            endcase
            
           req.error=driver_vif.error;
            num_sent++;
           
            // driver_vif.psel<=1;
            // driver_vif.penable<=0;
            // driver_vif.rst_n<=1;
        //    
           end_tr(req);
         seq_item_port.item_done();
        end
  	endtask : run_phase
//read_transaction
	task drive_read(input apb_packet req);
		driver_vif.paddr   <= req.paddr;
        driver_vif.pwrite  <= 0;
        driver_vif.psel    <= 1;
        @ (driver_vif.pclock);
        @ (driver_vif.pclock);
        driver_vif.penable <= 1;
        @ (driver_vif.pclock);
        req.prdata = driver_vif.prdata;
        driver_vif.psel    <= 0;
        driver_vif.penable <= 0;
	endtask: drive_read
//write transaction
    task drive_write(input apb_packet req);
       driver_vif.paddr=req.paddr;
        driver_vif.pwdata  <= req.pwdata;
        driver_vif.pwrite  <= 1;
        driver_vif.psel    <= 1;
        @ (driver_vif.pclock);
        @ (driver_vif.pclock);
        driver_vif.penable <= 1;
        @ (driver_vif.pclock);
        @ (driver_vif.pclock);
        driver_vif.psel    <= 0;
        driver_vif.penable <= 0;

    endtask
task reset_signals();
    forever begin
      @(negedge driver_vif.rst_n)
      
        // vif.Penable <= 0;
        driver_vif.pwrite <= 0;
        
    end
  endtask : reset_signals

    // UVM report_phase
    function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: APB driver sent %0d packets", num_sent), UVM_LOW)
  endfunction : report_phase
endclass:apb_master_driver
	
