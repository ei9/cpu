`include "sap2_mini.v"

module tb_pc;
    reg lp,cp,clk,clr,ep;
    wire[7:0] bus;

    assign bus = lp ? 8'haa : 8'hzz;

    pc m(bus, lp,cp,clk,clr,ep);

    initial begin
        $monitor("%4dns clk=%d clr=%d cp=%d ep=%d lp=%b bus=%d ", $stime, clk, clr, cp, ep, lp, bus);
        clk = 0;
        clr = 0;
        cp = 0;
        ep = 0;
        lp = 0;

        // Count test.
        #10 ep = 1;  clr = 1;
        #10 clr = 0; cp = 1;
        #10 cp = 0; clr = 1;

        // Load test.
        #10 clr = 0;
        #10 lp = 1;
        #10 lp = 0;  cp = 1;
        #10 clr = 1;
    end

    always #1 begin
        clk = ~clk;
    end

    initial #80 $finish;
endmodule  // tb_pc.
