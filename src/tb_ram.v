`include "rv32i.v"

module tb_ram;
    reg clk, r, w;
    reg[31:0] a, in;
    wire[31:0] out;

    ram m(out, clk, r, w, a, in);

    initial begin
        $monitor("%2d clk=%b r=%b w=%b addr=%h in=%h out=%h", $time, clk, r, w, a, in, out);
        clk = 0;
        r = 1;
        w = 1;
        a = 0;
        in = 1;

        #5 r = 0;
        #5 w = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        a = a + 1;
        in = in + 1;
    end

    initial #12 $finish;
endmodule  // tb_ram