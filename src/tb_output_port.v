`include "sap1.v"

module tb_output_port;
    reg clk, lo;
    reg[7:0] in;
    wire[7:0] out;
    output_port m(out, clk, lo, in);

    initial begin
        $monitor("%4dns clk=%b lo=%b in=%d out=%d", $stime, clk, lo, in, out);
        clk = 0;
        lo = 0;
        in = 0;
        #10 lo = 1;
        #10 lo = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
    end

    initial #32 $finish;
endmodule  // tb_output_port
