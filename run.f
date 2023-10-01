/*-----------------------------------------------------------------
File name     : run.f
Description   : lab01_data simulator run template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
              : Set $UVMHOME to install directory of UVM library
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/
// 64 bit option for AWS labs
-64

 -uvmhome $UVMHOME

// include directories
//*** add incdir include directories here

// compile files
//*** add compile files here

-incdir ../sv
clkgen.sv
../sv/apb_pkg.sv
../sv/apb_if.sv

../dut/apb_slave.sv
tb_top.sv
hw_top.sv
-timescale 1ns/1ns
+UVM_TESTNAME=simple_test
+UVM_VERBOSITY=UVM_LOW
+SVSEED=random
