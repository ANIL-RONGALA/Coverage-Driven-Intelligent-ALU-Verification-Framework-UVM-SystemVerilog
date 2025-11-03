class alu_cross_seq extends uvm_sequence #(my_transaction);
  `uvm_object_utils(alu_cross_seq)

  function new(string name = "alu_cross_seq");
    super.new(name);
  endfunction

  task body();
    my_transaction tr;

    // Define the edge values to test
    bit [31:0] edge_vals[] = '{32'h00000000, 32'h7FFFFFFF, 32'h80000000};

    // Loop over edge values and operations
    foreach (edge_vals[i]) begin
      foreach (edge_vals[j]) begin
        for (int op_val = 0; op_val <= 8; op_val++) begin
          tr = my_transaction::type_id::create(
                 $sformatf("tr_op%0d_in1%0d_in2%0d", op_val, i, j),
                 , get_full_name());
          tr.constraint_mode(0);

          // Cast integer loop var to your enum
          tr.op = op_e'(op_val);

          // Force edge values
          tr.in1 = edge_vals[i];
          tr.in2 = edge_vals[j];

          start_item(tr);
          finish_item(tr);
        end
      end
    end
  endtask
endclass
