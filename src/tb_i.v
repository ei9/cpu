`include "sap2_mini.v"

module tb_i;
    reg ln, clk, en;
    reg[11:0] in;
    wire[11:0] out;

    i m(out, ln, clk, en, in);

    initial begin
        $monitor("%2dns clk=%b ln=%b en=%b in=%d out=%d", $stime, clk, ln, en, in, out);
        clk = 0;
        ln = 0;
        en = 0;
        in = 0;

        #4 en = 1;
        #4 ln = 1; en = 0;
        #4 en = 1;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
    end

    initial #16 $finish;
endmodule  // tb_i.