`include "memory.v"

module tb_PC;
    reg clk, inc, load, reset;
    reg[15:0] in;
    wire[15:0] out;

    PC pc(out, clk, inc, load, reset, in);

    initial begin
        $dumpfile("tb_PC.vcd");
        $dumpvars(0, pc);
        $monitor("%4dns reset = %b, load = %b, inc = %b, in = %d, clk = %b, out = %d", $stime, reset, load, inc, in, clk, out);

        clk = 0;
        inc = 1;
        load = 1;
        reset = 0;
        in = 25;

        #2 load = 0;
        #22 in = 527; load = 0; inc = 0;
        #23 reset = 1;
        #24 reset = 0;
        #25 inc = 1;
        #29 load = 1;
        #30 load = 0;
        #33 inc = 0;
        #35 $finish;
    end

    always #1 begin
        clk = ~clk;
    end
endmodule  // tb_PC.
