`include "ram.v"

module DFF_test;

    reg clk, d;
    wire q, qbar;

    DFF g0(q, qbar, clk, d);

    initial begin
        $dumpfile("DFF_test.vcd");
        $dumpvars(0, g0);
        $monitor("%4dns clk = %b, d = %b, q = %b, qbar = %b", $stime, clk, d, q, qbar);

        clk = 0;
        d = 0;
    end

    always #5 begin
        clk = ~clk;
    end

    always #10 begin
        d = d + 1;
    end

    initial #100 $finish;

endmodule
