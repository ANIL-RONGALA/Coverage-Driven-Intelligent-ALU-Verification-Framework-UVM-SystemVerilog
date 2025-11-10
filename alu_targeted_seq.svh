class alu_targeted_seq extends uvm_sequence#(my_transaction);
  `uvm_object_utils(alu_targeted_seq)

  function new(string name = "alu_targeted_seq");
    super.new(name);
  endfunction

  task body();
    my_transaction tr;

    // 1. Edge case: Most positive vs. most negative
    tr = my_transaction::type_id::create("tr", , get_full_name());
    tr.in1 = 32'h7FFFFFFF;  // max positive
    tr.in2 = 32'h80000000; // most negative
    tr.op = ADD;
    start_item(tr);
    finish_item(tr);

    // 2. Subtract with underflow
    tr = my_transaction::type_id::create("tr", , get_full_name());
    tr.in1 = 32'h00000000; // 0
    tr.in2 = 32'h00000001; // 1
    tr.op = SUB;
    start_item(tr);
    finish_item(tr);

    // 3. Shift left by 0 (boundary condition)
    tr = my_transaction::type_id::create("tr", , get_full_name());
    tr.in1 = 32'hF0F0F0F0;
    tr.in2 = 32'h00000000; // shift amount = 0
    tr.op = LSL;
    start_item(tr);
    finish_item(tr);

    // 4. Shift right by max (31)
    tr = my_transaction::type_id::create("tr", , get_full_name());
    tr.in1 = 32'hF0F0F0F0;
    tr.in2 = 32'd31; // max legal shift
    tr.op = LSR;
    start_item(tr);
    finish_item(tr);

    // 5. Multiplication with overflow
    tr = my_transaction::type_id::create("tr", , get_full_name());
    tr.in1 = 32'hFFFF_FFFF;
    tr.in2 = 32'h0000_0002;
    tr.op = MUL;
    start_item(tr);
    finish_item(tr);

    // 6. Comparison (S_LT) with equal numbers
    tr = my_transaction::type_id::create("tr", , get_full_name());
    tr.in1 = 32'h12345678;
    tr.in2 = 32'h12345678;
    tr.op = S_LT;
    start_item(tr);
    finish_item(tr);

    // 7. XOR edge case (all 1s and all 0s)
    tr = my_transaction::type_id::create("tr", , get_full_name());
    tr.in1 = 32'hFFFF_FFFF;
    tr.in2 = 32'h00000000;
    tr.op = B_XOR;
    start_item(tr);
    finish_item(tr);

  endtask

endclass
