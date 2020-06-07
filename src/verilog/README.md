## Hardware

* [Compile & Test](#compile--test)
* [Verilog](#verilog)

***

## compile & test
> Learn more about iverilog. Click [here (zh-TW)](https://sites.google.com/site/verilog710/xiang-guan-gong-ju/icarus-verilog).

```
iverilog -o tb_sample.vvp tb_sample.v  # Generate tb_sample.vvp
vvp tb_sample.vvp                      # Execute.
```


***
## Verilog

Under "src/verilog" directory.

### gate (Not, And, Or, Xor, Or8Way)

```
iverilog -o tb_gate.vvp tb_gate.v  # Generate tb_gate.vvp
vvp tb_gate.vvp                    # Execute.
iverilog tb_gate.v                 # Generate tb_gate.vcd
gtkwave tb_gate.vcd                # See graphical wave output.
```


### gate16

```
iverilog -o tb_gate16.vvp tb_gate16.v
vvp tb_gate16.vvp
iverilog tb_gate16.v
gtkwave tb_gate16.vcd
```


### Multiplexor
> Reference from [ccckmit](https://github.com/ccckmit/nand2tetris_verilog/blob/master/mux_test.v)

```
iverilog -o tb_mux.vvp tb_mux.v
vvp tb_mux.vvp
iverilog tb_mux.v
gtkwave tb_mux.vcd
```


### Demultiplexor
```
iverilog -o tb_dmux.vvp tb_dmux.v
vvp tb_dmux.vvp
iverilog tb_dmux.v
gtkwave tb_dmux.vcd
```


### Incrementor (16-bit and 64-bit)

```
iverilog -o tb_inc.vvp tb_inc.v
vvp tb_inc.vvp
iverilog tb_inc.v
gtkwave tb_inc.vcd
```


### ALU (16-bit)

```
iverilog -o tb_alu.vvp tb_alu.v
vvp tb_alu.vvp
iverilog tb_alu.v
gtkwave tb_alu.vcd
```


### DFF, Data Flip-Flip
> Reference: [cccbook](https://github.com/cccbook/co/blob/1c86da267d19d5e2ec1b5e2dfcb6f53cac2cf74e/code/verilog/nand2tetris/memory.v#L12)

```
iverilog -o tb_DFF.vvp tb_DFF.v
vvp tb_DFF.vvp
gtkwave tb_DFF.vcd
```


### 1-bit register
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o tb_Bit.vvp tb_Bit.v
vvp tb_Bit.vvp
iverilog tb_Bit.v
gtkwave tb_Bit.vcd
```


### Register
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o tb_Register.vvp tb_Register.v
vvp tb_Register.vvp
iverilog tb_Register.v
gtkwave tb_Register.vcd
```


### RAM8
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o tb_RAM8.vvp tb_RAM8.v
vvp tb_RAM8.vvp
iverilog tb_RAM8.v
gtkwave tb_RAM8.vcd
```


### RAM64
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o tb_RAM64.vvp tb_RAM64.v
vvp tb_RAM64.vvp
iverilog tb_RAM64.v
gtkwave tb_RAM64.vcd
```


### RAM512
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o tb_RAM512.vvp tb_RAM512.v
vvp tb_RAM512.vvp
iverilog tb_RAM512.v
gtkwave tb_RAM512.vcd
```


### RAM4K
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v),
  [chipverify.com](https://www.chipverify.com/verilog/verilog-arrays-memories),
  [stackoverflow.com](https://stackoverflow.com/questions/21311597/verilog-notation).

```
iverilog -o tb_RAM4K.vvp tb_RAM4K.v
vvp tb_RAM4K.vvp
iverilog tb_RAM4K.v
gtkwave tb_RAM4K.vcd
```


### RAM8K
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v),
  [chipverify.com](https://www.chipverify.com/verilog/verilog-arrays-memories),
  [stackoverflow.com](https://stackoverflow.com/questions/21311597/verilog-notation).

```
iverilog -o tb_RAM8K.vvp tb_RAM8K.v
vvp tb_RAM8K.vvp
iverilog tb_RAM8K.v
gtkwave tb_RAM8K.vcd
```


### RAM16K
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v),
  [chipverify.com](https://www.chipverify.com/verilog/verilog-arrays-memories),
  [stackoverflow.com](https://stackoverflow.com/questions/21311597/verilog-notation).

```
iverilog -o tb_RAM16K.vvp tb_RAM16K.v
vvp tb_RAM16K.vvp
iverilog tb_RAM16K.v
gtkwave tb_RAM16K.vcd
```


### PC (counter)
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v),
  [chipverify.com](https://www.chipverify.com/verilog/verilog-if-else-if)

```
iverilog -o tb_PC.vvp tb_PC.v
vvp tb_PC.vvp
iverilog tb_PC.v
gtkwave tb_PC.vcd
```


### CPU (Central Processing Unit)
> Reference from [cccbook](https://github.com/cccbook/co/blob/1c86da267d19d5e2ec1b5e2dfcb6f53cac2cf74e/code/verilog/nand2tetris/computer.v#L18)


### Memory
> Reference from [cccbook](https://github.com/cccbook/co/blob/1c86da267d19d5e2ec1b5e2dfcb6f53cac2cf74e/code/verilog/nand2tetris/computer.v#L3)


### ROM32K
> Reference from [cccbook](https://github.com/cccbook/co/blob/1c86da267d19d5e2ec1b5e2dfcb6f53cac2cf74e/code/verilog/nand2tetris/memory.v#L95)


### Computer
> Reference from [cccbook](https://github.com/cccbook/co/tree/1c86da267d19d5e2ec1b5e2dfcb6f53cac2cf74e/code/verilog/nand2tetris)

```
iverilog -o tb_Computer.vvp tb_Computer.v
vvp tb_Computer.vvp
```
