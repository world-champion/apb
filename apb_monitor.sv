
class apb_monitor extends uvm_monitor;
`uvm_component_utils(apb_monitor)

 uvm_analysis_port#(apb_item) apb_out;
virtual interface apb_interface.master_mod vif;

function new (string name, uvm_component parent);
super.new(name, parent);
apb_out = new("apb_out",this);
endfunction



apb_item item;
int num_item_col;

 task run_phase(uvm_phase phase);
    // Look for items after reset

    @(negedge vif.rstn);
    `uvm_info(get_type_name(), "Detected Not Reset Done", UVM_MEDIUM)
      item = apb_item::type_id::create("item", this);

    forever begin
      // concurrent blocks for items collection and transaction recording   
      //  while (vif.psel !== 1'b1 || vif.penable !== 1'b0);
     // `uvm_info(get_type_name(), "psel and penable are det on.", UVM_MEDIUM)
void'(begin_tr(item, "APB_MONITOR_Transaction"));
       while(vif.pready != 1) begin
        @(posedge vif.clock);
       end
      @(posedge vif.clock &&vif.psel && vif.penable);
      @ (posedge vif.clock);
      @ (posedge vif.clock);
      @ (posedge vif.clock);
      @ (posedge vif.clock);


   //   @(posedge  vif.penable);
        `uvm_info(get_type_name(), "Start collecting Packet...", UVM_MEDIUM)
        item.addr<=vif.paddr;

       case (vif.RNW)
        0:begin
            item.rdata<=vif.prdata;
            item.wdata<='z;
        end
        1:begin
            item.rdata<='z;
            item.wdata <=vif.pwdata;
        end
       endcase
        item.read_n_write<=vif.RNW; 
    end_tr(item);
        num_item_col++;
        `uvm_info(get_type_name(), $sformatf("Packet Collected : %s", item.sprint()), UVM_LOW)

       
        // item.wdata<=vif.RNW==1?vif.pwdata:'z;
        // `uvm_info(get_type_name(), "Item was created", UVM_MEDIUM)

        // item.read_n_write<=vif.RNW; 
        // item.rdata<=vif.RNW==0?vif.prdata:'z;
  //    `uvm_info(get_type_name(), $sformatf("Item vif.RNW : %d", vif.RNW), UVM_LOW)

    //  num_item_col++;
    end
  endtask : run_phase

  // UVM report_phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: APB Monitor Collected %0d ITEMS", num_item_col), UVM_LOW)
  endfunction : report_phase

      function void connect_phase( uvm_phase phase);
            if (!apb_vif_config::get(this,"","master_vif", vif))
                `uvm_error("NOVIF","vif not set")
      endfunction : connect_phase



endclass