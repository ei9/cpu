`include "sap2_mini.v"

module tb_output_port;
    reg lo, clk;
    reg[11:0] in;
    wire[11:0] out;
    output_port m(out, lo,clk, in);

    initial begin
        $monitor("%2dns clk=%b lo=%b in=%d out=%d", $stime, clk, lo, in, out);
        clk = 0;
        lo = 0;
        in = 0;
        #4 lo = 1;
        #4 lo = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
    end

    initial #10 $finish;
endmodule  // tb_output_port
