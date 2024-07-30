# 8-bit Dual Pipeline Superscalar RISC-V Processor

## Introduction

Our 8-bit dual-pipeline superscalar RISC-V microprocessor has been developed as part of the **IITI SoC 2024 Project PS-3**. Implemented in **Verilog HDL**, this microprocessor is designed to significantly enhance instruction throughput by executing multiple instructions per clock cycle. By leveraging a sophisticated superscalar architecture, it aims to surpass the performance of traditional non-pipelined processors. The dual-pipeline design facilitates simultaneous execution of multiple instructions, thus optimizing computational efficiency and achieving superior processing capabilities.


### Team Members (Team-3):
- B.Dinesh Laxman (Team Lead) 
- G Sushant Reddy
- M Devi Amrutha
- JL Manaswini

## Features

- **8-bit RISC-V ISA CPU Core**
- **Dual-Issue Superscalar Architecture**
- **5-Stage Pipeline: IF, ID, EX, MEM, WB**
- **Harvard Architecture**
- **RV32I Base Integer & RV32M Extensions** (Note: Some RV32I instructions are not supported)
- **Supports 4 Addressing Modes**
- **Two Integer ALUs**
- **Issue and Complete Atmost 2 Instructions/Cycle**
- **8-bit Instruction Fetch/Data Access**
- **32 General Purpose Registers**
- **Instruction Memory: 256x8-bit, Little-Endian**
- **Data Memory: 256x8-bit**
- **Hazard Management: Instruction Issue Unit, Hazard detection Unit and Forwading Path**
- **Pipeline Latches: IF_ID, ID_EX, EX_MEM, MEM_WB**
- **Supports Many Pseudo-Instructions: MV, NOT, NEG, BEQZ, BNEZ etc...**

An **in-depth explanation** of our approach to designing the microprocessor and its specifications is provided below.

## Contents

1. [Architecture Overview](#architecture-overview)
2. [Instruction Set Architecture](#instruction-set-architecture)
3. [Addressing Modes](#Addressing-Modes)
4. [Memory Architecture](#memory-architecture)
5. [Register File](#register-file)
6. [Instruction Decoding and Immediate Data Extraction (Decoder)](#instruction-decoding-and-immediate-data-extraction-decoder)
7. [Control Unit](#control-unit)
8. [Arithmetic Logic Unit (ALU)](#arithmetic-logic-unit-alu)
9. [Superscalar Pipeline](#superscalar-pipeline)
10. [Pipeline Stages](#pipeline-stages)
11. [Pipeline Latches](#pipeline-latches)
12. [Hazards](#hazards)
13. [Currently Supported Instructions](#currently-supported-instructions)
14. [Verification & Results](#verification--results)
15. [References](#references)
16. [Conclusion](#conclusion)
  
## Architecture Overview

In digital computing, various instruction set architectures (ISAs) exist, including:

- **RISC** (Reduced Instruction Set Computer)
- **CISC** (Complex Instruction Set Computer)
- **VLIW** (Very Long Instruction Word)
- **EPIC** (Explicitly Parallel Instruction Computing)

We have chosen the RISC architecture for our microprocessor due to its simplicity, efficiency, and adaptability.

### **Microprocessor Development Phases:**

1. **Initial Design (Mid-Evaluation):**  
   We explored research papers and online resources to understand ISA and microprocessor architecture. We completed a non-pipelined microprocessor capable of arithmetic and logical operations.

   ![image](https://github.com/user-attachments/assets/64e7f176-2236-4e3a-bae8-9f8bcb286429)


3. **Pipelining Implementation (Until July 20):**  
   We advanced to a pipelined microprocessor, incorporating hazard detection units to handle raw and control hazards effectively.

   ![117547053-f932fe00-b046-11eb-91af-9291291d4f52](https://github.com/user-attachments/assets/55df8e2e-3487-479a-9202-e5d3c6ee8b68)

5. **Enhancement Phase (Until July 27):**  
   With the extended submission deadline, we refined the design by adopting a superscalar architecture. This approach, which involved duplicating datapaths and managing data hazards, was chosen over complex out-of-order execution. We successfully implemented the instruction issuing unit, next PC logic, and forwarding paths based on insights from research papers.

   ![image](https://github.com/user-attachments/assets/90db8592-ab90-41df-ab93-29e743f75cec)

   **Note: Every part of the schematic Diagram is not implemented these are just used as a references for our processor design in each stage. Actual Schematics are shown in Verification and Results Section**


## Instruction Set Architecture

We implement basic instructions from the RV32I Base Integer Instruction Set. These instructions are all 32 bits in length and aligned on a four-byte boundary in memory. Our base ISA includes three instruction formats: R-type, I-type, S-type, and B-type.

### Instruction Formats

- **R-type**: 
  ```
  funct7 [31:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | rd [11:7] | opcode [6:0]
  ```

- **I-type**:
  ```
  0000 (unused) | immediate [31:24] | rs1 [19:15] | funct3 [14:12] | rd [11:7] | opcode [6:0]
  ```

- **S-type**:
  ```
  0000 (unused) | immediate [27:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | immediate [11:7] | opcode [6:0]
  ```

- **B-type**:
  ```
  000 (unused) | immediate [28:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | immediate [11:8] | 0 (unused) | opcode [6:0]
  ```

## Addressing Modes  

1. **Immediate Addressing**:
   - Operand is directly specified in the instruction.
   - Used in: `ADDI`, `SLTI`, `SLTIU`, `XORI`, `ORI`, `ANDI`, `SLLI`, `SRLI`.

2. **Register Addressing**:
   - Operand is specified in a register.
   - Used in: `ADD`, `SUB`, `SLL`, `SRL`, `SLT`, `SLTU`, `SRA`, `XOR`, `AND`, `OR`, `MUL`, `MULH`, `MULSU`, `MULHU`, `DIV`, `DIVU`, `REM`, `REMU`

3. **Base + Offset (Displacement) Addressing**:
   - Operand is at an address computed by adding an offset to a base register.
   - Used in: `LW`, `SW`.

4. **PC-Relative Addressing**:
   - Address is computed relative to the program counter.
   - Used in: `BEQ`, `BNE`, `BLT`, `BGE`, `BLTU`, `BGEU`.

 - A detailed explanation of instructions is given in the  [Currently Supported Instructions](#currently-supported-instructions) section.

## Memory Architecture

The microprocessor employs the Harvard architecture, featuring separate memories for instructions and data. This approach enhances performance by allowing simultaneous access to both instruction and data memories.

### Instruction Memory

- **Address Space**: 256x8
- **Word Size**: 8-bit
- **Byte Ordering**: Little-endian
- **Instruction Storage**: Each instruction is stored in 4 consecutive registers.
- **Dual Instruction Fetch**: Fetches two 32-bit instructions per cycle, allowing parallel instruction processing.

### Data Memory

- **Address Space**: 256x8
- **Word Size**: 8-bit
- **Dual-Path Read and Write**: Supports simultaneous read and write operations on two different addresses (Dual-Port Memory).

## Register File

- **Registers**: 32x8-bit
- **Special Register**: `x0` is hardwired to zero.
- **Supports Dual Write Ports**: Handles two sets of inputs for reading and writing to registers simultaneously.
- **Priority Handling for Writes**: Prioritizes the second write operation (writedata_2) if both write requests target the same register.
  
## Instruction Decoding and Immediate Data Extraction (Decoder)

- The **Instruction_splitter** module decodes the two incoming parallel instructions. This module identifies the instruction types and breaks them down into their constituent parts for further processing.

- The **Imm_data** module extracts the immediate data based on the instruction format. It supports various instruction formats, including I-type, S-type, and B-type, ensuring that immediate values are correctly parsed and made available for instruction execution.


## Control Unit

The control unit generates control signals for both instructions based on the opcode. It is divided into two levels:

1. **Main Control Unit**: Manages control signals for the data memory, register file, and various multiplexers.
2. **ALU Control Unit**: Receives signals from both the main control unit and the instruction to generate appropriate signals for the ALU.

## Arithmetic Logic Unit (ALU)

- The Arithmetic Logic Unit (ALU) executes arithmetic operations like addition and subtraction, and logical operations such as AND, OR, and XOR. 
- It processes data based on instructions, producing results that are then used by the rest of the processor, including writing them to registers or memory. 
- A list of arithmetic and logic operations performed by ALU is given in the  [Currently Supported Instructions](#currently-supported-instructions) section.

## Superscalar Pipeline

Our design aims to implement a superscalar architecture by giving the microprocessor two parallel data paths. This allows it to fetch, decode, and execute two instructions per clock cycle.

### Dual Pipeline Stages

1. **Fetch**
   - Two instructions are fetched from the instruction memory simultaneously.
   
2. **Decode**
   - Both instructions are decoded, and operands are read from the register file.
   
3. **Execute**
   - Each instruction is executed in a separate ALU.

4. **Memory**
   - Memory access operations are performed for both instructions.

5. **Writeback**
   - Results of both instructions are written back to the register file.

### Additional Control Logic

To support dual instruction execution, additional control logic is required to handle dependencies and resource conflicts between the two instructions. This includes:

- **Instruction Issuing Unit** : 
- The Instruction Issuing Unit (IIU) operates in the ID stage, decoding incoming instructions from the Instruction Memory and detecting operand dependencies. If a dependency is found, the second instruction is held in a register and a "rollback" signal adjusts the next-PC value. The held instruction is then issued in the following clock cycle.Dependencies include RAW hazard between first and second instruction and first instruction being a branch instruction.

- **Next-PC Logic** :
- Whenever the “rollback” signal is asserted in the ID stage,next PC value will be the address of next instruction (PC + 4), otherwise it is the address of the instruction after the next instruction (PC + 8). 

### Pipeline Stages

1. **IF (Instruction Fetch)**: Fetches the instruction from memory.
2. **ID (Instruction Decode)**: Decodes the instruction and reads registers.
3. **EX (Execute)**: Performs the operation specified by the instruction.
4. **MEM (Memory Access)**: Accesses memory for load and store instructions.
5. **WB (Writeback)**: Writes the result back to the register file.

### Pipeline Latches

- **IF_ID**: Holds information between the Fetch and Decode stages.
- **ID_EX**: Holds information between the Decode and Execute stages.
- **EX_MEM**: Holds information between the Execute and Memory stages.
- **MEM_WB**: Holds information between the Memory and Writeback stages.

### Hazards

In a pipelined microprocessor, hazards can be categorized into three main types:

1. **Data Hazards:**
 - Occur when instructions that exhibit data dependencies modify data in different stages of the pipeline.
   - **Types:**
     - **Read After Write (RAW):** A subsequent instruction tries to read a source operand before a previous instruction writes to it.
     - **Write After Read (WAR):** A subsequent instruction tries to write to a destination operand before a previous instruction reads it.
     - **Write After Write (WAW):** Two instructions try to write to the same destination operand in an incorrect order.

2. **Control Hazards:**
   - Arise from the pipelining of branch instructions and other instructions that change the Program Counter (PC).
   - **Example:** Incorrect predictions of branch outcomes can lead to fetching and executing wrong instructions.

3. **Structural Hazards:**
   - Occur when hardware resources are insufficient to support all the concurrent operations in the pipeline.
   - **Example:** If the instruction and data memory share the same memory and both stages need access simultaneously, a conflict occurs.

### Hazard Handling

In the design of our superscalar processor, various strategies are employed to handle different types of hazards, ensuring smooth and accurate execution of instructions. Here’s a detailed explanation of how each type of hazard is managed:

#### Data Hazards

1. **Read After Write (RAW) Hazards**:
   - **Forwarding Path**: To resolve RAW hazards, we implement a forwarding mechanism. This allows the processor to forward the result of an instruction that is yet to be written back to the register file directly to the subsequent instruction that needs it, bypassing the normal data path. This ensures that the dependent instruction gets the correct data without waiting for the write-back stage to complete.

2. **Write After Read (WAR) Hazards**:
   - **In-Order Execution**: WAR hazards typically occur in out-of-order execution scenarios. Since our processor executes instructions in order, WAR hazards are inherently avoided. The read operation always occurs before the subsequent write operation, thus eliminating the need for additional handling mechanisms.

3. **Write After Write (WAW) Hazards**:
   - **Dual Data Paths**: WAW hazards are possible in our parallel execution environment. To address this, we design the processor with two data paths where the sequentially latest instruction is always implemented in the second data path. If a WAW hazard occurs, the write data from the second data path is prioritized and written back into the register, ensuring the correct value is stored.
     
   - **The following is one such example depicting a "READ AFTER WRITE" hazard where the second issued instruction has been stalled**
   -  ![image](https://github.com/user-attachments/assets/32762072-0c31-4944-959f-9e9c69fe9881)


#### Structural Hazards

1. **Register File Access**:
   - **Simultaneous Read and Write**: During the read operation, if a register is being read from and simultaneously written to, the module prioritizes the written data. This means that the data being written (from `write_data_2` if `reg_write_2` is active) will be reflected in the read operation output rather than the old data.
 
 2. **Data Memory Access**:
   - **Memory Conflicts**: Simultaneous read and write operations on the same address from different data paths are possible. To handle this, the write data is bypassed to the read data port instead of reading the old data stored at that address. This ensures that the read operation reflects the most recent write operation's data, maintaining data integrity across the memory accesses.

#### Control Hazards

   **Simple Flush Mechanism**:
   - **Pipeline Flush**: To handle control hazards, we implement a simple flush mechanism. If a branch is taken or a jump instruction is encountered, the instructions in the pipeline that are no longer valid are flushed. This prevents incorrect instructions from being executed, ensuring the correctness of the program flow.


## Currently Supported Instructions

### RV32I Base Integer Instruction Set

### I-Type Instructions

1. **ADDI**  
   - Adds 8-bit immediate to register `rs1`.  
   - Result stored in `rd`.

2. **SLTI**  
   - Sets `rd` to 1 if `rs1` is less than the immediate (signed comparison), otherwise 0.

3. **SLTIU**  
   - Sets `rd` to 1 if `rs1` is less than the immediate (unsigned comparison), otherwise 0.

4. **XORI**  
   - Performs bitwise XOR on `rs1` and the 8-bit immediate.  
   - Result stored in `rd`.

5. **ORI**  
   - Performs bitwise OR on `rs1` and the 8-bit immediate.  
   - Result stored in `rd`.

6. **ANDI**  
   - Performs bitwise AND on `rs1` and the 8-bit immediate.  
   - Result stored in `rd`.

7. **SLLI**  
   - Shifts `rs1` left logically by the shift amount in the lower 5 bits of the immediate.  
   - Result stored in `rd`.

8. **SLRI**  
   - Shifts `rs1` right logically by the shift amount in the lower 5 bits of the immediate.  
   - Result stored in `rd`.

### R-Type Instructions

9. **ADD**  
   - Adds `rs1` and `rs2`.  
   - Result stored in `rd`.

10. **SUB**  
    - Subtracts `rs2` from `rs1`.  
    - Result stored in `rd`.

11. **SLL**  
    - Shifts `rs1` left logically by the shift amount in the lower 5 bits of `rs2`.  
    - Result stored in `rd`.

12. **SLR**  
    - Shifts `rs1` right logically by the shift amount in the lower 5 bits of `rs2`.  
    - Result stored in `rd`.

13. **SLT**  
    - Sets `rd` to 1 if `rs1` is less than `rs2` (signed comparison), otherwise 0.

14. **SLTU**  
    - Sets `rd` to 1 if `rs1` is less than `rs2` (unsigned comparison), otherwise 0.

15. **SRA**  
    - Shifts `rs1` right arithmetically by the shift amount in the lower 5 bits of `rs2`.  
    - Result stored in `rd`.

16. **XOR**  
    - Performs bitwise XOR on `rs1` and `rs2`.  
    - Result stored in `rd`.

17. **AND**  
    - Performs bitwise AND on `rs1` and `rs2`.  
    - Result stored in `rd`.

18. **OR**  
    - Performs bitwise OR on `rs1` and `rs2`.  
    - Result stored in `rd`.

### Load and Store Instructions

19. **LOAD**  
    - Loads an 8-bit value from memory.  
    - Stores it in `rd`.

20. **STORE**  
    - Stores an 8-bit value from `rs2` to memory.

### Branch Instructions

21. **BEQ**  
    - Branch to the target address if `rs1` equals `rs2`.  

22. **BNE**  
    - Branch to the target address if `rs1` does not equal `rs2`.  

23. **BLT**  
    - Branch to the target address if `rs1` is less than `rs2` (signed).  

24. **BGE**  
    - Branch to the target address if `rs1` is greater than or equal to `rs2` (signed).  

25. **BLTU**  
    - Branch to the target address if `rs1` is less than `rs2` (unsigned).  

26. **BGEU**  
    - Branch to the target address if `rs1` is greater than or equal to `rs2` (unsigned).  

### RV32M Standard Extension for Integer Multiplication and Division

27. **MUL**  
    - Multiplies signed `rs1` by signed `rs2`.  
    - Lower XLEN bits stored in `rd`.

28. **MULH**  
    - Multiplies signed `rs1` by signed `rs2`.  
    - Upper XLEN bits stored in `rd`.

29. **MULSU**  
    - Multiplies signed `rs1` by unsigned `rs2`.  
    - Upper XLEN bits stored in `rd`.

30. **MULHU**  
    - Multiplies unsigned `rs1` by unsigned `rs2`.  
    - Upper XLEN bits stored in `rd`.

31. **DIV**  
    - Divides signed `rs1` by signed `rs2`.  
    - Result stored in `rd`.

32. **DIVU**  
    - Divides unsigned `rs1` by unsigned `rs2`.  
    - Result stored in `rd`.

33. **REM**  
    - Computes remainder of signed `rs1` divided by signed `rs2`.  
    - Result stored in `rd`.

34. **REMU**  
    - Computes remainder of unsigned `rs1` divided by unsigned `rs2`.  
    - Result stored in `rd`.

---

### Notes

- **ADDI rd, rs1, 0** is utilized to implement the `MV rd, rs1` assembler pseudo-instruction, which moves the value from register `rs1` to register `rd`.

- **XORI rd, rs1, -1** performs a bitwise logical inversion of the value in register `rs1`, effectively implementing the `NOT rd, rs1` assembler pseudo-instruction.

- **SUB rd, x0, rs** computes the two's complement of the value in register `rs`, storing the result in register `rd`. This operation is used to implement the `NEG rd, rs` assembler pseudo-instruction, which negates the value in register `rs`.
- In the same way many other pseudo instructions can be implemented by just manipulating the already existing instructions in the RISC-V ISA.
- Detailed information about each instruction, their opcodes, and different function codes can be found [here](https://msyksphinz-self.github.io/riscv-isadoc/html/rvi.html#lui). This resource was also used as a reference while writing the ISA for our microprocessor.

## Verification & Results

- As we adapted the general instruction codes from the RISC-V ISA, our processor is fully compatible with many online RISC-V assemblers. This ensures that it implements instructions accurately and allows for seamless integration with existing tools and frameworks. 
- The design has been thoroughly tested and verified, demonstrating that it handles a wide range of instructions correctly and efficiently. The results confirm the processor’s capability to execute multiple instructions per cycle, achieving the desired performance improvements over traditional non-pipelined processors.

**This is where we started ...**
- Schematic Diagram of Non-Pipelined Microprocessor
   ![image](https://github.com/user-attachments/assets/da627b6f-8f6b-4825-9ca8-28301f38782c)
  
**And, This is where we ended ...**
 - Schematic Diagram of Superscalar Microprocessor
![image](https://github.com/user-attachments/assets/6de86e54-10d9-4ea5-b2a1-d1e99a10c53d)

   - Corresponding simulation for the non pipelined processor
  ![WhatsApp Image 2024-07-24 at 19 08 59_521d5cec](https://github.com/user-attachments/assets/14b79a59-34ed-4f18-b74f-d7bcc60f3cfa)
- The time taken for processing all the instructions was around 1400ns.


 -  Corresponding simulation for the superscalar processor
 ![image](https://github.com/user-attachments/assets/6875dcb8-261d-4eb5-89a5-d989fb0d20ee)
  -  Here the time taken for processing all the instructions is around 200ns.



- **Our superscalar microprocessor offers up to** **<span style="font-size: 4em; font-weight: bold;">700%</span>** **improvement in speed and efficiency compared to its non-pipelined counterpart. By harnessing advanced parallelism techniques, this microprocessor achieves unparalleled performance.**


### **Branch instructions** 

The branch handling in this superscalar processor is done in the decode stage. When the branch decision gets taken the program counter is updated according to the offset values form the immediate data, subsequently in which set the branch gets executed, it also plays a role and that is managed accordingly by the rollback signal.
The following are the instructions used for testing the branching unit and are executed along with other instructions in the instruction memory:
```
BNEQ x2,x1,3
BLT x2,x1,3
BGT x2,x1,3 
```
The first two branches get executed and the program counter and the hazard signals get updated accordingly.

![image](https://github.com/user-attachments/assets/0aef7738-dc88-4ad4-804f-fea055f46b45)
![image](https://github.com/user-attachments/assets/cd1022c6-4afd-4056-981c-8acdce29b518)

## References

- https://msyksphinz-self.github.io/riscv-isadoc/html/rvi.html#auipc  (For Instructions)

- http://shodhbhagirathi.iitr.ac.in:8081/jspui/handle/123456789/13119?mode=full  (Research Paper)

- https://developers.google.com/mpact-sim/guides/riscv_binary_decoder#add_register-register_alu_instruction   (For ISA)

- https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf (For ISA)

- https://github.com/riscv-non-isa/riscv-asm-manual/blob/main/riscv-asm.md#-a-listing-of-standard-risc-v-pseudoinstructions (For Pseudo Instructions)

- https://ijrpr.com/uploads/V5ISSUE4/IJRPR24834.pdf (For Microprocessor)

- https://drive.google.com/drive/folders/1865gQ5SyB4dZ4EoLMbSYr67GkDQLMwet?usp=sharing   (Contains some research Papers and Notes)



## Conclusion

This 8-bit dual pipeline superscalar RISC-V processor leverages the advantages of RISC architecture and superscalar execution to achieve high performance. By carefully managing hazards and optimizing the pipeline, this design aims to provide efficient instruction throughput. The processor was designed with flexibility in mind, allowing it to execute many of the standard RISC-V assembly instructions correctly, as it directly adapts general instruction codes for compatibility with existing RISC-V assemblers.

While the current design has achieved significant improvements in performance, some enhancements were not completed due to time constraints. Notably, a two-bit dynamic branch predictor was intended to be implemented to improve branch prediction accuracy. This feature, if completed, would have further optimized instruction throughput by reducing branch mispredictions and their associated penalties.

### Advantages

- Increased Throughput
- Parallelism
- Reduced Latency for Independent Instructions
- Enhanced Performance
- Harvard Architecture

### Disadvantages

- Increased Complexity
- Resource Conflicts
- Higher Power Consumption
- Increased Area
- Complex Hazard Management

Future improvements that could further enhance the microprocessor’s capabilities include:

- **Increasing data bit width**
- **Out-of-Order Execution**
- **Dynamic Branch Prediction**
- **Speculative Execution**


These enhancements, if implemented, could push the performance of the microprocessor even further, making it more suitable for a broader range of applications and more demanding computational tasks.

---
