`include "sap2_mini.v"

module tb_sc;
    reg ls,cs,clk,es;
    wire[7:0] bus;

    assign bus = ls ? 8'haa : 8'hzz;

    sc m(bus, ls,cs,clk,es);

    initial begin
        $monitor("%4dns clk=%d cs=%d es=%d ls=%b bus=%d ", $stime, clk, cs, es, ls, bus);
        clk = 0;
        cs = 0;
        es = 0;
        ls = 0;

        // Load test.
        #10 es = 1;  ls = 1;
        #10 ls = 0;  cs = 1;
        #10 ls = 1;  cs = 0;
        #10 cs = 1;
    end

    always #1 begin
        clk = ~clk;
    end

    initial #64 $finish;
endmodule  // tb_sc.