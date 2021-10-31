# This file is modified from:
# https://github.com/georgeyhere/Toast-RV32i/blob/main/Makefile

RISCV_PREFIX = /opt/riscv

SHELL := /bin/bash
IVERILOG = iverilog
VVP = vvp

TOOL_PREFIX = $(RISCV_PREFIX)/bin/riscv64-unknown-elf-
PATH:=$(PATH):$(RISCV_PREFIX)

WORKSPACE = $(shell pwd)

CPU_MODULES = $(shell ls $(WORKSPACE)/rtl/*.v)

CPU_TESTBENCH = $(WORKSPACE)/testbench.v
RISCV_MEMS = $(shell ls $(WORKSPACE)/mem/hex/*.hex)

IVERILOG_FLAGS += -Wall

alltests:  testbench.vvp
	@echo "==========================================================="
	@echo "Running testbench.vvp with all riscv-tests."
	$(VVP) -N $< $(RISCV_MEMS) -I$(WORKSPACE)/mem/hex +runall
	@echo ""
	@echo ""

alltests_vcd: testbench.vvp
	@echo "==========================================================="
	@echo "Running testbench.vvp with all riscv-tests and vcd output."
	$(VVP) -N $< $(RISCV_MEMS) -I$(WORKSPACE)/mem/hex +runall +vcd
	@echo ""
	@echo ""

testbench.vvp:  gen_mem
	@echo "==========================================================="
	@echo "Generating testbench.vvp"
	$(IVERILOG) $(IVERILOG_FLAGS) -o  $@ $(CPU_MODULES) $(CPU_TESTBENCH) \
		-I$(WORKSPACE)/rtl -I$(WORKSPACE)/mem/hex
	@echo ""
	@echo ""


gen_mem:
	@echo "==========================================================="
	@echo "Compiling, linking, and generate mem files for riscv-tests."
	@echo "Memory files will be placed into /mem/"
	@echo "Dump files will be placed into /mem/dump"
	chmod +x ./script/memgen.sh
	source ./script/memgen.sh
	@echo ""
	@echo ""
