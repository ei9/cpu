`include "rv32i.v"

module tb_rv32i;

    reg         reset;
    reg         clk;

    wire [31:0] out;              // simulation output
    assign out = cpu.rf.regs[1];  // x1 as output

    // instruction memory
    wire [31:0] ins, pc;

    // data memory
    wire [31:0] dmem_addr;
    wire [31:0] dmem_in;
    wire        dmem_w_en;
    wire [31:0] dmem_out;

    rom imem(
        .out           (ins       ),
        .address       (pc        )
    );

    rv32i cpu(
        .dmem_addr_o   (dmem_addr ),
        .dmem_r_data_i (dmem_out  ),
        .dmem_w_o      (dmem_w_en ),
        .dmem_w_data_o (dmem_in   ),
        .reset         (reset     ),
        .clk           (clk       ),
        .imem_addr_o   (pc        ),
        .imem_r_data_i (ins       )
    );

    ram dmem(
        .out           (dmem_out  ),
        .clk           (clk       ),
        .write         (dmem_w_en ),
        .address       (dmem_addr ),
        .in            (dmem_in   )
    );

    initial begin
        $dumpfile ("./tb_rv32i.vcd");
        $dumpvars (0, imem, cpu, dmem, out);
        $monitor  ("%2d reset=%b clk=%b ctrl=%h pc=%h x1=%h m[4]=%h", $time, reset, clk, cpu.ctrl, pc, out, dmem.m[4]);
        $readmemb ("program.dat", imem.m);  // Load program to rom.
        $readmemh ("reg.dat", cpu.rf.regs);   // Load data to register file.
        $readmemh ("ram.dat", dmem.m);      // Load data to ram.

        reset = 0;
        clk = 0;
        #4 reset = 1;
        #4 reset = 0;
    end

    always #1 clk = ~clk;

    initial #90 $finish;
endmodule  // tb_rv32i