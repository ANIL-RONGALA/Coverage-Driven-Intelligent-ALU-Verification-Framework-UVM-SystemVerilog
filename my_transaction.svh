
class my_transaction extends uvm_sequence_item;
  `uvm_object_utils(my_transaction)
 
  rand bit [31:0] in1;
  rand bit [31:0] in2;
  rand op_e op;
  bit [31:0] result;

 

  function new(string name = "my_transaction");
    super.new(name);
  endfunction

  // ---------- Constraints ----------
  // Keep shift amounts legal
  constraint c_shift_range {
    if (op inside {LSL, LSR}) in2 < 32;
  }

  // Avoid crazy multiplications that blow up coverage
  constraint c_mul_range {
    if (op == MUL) {
      in1[31:16] == 0;
      in2[31:16] == 0;
    }
  }

  // Bias randoms toward interesting values
  constraint c_bias {
    in1 dist {32'h00000000 := 3,
              32'hFFFFFFFF := 3,
              32'h7FFFFFFF := 2,
              32'h80000000 := 2,
              [1:255]      := 1};

    in2 dist {32'h00000000 := 3,
              32'hFFFFFFFF := 3,
              32'h7FFFFFFF := 2,
              32'h80000000 := 2,
              [1:31]       := 2,   // helps shifts
              [32:255]     := 1};
  }

  // ---------- Utilities ----------
  function string convert2string();
    return $sformatf("in1: %0h, in2: %0h, op: %0d, result: %0h",
                      in1, in2, op, result);
  endfunction
endclass
