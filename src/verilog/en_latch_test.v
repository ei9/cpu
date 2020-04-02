`include "ram.v"

module en_latch_test;

    reg en, s, r;
    wire q, qbar;

    en_latch g0(q, qbar, en, s, r);

    initial begin
        $dumpfile("en_latch_test.vcd");
        $dumpvars(0, g0);
        $monitor("%4dns en = %b, r = %b, s = %b, q = %b, qbar = %b", $stime, en, r, s, q, qbar);
        en = 0;
        s = 0;
        r = 0;
    end

    always #1 begin
        s = s + 1;
    end

    always #2 begin
        r = r + 1;
    end

    always #8 begin
        en = en + 1;
    end

    initial #26 $finish;

endmodule  // en_latch_test
