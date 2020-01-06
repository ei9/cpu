`include "alu.v"

module Inc16_test;

    reg[15:0] in;
    wire[15:0] out;

    Inc16 g(out, in);

    initial begin
        $dumpfile("Inc16_test.vcd");
        $dumpvars(0, g);
        $monitor("%4dns in = %h, out = %h", $stime, in, out);

        in = 16'h1;
    end

    always #1 begin
        in = in << 1;
    end

    initial #16 $finish;

endmodule
