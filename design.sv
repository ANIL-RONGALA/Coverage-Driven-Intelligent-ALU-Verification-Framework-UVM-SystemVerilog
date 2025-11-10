// Code your design here

//This is our interface

interface dut_if (input bit clock);
  logic reset;
  logic [31:0] in1;
  logic [31:0] in2;
  logic [3:0] cmd;
  logic [31:0] result;
  
  
  // build a modport for DUT
  modport DUTPORT (
  input clock,
  input reset,
  input in1,
  input in2,
    input cmd,
    output result );
  
  // build a modport for test 
  modport TESTPORT (
    input clock,
    output reset,
    output in1,
    output in2,
    output cmd,
    input result );
  
  // build a modport for Monitor 
  modport MONITORPORT (
    input clock,
    input reset,
    input in1,
    input in2,
    input cmd,
    input result );
  
endinterface


//This is our alu DUT

module dut(
  input reset, clock,
  input [31:0] in1, in2,
  input [3:0] cmd,
  output logic [31:0] result);
  
  
  always @(posedge clock) begin
    if (reset == 1) begin
      result <= 32'h0;
    end
    else begin
        // Operating based on control input
      case(cmd)

        4'b0000: result <= in1 & in2;
        4'b0001: result <= in1 | in2;
        4'b0010: result <= in1 + in2;
        4'b0100: result <= in1 - in2;
        4'b1000: begin 
          if(in1 <  in2)
            result <= 32'h1;
            else
            result <= 32'h0;
        end
        4'b0011: result <= in1<<in2;
        4'b0101: result <= in1>>in2;
        4'b0110: result <= in1*in2;
        4'b0111: result <= in1^in2;

      endcase // case (cmd)
    end
   end
	 
       
endmodule // dut


