`include "sap2_mini.v"

module tb_input_and_mar;
    reg clk, lm, prog;
    reg[7:0] a, in;
    wire[7:0] out;
    input_and_mar m(out, clk, lm, prog, a, in);

    initial begin
        $monitor("%2dns clk=%b lm=%b in=%d a=%d prog=%b out=%d", $stime, clk, lm, in, a, prog, out);
        clk = 0;
        lm = 0;
        prog = 0;
        a = 0;
        in = 0;
        #4 prog = 1;
        #4 lm = 1;
        #4 prog = 0;
        #4 lm = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
        a = a + 2;
    end

    initial #24 $finish;
endmodule  // tb_input_and_mar