class my_test extends uvm_test;
  `uvm_component_utils(my_test)
  
  my_env env;
  //my_sequence seq;
  //same_op_seq seq;
  any_func_seq seq;
  alu_edge_seq edge_seq;
  any_func_seq rand_seq;
  alu_targeted_seq targ_seq;
  alu_cross_seq cross_seq;
  //one_func_seq seq;
  //uvm_do_seq seq;
  //parallel_seq seq;
  //many_func_virtual_seq vseq;
  
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
    
  function void build_phase(uvm_phase phase);
   env = my_env::type_id::create("env", this);
   // any_func_seq::type_id::set_type_override(one_func_seq::get_type());
  endfunction
  
  //run phase 
  task run_phase(uvm_phase phase);
     
    phase.raise_objection(this);
    
    seq = any_func_seq::type_id::create("any_func_seq");
    
    // Run edge cases
  edge_seq = alu_edge_seq::type_id::create("edge_seq");
  edge_seq.start(env.agent.sequencer);

  // Run random cases
  rand_seq = any_func_seq::type_id::create("rand_seq");
  rand_seq.start(env.agent.sequencer);
    
   
  targ_seq = alu_targeted_seq::type_id::create("targ_seq");
  targ_seq.start(env.agent.sequencer);
    
  cross_seq = alu_cross_seq::type_id::create("cross_seq");
  cross_seq.start(env.agent.sequencer);

    
   /*
    // env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_FIFO);//defualt
    //env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_WEIGHTED);
   // env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_RANDOM);
    //env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_STRICT_RANDOM);
    env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
    
    vseq = many_func_virtual_seq::type_id::create("vseq");
    vseq.seqr1 = env.agent.sequencer;
    vseq.seqr2 = env.agent.sequencer;
    vseq.seqr3 = env.agent.sequencer;
    
    vseq.randomize();
    
    vseq.start(null);
    */
    seq.start(env.agent.sequencer);
    
    #20;
   
    phase.drop_objection(this);
    
    
  endtask
    
endclass : my_test