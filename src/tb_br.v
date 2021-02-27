`include "sap1.v"

module tb_br;
    reg clk, lb;
    reg[7:0] in;
    wire[7:0] out;
    br m(out, clk, lb, in);

    initial begin
        $monitor("%4dns clk=%b lb=%b in=%d out=%d", $stime, clk, lb, in, out);
        clk = 0;
        lb = 0;
        in = 0;
        #10 lb = 1;
        #10 lb = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
    end

    initial #32 $finish;
endmodule  // tb_br
