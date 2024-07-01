# 8-bit RISC Microprocessor Design

In digital computing, various instruction set architectures (ISAs) exist, including:

- **RISC** (Reduced Instruction Set Computer)
- **CISC** (Complex Instruction Set Computer)
- **VLIW** (Very Long Instruction Word)
- **EPIC** (Explicitly Parallel Instruction Computing)

We have chosen the RISC architecture for our microprocessor due to its simplicity, efficiency, and adaptability.

## CPU Stages

Our CPU is designed with a 5-stage pipeline comprising:

1. **Fetch**
2. **Decode**
3. **Execute**
4. **Memory**
5. **Writeback**

## Instruction Set Architecture

We implement basic instructions from the RV32I Base Integer Instruction Set. These instructions are all 32 bits in length and aligned on a four-byte boundary in memory. Our base ISA includes three instruction formats: R-type, I-type, and S-type.

### Instruction Formats

- **R-type**: 
  ```
  funct7 [31:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | rd [11:7] | opcode [6:0]
  ```

- **I-type**:
  ```
  immediate [31:24] | 0000 (unused) | rs1 [19:15] | funct3 [14:12] | rd [11:7] | opcode [6:0]
  ```

- **S-type**:
  ```
  0000 (unused) | immediate [27:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | immediate [11:7] | opcode [6:0]
  ```

## Memory Architecture

The microprocessor employs the Harvard architecture, featuring separate memories for instructions and data. This approach enhances performance by allowing simultaneous access to both instruction and data memories.

### Instruction Memory

- **Address Space**: 64x8
- **Word Size**: 8-bit
- **Byte Ordering**: Little-endian (commercially dominant; used in x86 systems, iOS, Android, and Windows for ARM)
- **Instruction Storage**: Each instruction is stored in 4 consecutive registers.

### Data Memory

- **Address Space**: 64x8
- **Word Size**: 8-bit

## Register File

- **Registers**: 32x8-bit
- **Special Register**: `x0` is hardwired to zero.

## Control Unit

The control unit generates control signals based on the opcode. It is divided into two levels:

1. **Main Control Unit**: Manages control signals for the data memory, register file, and various multiplexers.
2. **ALU Control Unit**: Receives signals from both the main control unit and the instruction to generate appropriate signals for the ALU.


## Currently Supported Instructions

### RV32I Base Integer Instruction Set

1. **ADDI** 
   - Adds 8-bit immediate to register `rs1`.
   - Arithmetic overflow is ignored, and the result is simply the low XLEN bits of the result.

2. **SLTIU** 
   - Places the value 1 in register `rd` if register `rs1` is less than the immediate when both are treated as unsigned numbers.
   - Otherwise, 0 is written to `rd`.

3. **XORI** 
   - Performs bitwise XOR on register `rs1` and the 8-bit immediate.
   - Places the result in `rd`.

4. **ORI** 
   - Performs bitwise OR on register `rs1` and the 8-bit immediate.
   - Places the result in `rd`.

5. **ANDI** 
   - Performs bitwise AND on register `rs1` and the 8-bit immediate.
   - Places the result in `rd`.

6. **SLLI** 
   - Performs logical left shift on the value in register `rs1` by the shift amount held in the lower 5 bits of the immediate.

7. **SLRI** 
   - Performs logical right shift on the value in register `rs1` by the shift amount held in the lower 5 bits of the immediate.

8. **ADD** 
   - Adds registers `rs1` and `rs2`.
   - Stores the result in `rd`.
   - Arithmetic overflow is ignored, and the result is simply the low XLEN bits of the result.

9. **SUB** 
   - Subtracts register `rs2` from `rs1`.
   - Stores the result in `rd`.
   - Arithmetic overflow is ignored, and the result is simply the low XLEN bits of the result.

10. **SLL** 
    - Performs logical left shift on the value in register `rs1` by the shift amount held in the lower 5 bits of register `rs2`.

11. **SLR** 
    - Performs logical right shift on the value in register `rs1` by the shift amount held in the lower 5 bits of register `rs2`.

12. **SLTU** 
    - Places the value 1 in register `rd` if register `rs1` is less than register `rs2` when both are treated as unsigned numbers.
    - Otherwise, 0 is written to `rd`.

13. **XOR** 
    - Performs bitwise XOR on registers `rs1` and `rs2`.
    - Places the result in `rd`.

14. **AND** 
    - Performs bitwise AND on registers `rs1` and `rs2`.
    - Places the result in `rd`.

15. **OR** 
    - Performs bitwise OR on registers `rs1` and `rs2`.
    - Places the result in `rd`.

16. **LOAD** 
    - Loads an 8-bit value from memory.
    - Stores it in register `rd`.

17. **STORE** 
    - Stores an 8-bit value from the register `rs2` to memory.

### RV32M Standard Extension for Integer Multiplication and Division

18. **MUL** 
    - Performs an XLEN-bit x XLEN-bit multiplication of `rs1` by `rs2`.
    - Places the lower XLEN bits in the destination register.

19. **MULHU** 
    - Performs an XLEN-bit x XLEN-bit multiplication of unsigned `rs1` by unsigned `rs2`.
    - Places the upper XLEN bits in the destination register.

20. **DIVU** 
    - Performs an XLEN bits by XLEN bits unsigned integer division of `rs1` by `rs2`.
    - Rounding towards zero.

21. **REMU** 
    - Performs an XLEN bits by XLEN bits unsigned integer remainder of `rs1` by `rs2`.

### Notes

- **ADDI rd, rs1, 0** is used to implement the `MV rd, rs1` assembler pseudo-instruction.
- **XORI rd, rs1, -1** performs a bitwise logical inversion of register `rs1` (assembler pseudo-instruction `NOT rd, rs`).
## Pipelining

In this 5-stage pipeline, there are 4 pipeline registers:

1. **IF_ID**
2. **ID_EX**
3. **EX_MEM**
4. **MEM_WB**

This structured design leverages the RISC architecture's advantages, ensuring efficient and reliable operation of the microprocessor.

In the future, we will implement branch and jump instructions along with hazard detection and forwarding unit features in our processor design. These enhancements aim to optimize instruction execution by effectively managing data dependencies and minimizing pipeline stalls, thereby improving overall processor performance and efficiency.
