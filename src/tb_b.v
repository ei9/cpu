`include "sap2_mini.v"

module tb_b;
    reg lb, clk;
    reg[11:0] in;
    wire[11:0] out;
    b m(out, lb,clk, in);

    initial begin
        $monitor("%2dns clk=%b in=%d lb=%b out=%d", $stime, clk, in, lb, out);
        clk = 0;
        lb = 0;
        in = 0;
        
        #4 lb = 1;
        #4 lb = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
    end

    initial #10 $finish;
endmodule  // B register test bench.
