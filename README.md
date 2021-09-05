# CPU

> Click [here](https://github.com/ei9/cheat_sheet#project) for more mini processor i made before.

RV32I has 47 instructions.

## Instructions

|Category|Name|Format|RV32I Base|
|:----|----:|:----:|:----|
|Loads|Load Byte|I|LB rd,rs1,imm|
||Load Halfword|I|LH rd,rs1,imm|
||Load Word|I|LW rd,rs1,imm|
||Load Byte Unsigned|I|LBU rd,rs1,imm|
||Load Half Unsigned|I|LHU rd,rs1,imm|
|Stores|Store Byte|S|SB rs1,rs2, imm|
||Store Halfword|S|SH rs1,rs2,imm|
||Store Word|S|SH rs1,rs2,imm|
|Shifts|Shift Left|R|SLL rd,rs1,rs2|
||Shift Left Immediate|I|SLLI rd,rs1,shamt|
||Shift Right|R|SRL rd,rs1,rs2|
||Shift Right Immediate|I|SRLI rd,rs1,shamt|
||Shift Right Arithmetic|R|SRA rd,rs1,rs2|
||Shift Right Arth Imm|I|SRAI rd,rs1,shamt|
|Arithmetic|Add|R|ADD rd,rs1,rs2|
||Add Immediate|I|ADDI rd,rs1,imm|
||SUBtract|R|SUB rd,rs1,rs2|
||Load Upper Imm|U|LUI rd,imm|
||Add Upper Imm to PC|U|AUIPC rd,imm|
|Logical|XOR|R|XOR rd,rs1,rs2|
||XOR Immediate|I|XORI rd,rs1,imm|
||OR|R|OR rd,rs1,rs2|
||OR Immediate|I|ORI rd,rs1,imm|
||AND|R|AND rd,rs1,rs2|
||AND Immediate|I|ANDI rd,rs1,imm|
|Compare| Set <|R|SLT rd,rs1,rs2|
||Set < Immediate|I|SLTI rd,rs1,imm|
||Set < Unsigned|R|SLTU rd,rs1,rs2|
||Set < Imm Unsigned|I|SLTIU rd,rs1,imm|
|Branches|Branch =|SB|BEQ rs1,rs2,imm|
||Branch ≠|SB|BNE rs1,rs2,imm|
||Branch <|SB|BLT rs1,rs2,imm|
||Branch ≥|SB|BGE rs1,rs2,imm|
||Branch < Unsigned|SB|BLTU rs1,rs2,imm|
||Branch ≥ Unsigned|SB|BGEU rs1,rs2,imm|
|Jump & Link|J&L|UJ|JAL rd,imm|
||Jump & Link Register|UJ|JALR rd,rs1,imm|
|Synch|Synch thread|I|FENCE|
||Synch Instr & Data|I|FENCE.I|
|System|System CALL|I|SCALL|
||System BREAK|I|SBREAK|
|Counters|ReaD CYCLE|I|RDCYCLE rd|
||ReaD CYCLE upper Half|I|RDCYCLEH rd|
||ReaD TIME|I|RDTIME rd|
||ReaD TIME upper Half|I|RDTIMEH rd|
||ReaD INSTR RETired|I|RDINSTRET rd|
||ReaD INSTR upper Half|I|RDINSTRETH rd|

## Reference
[Jim's Dev Blog](https://tclin914.github.io/categories/RISC-V/)

[Free & Open RISC-V Reference card](https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf)
