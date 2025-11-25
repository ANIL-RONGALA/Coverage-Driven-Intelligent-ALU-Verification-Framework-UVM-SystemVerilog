
class uvm_do_seq extends uvm_sequence#(my_transaction);
  `uvm_object_utils(uvm_do_seq)
  
  one_func_seq one_func;
  
  //constructor 
  function new(string name =" ");
    super.new(name);
  endfunction
  
  task body;
    
    `uvm_do(req);
    `uvm_do(req);
    `uvm_do(one_func);
    `uvm_do_with(req,{req.op == 7;});
    `uvm_do_with(req, {req.op == 5;});
    
    
    
   
    
  endtask : body
  
  
  
endclass : uvm_do_seq