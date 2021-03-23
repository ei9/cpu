`include "sap2_mini.v"

module tb_ram256x12;
    reg clk, we, prog, ce;
    reg[7:0] a;
    reg[11:0] d;
    wire[11:0] out;
    ram256x12 m(out, clk, we, prog, ce, a, d);

    initial begin
        $monitor("%4dns clk=%b we=%b prog=%b ce=%b a=%d d=%d out=%d", $stime, clk, we, prog, ce, a, d, out);
        clk = 0;
        we = 0;
        prog = 1;
        ce = 0;
        a = 1;
        d = 1;

        #10 prog = 0;  we = 1;
        #10 ce = 1;
        #10 prog = 1;
        #10 we = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        a = a + 1;
        d = d + 1;
    end

    initial #48 $finish;
endmodule // tb_ram256x12.
