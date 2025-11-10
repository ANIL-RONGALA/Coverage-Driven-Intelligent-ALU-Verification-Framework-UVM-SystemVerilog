
class many_func_virtual_seq extends uvm_sequence;
  `uvm_object_utils(many_func_virtual_seq)
  
  one_func_seq one_func;
  any_func_seq any_func;
  same_op_seq same_op;
  
  my_sequencer seqr1;
  my_sequencer seqr2;
  my_sequencer seqr3;
  
  
  //constructor 
  function new(string name =" ");
    super.new(name);
  endfunction
  
 virtual task body;
   one_func = one_func_seq::type_id::create("one_func");
   any_func = any_func_seq::type_id::create("any_func");
   same_op = same_op_seq::type_id::create("same_op");
    
    fork
      one_func.start(seqr1, .this_priority(100));
      any_func.start(seqr2, .this_priority(100));
      same_op.start(seqr3, .this_priority(500));
    join
    
  endtask : body
  
  
  
endclass : many_func_virtual_seq