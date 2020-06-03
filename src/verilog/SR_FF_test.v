`include "memory.v"

module SR_FF_test;

    reg clk, s, r;
    wire q, qbar;

    SR_FF g0(q, qbar, clk, s, r);

    initial begin
        $dumpfile("SR_FF_test.vcd");
        $dumpvars(0, g0);
        $monitor("%4dns clk = %b, r = %b, s = %b, q = %b, qbar = %b", $stime, clk, r, s, q, qbar);

        clk = 0;
        s = 0;
        r = 0;
    end

    always #5 begin
        clk = ~clk;
    end

    always #10 begin
        s = 1; r = 0;
        #10;
        s = 0; r = 0;
        #10;
        s = 0; r = 1;
        #10;
    end

    initial #120 $finish;

endmodule
