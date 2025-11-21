package my_testbench_pkg;
   import uvm_pkg::*;

		typedef enum logic[3:0] {B_AND = 0, B_OR = 1, ADD = 2, SUB = 4, S_LT = 8, LSL = 3, LSR = 5, MUL = 6, B_XOR = 7} op_e;
  
   
    `include "my_transaction.svh"
	//`include "my_sequence.svh"
	`include "my_sequencer.svh"
	`include "same_op_seq.svh"
	`include "any_func_seq.svh"
	`include "one_func_seq.svh"
	`include "uvm_do_seq.svh"
	`include "parallel_seq.svh"
	`include "many_func_virtual_seq.svh"
	`include "alu_edge_seq.svh"
	`include "alu_targeted_seq.svh"
	`include "alu_cross_seq.svh"
	
	`include "my_driver.svh"
	`include "my_monitor.svh"
	`include "my_agent.svh"
	`include "my_coverage.svh"
	`include "my_predictor.svh"
	`include "alu_pred.svh"
	`include "my_comparator.svh"
	`include "my_scoreboard.svh"
	`include "my_env.svh"
	`include "my_test.svh"

endpackage : my_testbench_pkg                                            