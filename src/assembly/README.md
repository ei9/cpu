## Machine Language

* [Registers](#registers)
* [The A-Instruction](#the-a-instruction)
* [The C-Instruction](#the-c-instruction)

### Registers

* **D register** : store data values.

* **A register** : store data and memory address.

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

```
     |          comp         |   dest   |  jump  |
1 1 1 a   c1 c2 c3 c4   c5 c6 d1 d2   d3 j1 j2 j3
```
