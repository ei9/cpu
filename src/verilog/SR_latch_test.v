`include "ram.v"

module SR_latch_test;

    reg sbar, rbar;
    wire q, qbar;

    SR_latch g0(q, qbar, sbar, rbar);

    initial begin
        $dumpfile("SR_latch_test.vcd");
        $dumpvars(0, g0);

        sbar = 0;
        rbar = 0;
    end

    always #1 begin
        sbar = sbar + 1;
        $monitor("%4dns sbar = %b, rbar = %b, q = %b, qbar = %b", $stime, sbar, rbar, q, qbar);
    end

    always #2 begin
        rbar = rbar + 1;
    end

    initial #10 $finish;

endmodule  // SR_latch_test
