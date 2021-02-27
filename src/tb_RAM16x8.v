`include "sap1.v"

module tb_RAM16x8;
    reg clk, write, prog, ce;
    reg[3:0] a;
    reg[7:0] d;
    wire[7:0] out;
    RAM16x8 m(out, clk, write, prog, ce, a, d);

    initial begin
        $monitor("%4dns clk=%b write=%b prog=%b ce=%b a=%d d=%d out=%d", $stime, clk, write, prog, ce, a, d, out);
        clk = 0;
        write = 0;
        prog = 1;
        ce = 0;
        a = 0;
        d = 0;
        #10 prog = 0;
        #10 write = 1;
        #10 ce = 1;
        #10 prog = 0;
        #10 write = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        a = a + 1;
        d = d + 1;
    end

    initial #64 $finish;
endmodule // tb_RAM16x8
