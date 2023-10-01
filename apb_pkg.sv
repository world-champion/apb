package apb_pkg;
	import uvm_pkg :: * ;
	`include "uvm_macros.svh"
	//typedef uvm_config_db#(virtual interface apb_if) apb_vif_config;
typedef  uvm_config_db#(virtual interface apb_if) apb_vif_config;

	`include "apb_packet.sv"
	`include "apb_master_monitor.sv"
	`include "apb_master_sequencer.sv"
	`include "apb_sequence.sv"
	`include "apb_master_driver.sv"
	`include "apb_agent.sv"
	`include "apb_env.sv"
endpackage
