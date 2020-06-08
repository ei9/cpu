## Machine Language

For more information, please refers to the chapter 4 of [nand2tetris](https://www.nand2tetris.org/course).

### Index

* [Registers](#registers)
* [The A-Instruction](#the-a-instruction)
* [The C-Instruction](#the-c-instruction)
* [Variables](#variables)
* [Label](#label)
* [Buit-in symbols](#built-in-symbols)
* [The Hack character set](#the-hack-character-set)

---


### Registers

* **D register** : store data values.

* **A register** : store data(value) and memory address.

* **M label** : refers to the ***memory word*** whose address is the current value of **A register**.


### The A-Instruction

* **@value** : Set **value** to **A register**.

* **Binary**
```
0vvv vvvv vvvv vvvv  // v = 0 or 1
0000 0000 0000 0101  // @5, A <- 5
```

**A register** is used to :
1. Enter a constant into the computer.
2. Set to a certain data memory loacation before C-instruction designed to manipulate it.
3. Loading the address of the jump destination before C-instruction specifies a jump.


### The C-Instruction

**It answers three questions:**

1. What to compute?
2. Where to store the computed value?
3. What to do next?

**C-Instruction**

```
[dest=]comp[;jump]
```

**Binary**

op-code | not used | comp | dest | jump
:---:|:---:|:---:|:---:|:---:
1 | 1 1 | a c1 c2 c3 c4 c5 c6 | d1 d2 d3 | j1 j2 j3


**comp**

a == 0 | a == 1 | c1 c2 c3 c4 c5 c6
:---:|:---:|:---:
0 | | 1 0 1 0 1 0
1 | | 1 1 1 1 1 1
-1 | | 1 1 1 0 1 0
D | | 0 0 1 1 0 0
A | M | 1 1 0 0 0 0
!D | | 0 0 1 1 0 1
!A | !M | 1 1 0 0 0 1
-D | | 0 0 1 1 1 1
-A | -M | 1 1 0 0 1 1
D+1 | | 0 1 1 1 1 1
A+1 | M+1 | 1 1 0 1 1 1
D-1 | | 0 0 1 1 1 0
A-1 | M-1 | 1 1 0 0 1 0
D+A | D+M | 0 0 0 0 1 0
D-A | D-M | 0 1 0 0 1 1
A-D | M-D | 0 0 0 1 1 1
D&A | D&M | 0 0 0 0 0 0
D\|A | D\|M | 0 1 0 1 0 1


**dest**

dest | d1 d2 d3 | effect: the value is stored in:
:---:|:---:|:---
null | 0 0 0 | The value is not stored
M | 0 0 1 | RAM[A]
D | 0 1 0 | D register
MD | 0 1 1 | RAM[A] and D register
A | 1 0 0 | A register
AM | 1 0 1 | A register and RAM[A]
AD | 1 1 0 | A register and D register
AMD | 1 1 1 | A register, RAM[A], and D register


**jump**

jump | j1 j2 j3 | effect
:---:|:---:|:---
null | 0 0 0 | no jump
JGT | 0 0 1 | if out>0 jump
JEQ | 0 1 0 | if out=0 jump
JGE | 0 1 1 | if out>=0 jump
JLT | 1 0 0 | if out<0 jump
JNE | 1 0 1 | if out!=0 jump
JLE | 1 1 0 | if out<=0 jump
JMP | 1 1 1 | unconditional jump

Examples:

```
MD=D+1
1110011111011000

M=1
1110111111001000

D+1;JLE
1110011111000110
```

### Variables

@*symbol* : declare a variable.

Example:

```
    @R0    // RAM[0]
    D=M
    @temp
    M=D    // temp = R1
```

### Label
**(LABEL)** : Points to the
index of next instruction.

Example:

```
(END)
    @END
    0;JMP  // Infinite loop.
```


### Built-in symbols

symbol | value
---:|---:
R0 | 0
R1 | 1
R2 | 2
... | ...
R15 | 15
SCREEN | 16384
KBD | 24576
SP | 0
LCL | 1
ARG | 2
THIS | 3
THAT | 4


### The Hack character set

key | code | key | code | key | code
---:|:---|---:|:---|---:|:---
(space) | 32 | 0 | 48 | A | 65
! | 33 | 1 | 49 | B | 66
" | 34 | ... | ... | C | ...
\# | 35 | 9 | 57 | ... | ...
$ | 36 | | | Z | 90
% | 37 | : | 58 | |
& | 38 | ; | 59 | [ | 91
' | 39 | < | 60 | / | 92
( | 40 | = | 61 | ] | 93
) | 41 | > | 62 | ^ | 94
\* | 42 | ? | 63 | _ | 95
\+ | 43 | @ | 64 | \` | 96
, | 44 | |
\- | 45 | |
. | 46 | |
/ | 47 | |

key | code | key | code
---:|:---|---:|:---
a | 97 | newline | 128
b | 98 | backspace | 129
c | 99 | left arrow | 130
... | ... | up arrow | 131
z | 122 | right arrow | 132
 | | down arrow | 133
{ | 123 | home | 134
\| | 124 | end | 135
} | 125 | Page up | 136
~ | 126 | Page down | 137
 | | insert | 138
 | | delete | 139
 | | esc | 140
 | | f1 | 141
 | | ... | ...
 | | f12 | 152
