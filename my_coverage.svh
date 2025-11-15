class my_coverage extends uvm_subscriber#(my_transaction);
  `uvm_component_utils(my_coverage)
  
my_transaction transaction;
  real cov;
  

  
 covergroup alu_cg;
  option.per_instance = 1;
  option.auto_bin_max = 16; // allow fine-grain bins

  // Operand 1
  in1_value: coverpoint transaction.in1 {
    bins zero  = {32'h00000000};
    bins max_pos  = {32'h7FFFFFFF};
    bins most_neg = {32'h80000000};
    bins smal = {[1:15]};
  }

  // Operand 2
  in2_value: coverpoint transaction.in2 {
    bins zero = {32'h00000000};
    bins max_pos = {32'h7FFFFFFF};
    bins most_neg = {32'h80000000};
    bins smal = {[1:15]};
  }

  // Operation code
  op_code: coverpoint transaction.op {
    bins bin_AND = {B_AND};
    bins bin_OR = {B_OR};
    bins bin_ADD = {ADD};
    bins bin_SUB = {SUB};
    bins bin_LT = {S_LT};
    bins bin_LSL = {LSL};
    bins bin_LSR = {LSR};
    bins bin_MUL = {MUL};
    bins bin_XOR = {B_XOR};
  }

  // Cross coverage: operations × corner operand values
  cross_op_in1: cross op_code, in1_value;
  cross_op_in2: cross op_code, in2_value;

  // Special condition coverpoints
  shift_amount: coverpoint transaction.in2 iff (transaction.op inside {LSL, LSR}) {
    bins shift0 = {0};
    bins shift1 = {1};
    bins shift31 = {31};
    bins larg = {[16:31]};
  }

  mul_behavior: coverpoint transaction.op iff (transaction.op == MUL) {
    bins mul_bin = {MUL};
  }

endgroup
    
  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    alu_cg = new();
    endfunction
  
  virtual function void write(my_transaction t);
    transaction = t;
    alu_cg.sample();
    
  endfunction
  
  function void extract_phase(uvm_phase phase);
    cov = alu_cg.get_coverage();
	
  endfunction
  
  function void report_phase(uvm_phase phase);
    
    `uvm_info(get_full_name(),$sformatf("Coverage is %d%%", cov), UVM_NONE)
  endfunction
    
  endclass: my_coverage