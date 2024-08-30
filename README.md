# RISC-V Based Hardware Accelerator for K-Nearest Neighbors (KNN)

This project is a custom hardware accelerator based on the RISC-V architecture designed to optimize K-Nearest Neighbors (KNN) operations. The accelerator includes several modules such as the Instruction Fetch Unit (IFU), Control Unit, Datapath, and customized Arithmetic Logic Unit (ALU). The design is implemented using Verilog and targets efficient computation for KNN-based algorithms.

## Overview

The hardware accelerator comprises the following main components:

### 1. **Instruction Fetch Unit (IFU)**
- Fetches instructions from the instruction memory using the Program Counter (PC).
- Instruction memory is implemented as a Block RAM (BRAM).

### 2. **Control Unit**
- Decodes the fetched instructions and generates the necessary control signals for other modules in the processor.
- Supports a range of instruction types, including integer operations, floating point operations, branch operations, floating point load, and integer load.

### 3. **Datapath**
- The core of the processor that performs arithmetic and logical operations.
- Contains three main components:
  - **ALU (Arithmetic Logic Unit):** Customized to handle KNN operations.
  - **Regfile (Register File):** Contains 32 registers, each 32 bits wide.
  - **Memory (Data Memory):** Two separate BRAMs for storing labels and data points.

### 4. **Customized ALU**
The ALU is specifically designed for KNN operations and contains the following modules:

- **Floating Point Subtraction and Multiplication:** Combined into a single module to compute the square of differences.
- **Floating Point Square Root:** For calculating distances.
- **Floating Point Addition:** For summing distances or other operations.
- **Integer Addition:** For handling index calculations or integer-based operations.
- **Greater Than Comparison:** For branching decisions.
- **Sort and Majority Module:** To determine the nearest neighbors and the most common label among them.

### 5. **Memory Architecture**
- **Instruction Memory:** Implemented as BRAM, used by the IFU for fetching instructions.
- **Data Memory:**
  - One BRAM dedicated for storing labels.
  - Another BRAM for storing data points.

## Supported Instruction Types

The RISC-V-based accelerator supports a variety of instruction types to perform different operations:

- **Integer Operations:** Basic arithmetic and logical operations.
- **Floating Point Operations:** Addition, subtraction, multiplication, and square root operations on floating-point numbers.
- **Branch Operations:** Conditional branching based on comparison results.
- **Floating Point Load:** Instructions to load floating-point data from memory.
- **Integer Load:** Instructions to load integer data from memory.
