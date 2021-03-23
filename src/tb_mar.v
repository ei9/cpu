`include "sap2_mini.v"

module tb_mar;
    reg clk, lm;
    reg[7:0] in;
    wire[7:0] out;

    mar m(out, lm, clk, in);

    initial begin
        $monitor("%4dns clk=%b lm=%b in=%d out=%d", $stime, clk, lm, in, out);
        clk = 0;
        lm = 0;
        in = 0;

        #8 lm = 1;
        #8 lm = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
    end

    initial #24 $finish;
endmodule  // tb_mar.
