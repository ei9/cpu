## Hardware

* [Compile & Test](#compile--test)
* [Verilog](#verilog)

***

## compile & test
> Learn more about iverilog. Click [here (zh-TW)](https://sites.google.com/site/verilog710/xiang-guan-gong-ju/icarus-verilog).

```
iverilog -o sample_test.vvp sample_test.v  # Generate sample.vvp
vvp sample_test.vvp                        # Execute.
```


***
## Verilog

Under "src/verilog" directory.

### gate (Not, And, Or, Xor, Or8Way)

```
iverilog -o gate_test.vvp gate_test.v  # Generate gate_test.vvp
vvp gate_test.vvp                      # Execute.
iverilog gate_test.v                   # Generate gate_test.vcd
gtkwave gate_test.vcd                  # See graphical wave output.
```


### gate16

```
iverilog -o gate16_test.vvp gate16_test.v
vvp gate16_test.vvp
iverilog gate16_test.v
gtkwave gate16_test.vcd
```


### Multiplexor
> Reference from [ccckmit](https://github.com/ccckmit/nand2tetris_verilog/blob/master/mux_test.v)

```
iverilog -o mux_test.vvp mux_test.v
vvp mux_test.vvp
iverilog mux_test.v
gtkwave mux_test.vcd
```


### Demultiplexor
```
iverilog -o dmux_test.vvp dmux_test.v
vvp dmux_test.vvp
iverilog dmux_test.v
gtkwave dmux_test.vcd
```


### Incrementor (16-bit and 64-bit)

```
iverilog -o inc_test.vvp inc_test.v
vvp inc_test.vvp
iverilog inc_test.v
gtkwave inc_test.vcd
```


### ALU (16-bit)

```
iverilog -o alu_test.vvp alu_test.v
vvp alu_test.vvp
iverilog alu_test.v
gtkwave alu_test.vcd
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
iverilog -o Bit_test.vvp Bit_test.v
vvp Bit_test.vvp
iverilog Bit_test.v
gtkwave Bit_test.vcd
```


### Register
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o Register_test.vvp Register_test.v
vvp Register_test.vvp
iverilog Register_test.v
gtkwave Register_test.vcd
```


### RAM8
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o RAM8_test.vvp RAM8_test.v
vvp RAM8_test.vvp
iverilog RAM8_test.v
gtkwave RAM8_test.vcd
```


### RAM64
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o RAM64_test.vvp RAM64_test.v
vvp RAM64_test.vvp
iverilog RAM64_test.v
gtkwave RAM64_test.vcd
```


### RAM512
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o RAM512_test.vvp RAM512_test.v
vvp RAM512_test.vvp
iverilog RAM512_test.v
gtkwave RAM512_test.vcd
```


### RAM4K
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v),
  [chipverify.com](https://www.chipverify.com/verilog/verilog-arrays-memories),
  [stackoverflow.com](https://stackoverflow.com/questions/21311597/verilog-notation).

```
iverilog -o RAM4K_test.vvp RAM4K_test.v
vvp RAM4K_test.vvp
iverilog RAM4K_test.v
gtkwave RAM4K_test.vcd
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
**!! Warning !!** I am still working on it. So it's still buggy.
> Reference from [cccbook](https://github.com/cccbook/co/tree/1c86da267d19d5e2ec1b5e2dfcb6f53cac2cf74e/code/verilog/nand2tetris)

```
iverilog -o tb_Computer.vvp tb_Computer.v
vvp tb_Computer.vvp
```
