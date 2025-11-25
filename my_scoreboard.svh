class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)
 
  uvm_analysis_export#(my_transaction) sb_analysis_export;
  my_predictor predictor;
  my_comparator comparator;
  
 
  //constructor
  function new(string name, uvm_component parent); 
    super.new(name, parent); 
    endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    predictor = my_predictor::type_id::create("predictor",this);
    comparator = my_comparator::type_id::create("comparator",this);
   
    sb_analysis_export = new("sb_analysis_export", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    sb_analysis_export.connect(predictor.analysis_export);
    sb_analysis_export.connect(comparator.ingress_analysis_export);
    predictor.predictor_ap.connect(comparator.pred_analysis_export);
    
  endfunction
  
      
   
  endclass : my_scoreboard