
  function my_transaction my_predictor::alu_pred(my_transaction t);
  my_transaction pred_t;

  pred_t = my_transaction::type_id::create("pred_t");
  pred_t.in1 = t.in1;
  pred_t.in2 = t.in2;
  pred_t.op  = t.op;

  case (t.op)
    B_AND: pred_t.result = t.in1 & t.in2;
    B_OR : pred_t.result = t.in1 | t.in2;
    ADD  : pred_t.result = (t.in1 + t.in2) & 32'hFFFFFFFF; // truncate to 32 bits
    SUB  : pred_t.result = (t.in1 - t.in2) & 32'hFFFFFFFF; // truncate to 32 bits
    S_LT : pred_t.result = (t.in1 < t.in2) ? 32'h1 : 32'h0;

    // Only use lower 5 bits for shift amount (0–31)
    LSL  : pred_t.result = t.in1 << t.in2[4:0];
    LSR  : pred_t.result = t.in1 >> t.in2[4:0];

    // Multiplication truncated to 32 bits
    MUL  : pred_t.result = (t.in1 * t.in2) & 32'hFFFFFFFF;

    B_XOR: pred_t.result = t.in1 ^ t.in2;
  endcase

  return(pred_t);
endfunction