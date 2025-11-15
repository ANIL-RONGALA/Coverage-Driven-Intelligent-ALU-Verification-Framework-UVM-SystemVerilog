class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  //declare a aobject of my_agent class
  
  my_agent agent; //No memory is allocated to the object when is handler is created  
  my_coverage coverage;
  my_scoreboard scoreboard;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    agent = my_agent::type_id::create("agent",this);
    coverage = my_coverage::type_id::create("coverage",this);
    scoreboard = my_scoreboard::type_id::create("scoreboard", this);
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor_ap.connect(coverage.analysis_export);
    agent.monitor_ap.connect(scoreboard.sb_analysis_export);
    
  endfunction
  
  
endclass : my_env