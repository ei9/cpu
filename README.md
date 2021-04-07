# CPU

> Click [here](https://github.com/ei9/cheat_sheet#project) for more cpu i made before.

## 教學用微算機, SAP2 mini
This is a  simple Von Neumann architecture cpu. It includes:

- [28 instructions](#instructions).

- 256 x 12 RAM. More memory for programming.

## Compile & Test:
```
iverilog -o tb_sap2_mini.o tb_sap2_mini.v
vvp tb_sap2_mini.o
gtkwave tb_sap2_mini.vcd
```

## Instructions

Symbols:
- A: Accumulator.
- B: B register.
- M: RAM.
- X: Pointer register.
- O: Output port.

| Instruction | Opcode | Meaning | Example | Machine cycle |
| :----: | :----: | :---- | :---- | :----: |
| LDA | 0000 [8 bit addr] | A <- M | LDA A5H | 6T |
| ADD | 0001 [8 bit addr] | A <- A+B | ADD A5H | 6T |
| SUB | 0010 [8 bit addr] | A <- A-B | SUB A5H | 6T |
| STA | 0011 [8 bit addr] | M <- A | STA A5H | 6T |
| LDB | 0100 [8 bit addr] | B <- M | LDB A5H | 6T |
| LDX | 0101 [8 bit addr] | X <- M | LDX A5H | 6T |
| JMP | 0110 [8 bit addr] | To certain position. | JMP A5H | 6T |
| JAN | 0111 [8 bit addr] | Jump if A < 0 | JAN A5H | 6T |
| JAZ | 1000 [8 bit addr] | Jump if A == 0 | JAZ A5H | 6T |
| JIN | 1001 [8 bit addr] | Jump if X < 0 | JIN A5H | 6T |
| JIZ | 1010 [8 bit addr] | Jump if X == 0 | JIZ A5H | 6T |
| JMS | 1011 [8 bit addr] | Jump to subroutine | JMS A5H | 6T |
| NOP | 1111_0000 [4 bit x] | Nothing | NOP | 6T |
| CLA | 1111_0001 [4 bit x] | A <- 0 | CLA | 6T |
| XCH | 1111_0010 [4 bit x] | A <-> X | XCH | 6T |
| DEX | 1111_0011 [4 bit x] | X <- X-1 | DEX | 6T |
| INX | 1111_0100 [4 bit x] | X <- X+1 | INX | 6T |
| CMA | 1111_0101 [4 bit x] | A <- ~A | CMA | 6T |
| CMB | 1111_0110 [4 bit x] | B <- ~B | CMB | 6T |
| IOR | 1111_0111 [4 bit x] | A <- A\|B | IOR | 6T |
| AND | 1111_1000 [4 bit x] | A <- A&B | AND | 6T |
| NOR | 1111_1001 [4 bit x] | A <- ~(A\|B) | NOR | 6T |
| NAN | 1111_1010 [4 bit x] | A <- ~(A&B) | NAN | 6T |
| XOR | 1111_1011 [4 bit x] | A <- A^B | XOR | 6T |
| BRB | 1111_1100 [4 bit x] | Subroutine back to main program. | BRB | 6T |
| INP | 1111_1101 [4 bit x] | A <- External data | INP | 6T |
| OUT | 1111_1110 [4 bit x] | O <- A | OUT | 6T |
| HLT | 1111_1111 [4 bit x] | Stop cpu clock. | HLT | 6T |
