# Coverage-Driven ALU UVM Verification Framework

This project implements a full SystemVerilog UVM verification environment for a 32-bit Arithmetic Logic Unit (ALU).

The goal is to create a realistic, reusable, and coverage-driven verification flow similar to what is used in industry.

# The environment includes sequencers, constrained-random stimulus, functional coverage, scoreboarding, assertions, and corner-case sequences. It is designed to reach high coverage and expose logic bugs in complex arithmetic operations.

This work reflects my interest in AI-assisted EDA, intelligent verification flows, and automated bug detection.

## 1. Project Objectives

This project demonstrates:

Building a full UVM testbench from scratch

Applying coverage-driven constrained-random verification

Designing multiple functional sequences (directed, random, cross-operation)

Creating predictor + scoreboard infrastructure for automated checking

Adding SystemVerilog Assertions (SVA) for protocol and data integrity

Using corner-case stimulus to target rare arithmetic conditions

Preparing the environment for future ML-based test selection

The project can be used as a template for any arithmetic or datapath block.

## 2. Repository Structure
```
.
├── design.sv                      # 32-bit ALU RTL
├── testbench.sv                   # Top-level environment + interface
├── my_testbench_pkg.svh           # All UVM components
│
├── my_agent.svh                   # Sequencer, driver, monitor
├── my_sequencer.svh
├── my_driver.svh
├── my_monitor.svh
│
├── my_env.svh                     # env + scoreboard + coverage
├── my_transaction.svh             # Sequence item
├── my_scoreboard.svh
├── my_comparator.svh
├── my_predictor.svh
│
├── my_coverage.svh                # Functional coverage model
│
├── sequences/
│   ├── one_func_seq.svh
│   ├── same_op_seq.svh
│   ├── any_func_seq.svh
│   ├── alu_edge_seq.svh
│   ├── alu_cross_seq.svh
│   ├── parallel_seq.svh
│
├── alu_assertions.svh             # SystemVerilog Assertions (SVA)
├── run.do                         # QuestaSim run script
└── README.md
```

Everything is built as independent, reusable components.

## 3. ALU Design Summary

The DUT supports these operations (9 total):

Opcode	Operation
0	ADD
1	SUB
2	AND
3	OR
4	XOR
5	MUL
6	LSL
7	LSR
8	SLT

The ALU is purely combinational, with inputs registered through the testbench interface.

## 4. How to Build & Run the Testbench
A. QuestaSim / ModelSim

Open terminal inside project directory

Run:

vsim -do run.do


or using qrun:

qrun -uvm -access +rwc design.sv testbench.sv

Output

You will see:

UVM sequence generation logs

Driver/monitor transactions

Scoreboard comparisons

Coverage report at end of run

Assertion messages if protocol is violated

## 5. UVM Environment Architecture
Test
 └── Env
      └── Agent
           ├── Sequencer  → generates transactions
           ├── Driver     → drives DUT
           ├── Monitor    → captures outputs
           ├── Scoreboard → compares expected vs actual
           └── Coverage   → measures functional coverage


A predictor is used inside the scoreboard to compute expected ALU output.

## 6. Functional Coverage Model

The coverage model targets:

Operand distribution

Zero

Max positive

Most negative

Small-range integers

Operation coverage

Every opcode 0–8 is covered.

Cross-coverage

opcode × operand1

opcode × operand2

Special conditions

Shift edge cases (0,1,31)

Multiplication conditions

Large operand interactions

You can achieve 95–100% coverage with the provided sequences.

## 7. SystemVerilog Assertions (SVA)

Assertions help catch issues that regular scoreboards may not find.

This framework checks:

Output resets correctly during reset

Illegal opcodes never appear

No X/Z values on cmd or result

Result does not change unexpectedly

ADD-with-zero behavior

Reset stability

These checks mimic protocol and data integrity verification common in production flows.

## 8. Scoreboard & Predictor

The scoreboard follows this flow:

Monitor → Scoreboard → Predictor → Compare results → Log mismatch


It automatically flags:

Arithmetic overflow misbehaviors

Incorrect shift operations

Wrong signed comparisons

Spurious values

RTL bugs under rare patterns

This makes debugging far easier.

## 9. Sequences Provided

Multiple sequences are included:

### 1. one_func_seq.svh

Directed test per opcode.

### 2. same_op_seq.svh

Repeats a single opcode with many input combinations.

### 3. any_func_seq.svh

Random opcode distribution.

### 4. alu_edge_seq.svh

Corner cases:

7fffffff, 80000000

Shifts by 0 and 31

Multiplication overflow

Zero interactions

### 5. alu_cross_seq.svh

Cross-product of operations and rare operands.

### 6. parallel_seq.svh

Runs several sequences in parallel to increase coverage quickly.

## 10. Example Terminal Output

### A typical run ends with:

UVM_INFO ... Coverage is 95%
UVM_INFO ... SCOREBOARD MATCHED RESULT
UVM_ERROR ... MISMATCH FOUND (detected bug example)


This shows real bug detection happening.

## 11. Future Extensions (Research Scope)

### A. AI-Guided Test Generation

The environment can be extended to:

Learn which sequences increase coverage fastest

Identify weak functional corners

Predict next best input pattern

Replace brute-force random with ML-guided test selection

This aligns with ongoing research in AI-driven verification acceleration.

### B. Automated Bug Clustering

Using logs collected from:

Scoreboard mismatches

Assertion failures

Coverage holes

You can apply:

Clustering

Classification

Failure-pattern grouping

This provides a path to build an AI-powered verification assistant, one of my long-term research goals.

## Acknowledgments

This project was developed as part of advanced digital design verification practice. It reflects practical experience with UVM methodology, RAL models, callbacks, predictor design, and register-level verification.

This project was developed under the academic guidance of [Dr. Yuha Chen](https://www.ece.uh.edu/faculty/chen-yuhua) , Department of Electrical and Computer Engineering, University of Houston. A small amount of AI assistance was used solely for documentation refinement. All RTL and verification environment work is original

