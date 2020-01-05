// Reference : https://github.com/ccckmit/nand2tetris_verilog/blob/master/mux_test.v

`include "mux.v"

module Mux_test;

    reg[15:0] a, b, c, d, e, f, g, h;
    reg[2:0] sel;
    wire[15:0] mux2, mux4, mux8;
    wire mux0;

    Mux       g0(mux0, sel[2], 1'b0 , 1'b1);
    Mux16     g1(mux2, sel[0], a, b);
    Mux4Way16 g2(mux4, sel[1:0], a, b, c, d);
    Mux8Way16 g3(mux8, sel[2:0], a, b, c, d, e, f, g, h);

    initial begin
        $dumpfile("mux_test.vcd");
        $dumpvars(0, g0, g1, g2, g3);
        $monitor("%4dns sel = %d, mux0 = %x, mux2 = %x, mux4 = %x, mux8 = %x", $stime, sel, mux0, mux2, mux4, mux8);

        a = 16'h0000;
        b = 16'h1111;
        c = 16'h2222;
        d = 16'h3333;
        e = 16'h4444;
        f = 16'h5555;
        g = 16'h6666;
        h = 16'h7777;
        sel = 0;
    end

    always #1 begin
        sel = sel + 1;
    end

    initial #10 $finish;

endmodule
