# RISC-V Based Hardware Accelerator for K-Nearest Neighbors (kNN)

This project is a custom hardware accelerator based on the RISC-V architecture designed to optimize K-Nearest Neighbors (KNN) operations. The accelerator includes several modules such as the Instruction Fetch Unit (IFU), Control Unit, Datapath, and customized Arithmetic Logic Unit (ALU). The design is implemented using Verilog and targets efficient computation for KNN-based algorithms.

![rtl_syn_processor](https://github.com/user-attachments/assets/545df136-3819-4aca-88c6-1389a8bc4145)


## Overview

The hardware accelerator comprises the following main components:

### 1. **Instruction Fetch Unit (IFU)**
- Fetches instructions from the instruction memory using the Program Counter (PC).
- Instruction memory is implemented as a Block RAM (BRAM).
  
- ![rtl_syn_IFU](https://github.com/user-attachments/assets/7baddaf2-2deb-4110-80dc-d381837142a7)
  
![IFU](https://github.com/user-attachments/assets/167d4f22-d8fe-4f7e-a968-a7c8e0975dde)


### 2. **Control Unit**
- Decodes the fetched instructions and generates the necessary control signals for other modules in the processor.
- Supports a range of instruction types, including integer operations, floating point operations, branch operations, floating point load, and integer load.
  
- ![rtl_syn_CU](https://github.com/user-attachments/assets/2a1290a7-bf31-42a4-9b67-d4a2a214e876)
  
- ![Control Unit](https://github.com/user-attachments/assets/b8496976-498c-4dab-b3c0-02d77931b7a7)



### 3. **Datapath**
- The core of the processor that performs arithmetic and logical operations.
- Contains three main components:
  - **ALU (Arithmetic Logic Unit):** Customized to handle KNN operations.
  - **Regfile (Register File):** Contains 32 registers, each 32 bits wide.
  - **Memory (Data Memory):** Two separate BRAMs for storing labels and data points.
  - ![rtl_syn_DP](https://github.com/user-attachments/assets/2b1fd4a1-e757-4ad3-8385-0427f6a172ad)


### 4. **Customized ALU**
The ALU is specifically designed for KNN operations and contains the following modules:

- **Floating Point Subtraction and Multiplication:** Combined into a single module to compute the square of differences.
- **Floating Point Square Root:** For calculating distances.
- **Floating Point Addition:** For summing distances or other operations.
- **Integer Addition:** For handling index calculations or integer-based operations.
- **Greater Than Comparison:** For branching decisions.
- **Sort and Majority Module:** To determine the nearest neighbors and the most common label among them.
- ![rtl_syn_ALU](https://github.com/user-attachments/assets/7ae6564f-2a5e-47a5-971d-ac6542e327e9)


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
