`include "memory.v"

module PTD_test;

    reg clk;
    wire p;

    PTD g0(p, clk);

    initial begin
        clk = 0;
        $monitor("%4dns clk = %b, p = %b, ", $stime, clk, p);
        $dumpfile("PTD_test.vcd");
        $dumpvars(0, g0);
    end

    always #5 begin
        clk = clk + 1;
    end

    initial #50 $finish;

endmodule  // Testing Palse Transition Detector.
