`include "sap1.v"

module tb_pc;
    reg clk, clr, cp, ep;
    wire[3:0] out;
    pc m(out, clk, clr, cp, ep);

    initial begin
        $monitor("%4dns clk=%d clr=%d cp=%d ep=%d pc=%d ", $stime, clk, clr, cp, ep, out);
        clk = 0;
        clr = 0;
        cp = 0;
        ep = 0;
        #10 ep = 1;
        #10 clr = 1;
        #10 clr = 0;
        #10 cp = 1;
        #10 cp = 0;
        #10 clr = 1;
    end

    always #1 begin
        clk = ~clk;
    end

    initial #64 $finish;
endmodule  // tb_pc.
