
class any_func_seq extends uvm_sequence#(my_transaction);
  `uvm_object_utils(any_func_seq)
  
  int num_repeat = 20;
  int max;
  
  //constructor 
  function new(string name =" ");
    super.new(name);
  endfunction
  
  task body;
    
    if(! uvm_config_db#(int)::exists(null,"","num_repeat"))
      `uvm_error("SEQ", "couldn't find num_repeat")
      
      
    uvm_config_db#(int)::get(null,"","num_repeat", num_repeat);
    uvm_config_db#(int)::get(null,"","max", max);
    
    repeat(num_repeat) begin
      req = my_transaction::type_id::create("req");
     start_item(req);
      
      if(! (req.randomize()))begin
        `uvm_error("MY_Sequence","randomize()failed")
      end
      
     finish_item(req);
     
    end
    
  endtask : body
  
  
  
endclass : any_func_seq