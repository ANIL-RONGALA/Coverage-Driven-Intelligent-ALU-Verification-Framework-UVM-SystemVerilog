class my_comparator extends uvm_component;
  `uvm_component_utils(my_comparator)
  
  
  
  uvm_analysis_export#(my_transaction) ingress_analysis_export;
  uvm_analysis_export#(my_transaction) pred_analysis_export;
  
  uvm_tlm_analysis_fifo#(my_transaction) ingress_fifo;
  uvm_tlm_analysis_fifo#(my_transaction) pred_fifo;
  
  
  
 
  //constructor
  function new(string name, uvm_component parent); 
    super.new(name, parent); 
   endfunction
  
	function void build_phase(uvm_phase phase); 
      super.build_phase(phase);
      ingress_analysis_export = new("ingress_analysis_export", this);
      pred_analysis_export = new("pred_analysis_export", this);
      ingress_fifo = new("ingress_fifo", this);
      pred_fifo = new("pred_fifo", this);
      
    endfunction
  
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ingress_analysis_export.connect(ingress_fifo.analysis_export);
     pred_analysis_export.connect(pred_fifo.analysis_export);
    
  endfunction
  
  task run_phase(uvm_phase phase);
    my_transaction ingress_t, pred_t;
    
    forever begin
      pred_fifo.get(pred_t);
      ingress_fifo.get(ingress_t);
      
      `uvm_info("INGRESS", $sformatf("Transaction created by monitor: in1: %h, in2: %h, op: %h, result: %h",ingress_t.in1, ingress_t.in2, ingress_t.op, ingress_t.result ), UVM_MEDIUM)
      
      `uvm_info("PREDICTOR", $sformatf("Transaction created by PREDICTOR: in1: %h, in2: %h, op: %h, result: %h",pred_t.in1, pred_t.in2, pred_t.op, pred_t.result ), UVM_MEDIUM)
      
      if(pred_t.result == ingress_t.result)begin
        `uvm_info("SCOREBOARD","Matched result\n", UVM_LOW)
      end
      else
        `uvm_error("SCOREBOARD","ERROR - MISMATCHED RESULT!!!")
        
      
      end
    
  endtask
 
  endclass : my_comparator