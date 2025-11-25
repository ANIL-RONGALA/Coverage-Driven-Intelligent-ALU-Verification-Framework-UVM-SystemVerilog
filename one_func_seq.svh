
class one_func_seq extends any_func_seq;
  `uvm_object_utils(one_func_seq)
  
  int num_repeat = 20;
  int max;
  
  //constructor 
  function new(string name ="one_func_seq");
    super.new(name);
  endfunction
  
  task body;
    
    my_transaction req_starter;
   op_e one_op;
    req_starter = my_transaction::type_id::create("req_starter");
    //req_starter.randomize() with {req_starter.op inside {2, 3, 4};};
    req_starter.randomize() with {req_starter.op inside {2};};
    one_op = req_starter.op;
    
    if(! uvm_config_db#(int)::exists(null,"","num_repeat"))
      `uvm_error("SEQ", "couldn't find num_repeat")
      
      
    uvm_config_db#(int)::get(null,"","num_repeat", num_repeat);
    uvm_config_db#(int)::get(null,"","max", max);
    
    repeat(num_repeat) begin
      req = my_transaction::type_id::create("req");
     start_item(req);
      
      if(! (req.randomize()with {req.op == one_op;}))begin
        `uvm_error("MY_Sequence","randomize()failed")
      end
      
     finish_item(req);
     
    end
    
  endtask : body
  
  
  
endclass : one_func_seq