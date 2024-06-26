# 8-bit RISC Microprocessor

In digital computing, various instruction set architectures (ISAs) exist, including:

- **RISC** (Reduced Instruction Set Computer)
- **CISC** (Complex Instruction Set Computer)
- **VLIW** (Very Long Instruction Word)
- **EPIC** (Explicitly Parallel Instruction Computing)

For our microprocessor design, we have chosen the RISC architecture due to its simplicity, efficiency, and adaptability.

## CPU Stages

The CPU is designed with a 5-stage pipeline comprising:

1. **Fetch**
2. **Decode**
3. **Execute**
4. **Memory**
5. **Writeback**

## Instruction Set Architecture

We implement instructions from the RV32I Base Integer Instruction Set, which are all 32 bits in length and aligned on a four-byte boundary in memory. Our base ISA includes three instruction formats: R-type, I-type, and S-type, as of now.

### Instruction Formats

- **R-type**: 
  ```
  funct7 [31:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | rd [11:7] | opcode [6:0]
  ```

- **I-type**:
  ```
  immediate [31:24] | 00000 (unused) | rs1 [19:15] | funct3 [14:12] | rd [11:7] | opcode [6:0]
  ```

- **S-type**:
  ```
  0000 (unused) | funct7 [27:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | immediate [11:7] | opcode [6:0]
  ```

## Memory Architecture

The microprocessor employs the Harvard architecture, which features separate memories for instructions and data. This approach enhances performance by allowing simultaneous access to both instruction and data memories.

### Instruction Memory

- **Address Space**: 64x8
- **Word Size**: 8-bit
- **Byte Ordering**: Little-endian (commercially dominant; used in x86 systems, iOS, Android, and Windows for ARM)
- **Instruction Storage**: Each instruction is stored in 4 registers.

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

This structured design leverages the RISC architecture's advantages, ensuring efficient and reliable operation of the microprocessor.

In future, we will try to implement branch and jump instructions with hazard dectection and forwarding unit features.
