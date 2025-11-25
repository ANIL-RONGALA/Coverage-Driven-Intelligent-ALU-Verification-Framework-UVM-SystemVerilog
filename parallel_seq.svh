
class parallel_seq extends uvm_sequence#(my_transaction);
  `uvm_object_utils(parallel_seq)
  
  one_func_seq one_func;
  any_func_seq any_func;
  
  //constructor 
  function new(string name =" ");
    super.new(name);
  endfunction
  
 virtual task body;
    
    fork
    `uvm_do(one_func);
    `uvm_do(any_func);  
    join
    
  endtask : body
  
  
  
endclass : parallel_seq