class alu_edge_seq extends uvm_sequence #(my_transaction);
  `uvm_object_utils(alu_edge_seq)

  function new(string name = "alu_edge_seq");
    super.new(name);
  endfunction

  task body();
    my_transaction tr;

    // Case 1: ADD overflow
    tr = my_transaction::type_id::create("tr_add", , get_full_name());
    tr.constraint_mode(0); // disable random constraints
    tr.op  = ADD;
    tr.in1 = 32'h7FFFFFFF;
    tr.in2 = 32'h00000001;
    start_item(tr);
    finish_item(tr);

    // Case 2: SUB underflow
    tr = my_transaction::type_id::create("tr_sub", , get_full_name());
    tr.constraint_mode(0);
    tr.op  = SUB;
    tr.in1 = 32'h00000000;
    tr.in2 = 32'h00000001;
    start_item(tr);
    finish_item(tr);

    // Case 3: Left shift by max amount
    tr = my_transaction::type_id::create("tr_lsl", , get_full_name());
    tr.constraint_mode(0);
    tr.op  = LSL;
    tr.in1 = 32'h00000001;
    tr.in2 = 31;
    start_item(tr);
    finish_item(tr);

    // Case 4: Right shift of negative
    tr = my_transaction::type_id::create("tr_lsr", , get_full_name());
    tr.constraint_mode(0);
    tr.op  = LSR;
    tr.in1 = 32'h80000000;
    tr.in2 = 31;
    start_item(tr);
    finish_item(tr);

    // Case 5: Multiply large numbers
    tr = my_transaction::type_id::create("tr_mul", , get_full_name());
    tr.constraint_mode(0);
    tr.op  = MUL;
    tr.in1 = 32'h0000FFFF;
    tr.in2 = 32'h0000FFFF;
    start_item(tr);
    finish_item(tr);

    // Case 6: AND zero with all ones
    tr = my_transaction::type_id::create("tr_and", , get_full_name());
    tr.constraint_mode(0);
    tr.op  = B_AND;
    tr.in1 = 32'h00000000;
    tr.in2 = 32'hFFFFFFFF;
    start_item(tr);
    finish_item(tr);

    // Case 7: XOR all ones
    tr = my_transaction::type_id::create("tr_xor", , get_full_name());
    tr.constraint_mode(0);
    tr.op  = B_XOR;
    tr.in1 = 32'hFFFFFFFF;
    tr.in2 = 32'hFFFFFFFF;
    start_item(tr);
    finish_item(tr);

    // Case 8: SLT equal numbers
    tr = my_transaction::type_id::create("tr_slt", , get_full_name());
    tr.constraint_mode(0);
    tr.op  = S_LT;
    tr.in1 = 32'h12345678;
    tr.in2 = 32'h12345678;
    start_item(tr);
    finish_item(tr);
    
    // Case 9: AND with in1 = max_pos, in2 = most_neg
	tr = my_transaction::type_id::create("tr_and_cross", , get_full_name());
	tr.constraint_mode(0);
	tr.op  = B_AND;
	tr.in1 = 32'h7FFFFFFF;
	tr.in2 = 32'h80000000;
	start_item(tr); finish_item(tr);

	// Case 10: SUB with in1 = most_neg, in2 = max_pos
	tr = my_transaction::type_id::create("tr_sub_cross", , get_full_name());
	tr.constraint_mode(0);
	tr.op  = SUB;
	tr.in1 = 32'h80000000;
	tr.in2 = 32'h7FFFFFFF;
	start_item(tr); finish_item(tr);

	// Case 11: MUL with in1 = 0, in2 = max_pos
	tr = my_transaction::type_id::create("tr_mul_cross", , get_full_name());
	tr.constraint_mode(0);
	tr.op  = MUL;
	tr.in1 = 32'h00000000;
	tr.in2 = 32'h7FFFFFFF;
	start_item(tr); finish_item(tr);

	// Case 12: SLT with in1 = max_pos, in2 = most_neg
	tr = my_transaction::type_id::create("tr_slt_cross", , get_full_name());
	tr.constraint_mode(0);
	tr.op  = S_LT;
	tr.in1 = 32'h7FFFFFFF;
	tr.in2 = 32'h80000000;
	start_item(tr); finish_item(tr);

  endtask
endclass
