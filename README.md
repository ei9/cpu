# CPU

> Click [here](https://github.com/ei9/cheat_sheet#project) for more mini processor i made before.

Passed rv32ui unit tests from [riscv-tests](https://github.com/riscv-software-src/riscv-tests) repository.

Implements some of the RISC-V RV32I instruction set. Except:

## Not implemented instructions
- fence, fence.i
- ecall, ebreak
- csxxx

## Reference
[Jim's Dev Blog](https://tclin914.github.io/categories/RISC-V/)

[Free & Open RISC-V Reference card](https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf)

Thanks to [georgeyhere/Toast-RV32i](https://github.com/georgeyhere/Toast-RV32i).
I learned a lot about how to do [riscv-tests](https://github.com/riscv-software-src/riscv-tests) from it's Makefile and scripts. I modified the [script](./script/memgen.sh) to make it able to build hex file using riscv64-unknown-elf for rv32i.
