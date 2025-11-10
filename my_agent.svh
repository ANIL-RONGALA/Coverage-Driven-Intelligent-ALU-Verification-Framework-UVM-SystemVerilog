class my_agent extends uvm_agent;
  `uvm_component_utils(my_agent)
  
  //creating handelers for the instances
  
 
  
  my_driver driver;
  my_sequencer sequencer;
  my_monitor monitor;
  uvm_analysis_port#(my_transaction) monitor_ap;
  
  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    endfunction
  
 //build_phase
  function void build_phase(uvm_phase phase);
    driver= my_driver::type_id::create("driver", this);
	sequencer = my_sequencer::type_id::create("sequencer", this);
    monitor = my_monitor::type_id::create("monitor", this);
    monitor_ap = new("monior_ap", this);
    
     endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
       driver.seq_item_port.connect(sequencer.seq_item_export);
    monitor.monitor_ap.connect(monitor_ap);
    
      endfunction
    
  endclass: my_agent