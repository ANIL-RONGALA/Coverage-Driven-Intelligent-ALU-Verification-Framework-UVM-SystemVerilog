class my_predictor extends uvm_subscriber#(my_transaction);
  `uvm_component_utils(my_predictor)
  
  
  
  uvm_analysis_port#(my_transaction) predictor_ap;
  
  
 
  //constructor
  function new(string name, uvm_component parent); 
    super.new(name, parent); 
   endfunction
  
	function void build_phase(uvm_phase phase); 
      
      predictor_ap = new("predictor_ap", this);
      
    endfunction
  
  virtual function void write(my_transaction t);
    my_transaction pred_t;
    
    
    pred_t = alu_pred(t);
    
    predictor_ap.write(pred_t);
    
  endfunction
      
  extern function my_transaction alu_pred(my_transaction t);
   
  endclass : my_predictor