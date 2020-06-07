`include "alu.v"

module inc_test;

    reg[63:0] in;
    wire[15:0] out16;
    wire[63:0] out64;

    Inc16 g0(out16, in[63:48]);

    initial begin
        $dumpfile("inc_test.vcd");
        $dumpvars(0, g0);
        $monitor("%4dns in = %h, out16 = %h", $stime, in, out16);

        in = 64'hffff;
    end

    always #1 begin
        in = in << 4;
    end

    initial #16 $finish;

endmodule
