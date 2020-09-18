Hardware is written in Verilog. If you want to learn more about iverilog. Click [here (zh-TW)](https://sites.google.com/site/verilog710/xiang-guan-gong-ju/icarus-verilog). About how I made my implementation. You can go to [cccbook](https://github.com/cccbook/co/tree/1c86da267d19d5e2ec1b5e2dfcb6f53cac2cf74e/code/verilog/nand2tetris).

Compile & Test:

```
iverilog -o tb_sample.o tb_sample.v  # Generate tb_sample.o
vvp tb_sample.o                      # See the test bench result.
iverilog tb_sample.v                 # Generate tb_sample.vcd
gtkwave tb_sample.vcd                # See the graphical result.
```

Under "src/verilog" directory:

```
iverilog -o tb_Computer.o tb_Computer.v
vvp tb_Computer.o
```
