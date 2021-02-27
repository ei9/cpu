`include "sap1.v"

module tb_input_and_mar;
    reg clk, lm, prog;
    reg[3:0] a, in;
    wire[3:0] out;
    input_and_mar m(out, clk, lm, prog, a, in);

    initial begin
        $monitor("%4dns clk=%b lm=%b in=%d a=%d prog=%b out=%d", $stime, clk, lm, in, a, prog, out);
        clk = 0;
        lm = 0;
        prog = 0;
        a = 0;
        in = 0;
        #10 prog = 1;
        #10 lm = 1;
        #10 prog = 0;
        #10 lm = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
        a = a + 2;
    end

    initial #64 $finish;
endmodule  // tb_input_and_mar
