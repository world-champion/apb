module hw_top;

  // Clock and reset signals
  logic         clock;
  logic         reset;

  apb_if apb(clock, reset);
  apb_slave dut(
   .pclk(apb.pclock),
        .rst_n(apb.rst_n),

        .paddr(apb.paddr),
        .psel(apb.psel),
        .penable(apb.penable),
        .pwrite(apb.pwrite),
        .pwdata(apb.pwdata),
        .pready(apb.pready),
        .prdata(apb.prdata)
  );
    clkgen clkgen (
    .clock(clock),
    .run_clock(1'b1),
    .clock_period(32'd10)
  );
    initial begin
    reset = 1'b0;
    @(negedge clock)
    #1 reset <= 1'b1;

  end

  endmodule