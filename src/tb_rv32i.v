`include "rv32i.v"

module tb_rv32i;
    reg clk;
    wire[31:0] out;
    assign out = m.rf.regs[1];  // x1 as output

    rv32i m(clk);

    initial begin
        $dumpfile("./tb_rv32i.vcd");
        $dumpvars(0, m, out);
        $monitor("%2d clk=%b ctrl=%h out=%h", $time, clk, m.ctrl, out);
        $readmemb("program.dat", m.im.m);     // Load program to rom.
        $readmemh("reg.dat", m.rf.regs);  // Load data to register file.
        m.pc = 32'b0;
        clk = 0;
    end

    always #1 clk = ~clk;

    initial #10 $finish;
endmodule  // tb_rv32i