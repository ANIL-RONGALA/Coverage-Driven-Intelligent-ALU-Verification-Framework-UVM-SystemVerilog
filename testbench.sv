module alu_assertions (dut_if.MONITORPORT vif);

  property p_reset_clear;
    @(posedge vif.clock)
      vif.reset |-> (vif.result == 32'h0);
  endproperty
  a_reset_clear: assert property(p_reset_clear);

  property p_add_zero;
    @(posedge vif.clock)
      (!vif.reset && vif.cmd == 4'b0000 && vif.in2 == 32'h0)
        |-> (vif.result == vif.in1);
  endproperty
  a_add_zero: assert property(p_add_zero);

  property p_opcode_range;
    @(posedge vif.clock)
      (!vif.reset) |-> (vif.cmd inside {[0:8]});
  endproperty
  a_opcode_range: assert property(p_opcode_range);

  property p_no_xz_result;
    @(posedge vif.clock)
      !$isunknown(vif.result);
  endproperty
  a_no_xz_result: assert property(p_no_xz_result);

  property p_reset_stable;
    @(posedge vif.clock)
      vif.reset |=> $stable(vif.result);
  endproperty
  a_reset_stable: assert property(p_reset_stable);

  property p_no_xz_cmd;
    @(posedge vif.clock)
      !$isunknown(vif.cmd);
  endproperty
  a_no_xz_cmd: assert property(p_no_xz_cmd);

endmodule




 // Test Bench

`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"


//Top Module


module top;
  import uvm_pkg::*;
  import my_testbench_pkg::*;

  bit clock;
  my_test test;

  // Interface instance
  dut_if dut_if1(clock);

  // DUT instance
  dut dut1(
    .clock(dut_if1.clock),
    .reset(dut_if1.reset),
    .in1(dut_if1.in1),
    .in2(dut_if1.in2),
    .cmd(dut_if1.cmd),
    .result(dut_if1.result)
  );

  // INSTANTIATE ASSERTIONS CORRECTLY
  alu_assertions alu_sva (.vif(dut_if1));

  // CLOCK GENERATION
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  // UVM CONFIG + RUN TEST
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);

    uvm_config_db#(virtual dut_if.TESTPORT)::set(null,"*","dut_vif", dut_if1);
    uvm_config_db#(virtual dut_if.MONITORPORT)::set(null,"*","dut_vif_m", dut_if1);

    uvm_config_db#(int)::set(null,"*","num_repeat", 80);
    uvm_config_db#(int)::set(null,"*","max", 15);

    test = my_test::type_id::create("test", null);
    run_test();
  end

  initial begin
    `uvm_info("TESTTOP", "My UVM testbench!", UVM_NONE);
  end

endmodule
