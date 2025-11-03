# Coverage-Driven-Intelligent-ALU-Verification-Framework-UVM-SystemVerilog

# ALU Design & UVM Verification Environment

## Overview
This project implements and verifies a 32-bit ALU using SystemVerilog and UVM.  
The ALU supports a wide range of arithmetic and logic operations, and its correctness is validated using a comprehensive UVM testbench. 

## Features
- **Design:** 32-bit ALU with ADD, SUB, AND, OR, XOR, MUL, shift, and SLT operations.
- **Testbench:** Full UVM environment including sequencer, driver, monitor, predictor, scoreboard, and coverage.
- **Stimulus:**
  - Directed edge-case sequences (overflow, underflow, max/min integer cases).
  - Constraint-random sequences with weighted distribution.
  - Cross-coverage sequences to hit every op × input combination.
- **Coverage:** 95%+ functional coverage achieved.
- **Tools:** QuestaSim, SystemVerilog, UVM 1.2.

## Key Learnings
- Industry-standard ASIC/FPGA verification practices.
- Coverage-driven verification methodology.
- Debugging randomization conflicts, mismatches, and coverage holes.
- Key
