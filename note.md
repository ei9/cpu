# Notes

## compile & test
> Learn more about iverilog. Click [here (zh-TW)](!https://sites.google.com/site/verilog710/xiang-guan-gong-ju/icarus-verilog).

```
iverilog -o sample_test.vvp sample_test.v  # Generate sample.vvp
vvp sample_test.vvp                        # Execute.
```


***
## Testing

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
