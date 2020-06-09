`include "memory.v"

module tb_DFF;
    reg clk, in;
    wire out;

    DFF m(out, clk, in);

    initial begin
        $dumpfile("tb_DFF.vcd");
        $dumpvars(0, m);
        $monitor("%4dns clk = %b, in = %b, out = %b", $stime, clk, in, out);

        clk = 0;
        in = 0;
    end

    always #5 begin
        clk = ~clk;
    end

    always #10 begin
        in = in + 1;
    end

    initial #100 $finish;
endmodule  // tb_DFF.
