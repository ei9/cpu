## Hardware

Here are some shortcut to test the chip component.

* [Compile & Test](#compile--test)
* [gate16](#gate16)
* [Multiplexor](#multiplexor)
* [Demultiplexor](#demultiplexor)
* [Incrementor (16-bit)](#incrementor-16-bit)
* [ALU (16-bit)](#alu-16-bit)
* [Register](#register)
* [RAM8K](#ram8k)
* [RAM16K](#ram16k)
* [PC (counter)](#pc-counter)
* [CPU (Central Processing Unit)](#cpu-central-processing-unit)
* [Memory](#memory)
* [ROM32K](#rom32k)
* [Computer](#computer)

***

## Compile & Test
> Learn more about iverilog. Click [here (zh-TW)](https://sites.google.com/site/verilog710/xiang-guan-gong-ju/icarus-verilog).

```
iverilog -o tb_sample.vvp tb_sample.v  # Generate tb_sample.vvp
vvp tb_sample.vvp                      # Execute.
iverilog tb_sample.v                   # Generate tb_sample.vcd
gtkwave tb_sample.vcd                  # See graphical wave output.
```


***
## Verilog

Under "src/verilog" directory.


### gate16

```
iverilog -o tb_gate16.vvp tb_gate16.v
vvp tb_gate16.vvp
gtkwave tb_gate16.vcd
```


### Multiplexor
> Reference from [ccckmit](https://github.com/ccckmit/nand2tetris_verilog/blob/master/mux_test.v)

```
iverilog -o tb_mux.vvp tb_mux.v
vvp tb_mux.vvp
gtkwave tb_mux.vcd
```


### Demultiplexor
```
iverilog -o tb_dmux.vvp tb_dmux.v
vvp tb_dmux.vvp
gtkwave tb_dmux.vcd
```


### Incrementor (16-bit)

```
iverilog -o tb_inc.vvp tb_inc.v
vvp tb_inc.vvp
gtkwave tb_inc.vcd
```


### ALU (16-bit)

```
iverilog -o tb_alu.vvp tb_alu.v
vvp tb_alu.vvp
gtkwave tb_alu.vcd
```


### Register
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v).

```
iverilog -o tb_Register.vvp tb_Register.v
vvp tb_Register.vvp
gtkwave tb_Register.vcd
```


### RAM8K
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v),
  [chipverify.com](https://www.chipverify.com/verilog/verilog-arrays-memories),
  [stackoverflow.com](https://stackoverflow.com/questions/21311597/verilog-notation).

```
iverilog -o tb_RAM8K.vvp tb_RAM8K.v
vvp tb_RAM8K.vvp
gtkwave tb_RAM8K.vcd
```


### RAM16K
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v),
  [chipverify.com](https://www.chipverify.com/verilog/verilog-arrays-memories),
  [stackoverflow.com](https://stackoverflow.com/questions/21311597/verilog-notation).

```
iverilog -o tb_RAM16K.vvp tb_RAM16K.v
vvp tb_RAM16K.vvp
gtkwave tb_RAM16K.vcd
```


### PC (counter)
> Reference from [cccbook](https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/memory.v),
  [chipverify.com](https://www.chipverify.com/verilog/verilog-if-else-if)

```
iverilog -o tb_PC.vvp tb_PC.v
vvp tb_PC.vvp
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
