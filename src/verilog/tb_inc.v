`include "alu.v"

module tb_inc;
    reg[15:0] in;
    wire[15:0] out;

    Inc16 g(out, in);

    initial begin
        $dumpfile("tb_inc.vcd");
        $dumpvars(0, g);
        $monitor("%4dns in = %h, out16 = %h", $stime, in, out);

        in = 16'hffff;
    end

    always #1 begin
        in = in << 4;
    end

    initial #16 $finish;
endmodule  // tb_inc.
