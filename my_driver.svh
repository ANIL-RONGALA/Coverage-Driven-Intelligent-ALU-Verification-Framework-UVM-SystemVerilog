
class my_driver extends uvm_driver #(my_transaction);
  `uvm_component_utils(my_driver)
  
 
  virtual dut_if.TESTPORT dut_vif;
 
  
  function new(string name, uvm_component parent); 
    super.new(name, parent); 
    endfunction
       

      function void build_phase(uvm_phase phase); 
        //get interface reference from config database
        if(!uvm_config_db#(virtual dut_if.TESTPORT)::get(this,"","dut_vif", dut_vif))  		
          begin
          `uvm_error("","uvm_config_db::get failed")
        end
      endfunction
  
      
      // run phase 
      
      task run_phase(uvm_phase phase);
        
        @(posedge dut_vif.clock);
        @(posedge dut_vif.clock);
        @(posedge dut_vif.clock);
        
        #1;// one clock signal delay 
        dut_vif.reset = 0;
        @(posedge dut_vif.clock);
        @(posedge dut_vif.clock);
        
        // TODO: Drive the other interfacing signals 
       
        forever begin
         
          seq_item_port.get_next_item(req);
          // wiggle pins of DUT
          
          @(posedge dut_vif.clock);
          
          dut_vif.in1 <= req.in1;
          dut_vif.in2 <= req.in2;
          dut_vif.cmd <= req.op;
          
          seq_item_port.item_done();
          
        
        end
          
      endtask

  
  endclass