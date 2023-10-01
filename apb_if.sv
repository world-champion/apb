interface apb_if (input pclock, input rst_n);
	timeunit 1ns;
	timeprecision 100ps;
	import uvm_pkg:: * ;
	`include "uvm_macros.svh"
	
	import apb_pkg:: * ;

	//Signals
	logic [31:0] paddr;// The address from which the master wants to read or write
	logic psel;// The requestor turns on PSELx when it has finished creating a packet and that a data transfer is required
	logic penable;//PENABLE indicates starting from the second clock rotation of the APB transfer
	logic pwrite; // APB write access when HIGH and an APB read access when LOW
	logic [31:0] pwdata;//The data will be entered from here if the transaction is a write
	logic pready;//is used to extend an APB transfer by the slave
	logic [31:0] prdata;//The data will be entered here if the transaction is a read
  //bit monstart, drvstart;
  logic error;
bit monstart, drvstart;
 //master driver


 modport master_driver(input  pclock, rst_n,pready, prdata, error, output paddr,pwrite,pwdata, psel, penable);
 //slave driver
  modport slave_driver(input  pclock, rst_n,pwrite, pwdata, psel, output pready, prdata, error);
//monitor
 modport master_monitor(input pclock , rst_n, paddr, psel, penable, pwrite, pwdata, pready ,prdata);
 
 
 
 
 
 endinterface: apb_if



	

