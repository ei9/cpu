`include "memory.v"

module tb_Bit;
    reg clk, load, in;
    wire out;

    Bit g(out, clk, load, in);

    initial begin
        $dumpfile("tb_Bit.vcd");
        $dumpvars(0, g);
        $monitor("%4dns clk = %b, load = %b, in = %b, out = %b", $stime, clk, load, in, out);

        clk = 0;
        load = 0;
        in = 0;
    end

    always #5 begin
        clk = ~clk;
    end

    always #10 begin
        load = load + 1;
    end

    always #20 begin
        in = in + 1;
    end

    initial #100 $finish;
endmodule  // tb_Bit.
