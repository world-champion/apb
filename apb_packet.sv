class apb_packet extends uvm_sequence_item;

function new(string name="apb_packet");
	super.new(name);

endfunction
	//here we will write every data to packet
	rand bit [31:0] paddr;
	rand bit [31:0] pwdata;
	rand bit pwrite;
	logic [31:0] prdata;
	rand int deley;
	bit error;
`uvm_object_utils_begin(apb_packet)
	`uvm_field_int ( paddr, UVM_ALL_ON)
	`uvm_field_int ( pwdata, UVM_ALL_ON)
	`uvm_field_int ( pwrite, UVM_ALL_ON)
	`uvm_field_int ( deley, UVM_ALL_ON)
`uvm_object_utils_end
    constraint valid_addr { paddr<31'b11111111; }
    constraint medium_pkt_delay{deley >=1;deley<=20;}

endclass:apb_packet
