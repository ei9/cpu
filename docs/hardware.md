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


### Carry-lookahead adder
> Reference from [wikipedia (zh-TW)](https://zh.wikipedia.org/zh-tw/%E5%8A%A0%E6%B3%95%E5%99%A8).

```
iverilog -o cl_add_test.vvp cl_add_test.v
vvp cl_add_test.vvp
iverilog cl_add_test.v
gtkwave cl_add_test.vcd
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


### Carry-lookahead 16-bit ALU
```
iverilog -o cl_alu_test.vvp cl_alu_test.v
vvp cl_alu_test.vvp
iverilog cl_alu_test.v
gtkwave cl_alu_test.vcd
```


### SR latch
> Reference from [ccckmit](http://ccckmit.wikidot.com/ve:latch).

```
iverilog -o SR_latch_test.vvp SR_latch_test.v
vvp SR_latch_test.vvp
iverilog SR_latch_test.v
gtkwave SR_latch_test.vcd
```


### Pulse Transition Detector, PTD
> Reference from [programmermagazine(zh-TW)](https://programmermagazine.github.io/201311/htm/article4.html).

```
iverilog -o PTD_test.vvp PTD_test.v
vvp PTD_test.vvp
iverilog PTD_test.v
gtkwave PTD_test.vcd
```


### Latch with enable pin.
> Reference from [programmermagazine(zh-TW)](https://programmermagazine.github.io/201311/htm/article4.html).

```
iverilog -o en_latch_test.vvp en_latch_test.v
vvp en_latch_test.vvp
iverilog en_latch_test.v
gtkwave en_latch_test.vcd
```


### SR Flip-Flop
> Reference from [programmermagazine(zh-TW)](https://programmermagazine.github.io/201311/htm/article4.html).

```
iverilog -o SR_FF_test.vvp SR_FF_test.v
vvp SR_FF_test.vvp
iverilog SR_FF_test.v
gtkwave SR_FF_test.vcd
```


### DFF, D Flip-Flip

```
iverilog -o DFF_test.vvp DFF_test.v
vvp DFF_test.vvp
iverilog DFF_test.v
gtkwave DFF_test.vcd
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
