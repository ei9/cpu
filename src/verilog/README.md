## Hardware

Here are some shortcut to test the chip component.

* [Compile & Test](#compile--test)
* [ALU (16-bit)](#alu-16-bit)
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


### ALU (16-bit)

```
iverilog -o tb_alu.vvp tb_alu.v
vvp tb_alu.vvp
gtkwave tb_alu.vcd
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
