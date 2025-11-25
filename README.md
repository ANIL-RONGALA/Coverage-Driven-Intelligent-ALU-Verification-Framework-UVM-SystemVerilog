Coverage-Driven ALU Verification Framework (SystemVerilog UVM)

This project contains a complete UVM-based verification environment for a 32-bit ALU.
The main goal is to build a clean, modular, and coverage-oriented testbench that behaves like an industry-style verification flow.
All components—driver, sequencer, monitor, scoreboard, coverage, and assertions—are written in SystemVerilog with UVM-1.2.

The testbench uses constrained-random stimulus and a reference model to check correctness.
Assertions are added on the interface side to monitor illegal behavior during simulation.
The environment is structured so that anyone can extend it for more operations or integrate it into a larger processor pipeline later.

1. Features
Randomized Stimulus

The sequencer and sequence classes generate random ALU operations, including corner cases such as zero, maximum positive, and minimum negative values.

Functional Coverage

Coverage is based on operand values, opcode distribution, and cross combinations.
This helps confirm that all meaningful input conditions are exercised at least once.

Assertions

Simple SVA checks are included to catch protocol-related issues like command stability, shift validity, and reset behavior.

Scoreboarding

A small reference model predicts the correct result.
The scoreboard compares DUT output vs expected output and reports mismatches cleanly.

Easy to Extend

All files follow the standard UVM layout, making it simple to add more operations or modify the ALU.

2. Repository Structure
/rtl
   alu.sv

/tb
   dut_if.sv
   my_transaction.svh
   my_sequence.svh
   my_sequencer.svh
   my_driver.svh
   my_monitor.svh
   my_scoreboard.svh
   my_coverage.svh
   my_agent.svh
   my_env.svh
   my_test.svh

/assertions
   alu_assertions.sv

README.md

3. How to Run (ModelSim / QuestaSim)
Compile
vlog rtl/*.sv tb/*.sv assertions/*.sv +incdir+tb +incdir+assertions

Run
vsim top -do "run -all"


Optional flags:

+UVM_CONFIG_DB_TRACE
+UVM_VERBOSITY=UVM_HIGH

4. Testbench Architecture (ASCII Diagram — 100% GitHub Safe)

```text
+--------------------------------------------------------------------------+
|                                   my_test                                |
+--------------------------------------------------------------------------+
|                                   my_env                                 |
|--------------------------------------------------------------------------|
|   +-----------------------+     +-----------------------------+          |
|   |       my_agent        |     |        my_scoreboard        |          |
|   |-----------------------|     |-----------------------------|          |
|   |  my_sequencer         |     |  compares DUT vs reference  |          |
|   |  my_driver ---------->|---->|-----------------------------|          |
|   |  my_monitor --------->|-------> sends txn for checking    |          |
|   +-----------------------+                                        	  |
|                                                                          |
|   +-----------------------+                                              |
|   |      my_coverage      | <---- samples every transaction             |
|   +-----------------------+                                              |
+--------------------------------------------------------------------------+
                                   |
                                   v
                                +------+
                                | DUT  |
                                +------+
```



5. Sequence Flow (Simplified Diagram)
Test
 └── Env
      └── Agent
           ├── Sequencer  → generates transactions
           ├── Driver     → drives DUT
           ├── Monitor    → captures outputs
           ├── Scoreboard → compares expected vs actual
           └── Coverage   → measures functional coverage



These diagrams will always show on GitHub (no blank boxes, no dynamic rendering).

This is the basic transaction flow used in most UVM designs.

6. Bug Examples Found During Verification

During regression, the following common bugs were detected:

Mismatch in SUB Operation
in1 = 80000000  
in2 = 7FFFFFFF  
op  = SUB  
DUT result      = 00000000  
Reference model = 00000001  


The testbench caught it automatically through the scoreboard.

Command Stability Issue
ASSERTION FAILED: cmd changed mid-cycle


This happens if the stimulus changes the opcode in the middle of a clock cycle.
It helps ensure the ALU interface is stable.

AND Operation Illegal Output
ASSERTION FAILED: AND result has illegal bits


Triggered when the DUT produced a bit in the result that was not present in both inputs.

7. AI-Based Future Extensions (Very Simple, Human Tone)

Even though the current project uses standard UVM, it can be extended for AI-related research:

A. Coverage-Guided Input Selection

Instead of random inputs, an ML model can look at uncovered bins and generate the next input that fills coverage faster.
This is useful for reducing simulation cycles.

B. Automatic Debug Suggestions

Waveform data, assertion failures, and scoreboard mismatches can be fed to an LLM that explains the most likely bug and suggests where in the RTL the issue may come from.

These extensions fit well for research in AI-EDA and intelligent verification flows.

8. Future Work

Add overflow and carry flag coverage

Add directed test sequences

Add mutation testing on the ALU

Extend operations to match RISC-V spec

Try ML-based test selection
