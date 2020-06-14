`include "memory.v"

module tb_PC;
    reg[15:0] in;
    reg load, inc, reset, clk;
    wire[15:0] out;

    PC pc(out, clk, inc, load, reset, in);

    initial begin
        clk = 0;
        $dumpfile("tb_PC.vcd");
        $dumpvars(0, pc);
        $monitor("%3dns clk=%d in=%2d reset=%d inc=%d load=%d out=%2d", $stime, clk, in, reset, inc, load, out);
        inc = 0;
        load = 0;
        reset = 0;
        in = 7;
        #10 reset = 1; inc = 1;
        #10 reset = 0;
        #10 reset = 0;
        #30 inc = 0; load=1;
        #30 load = 0; inc=1;
        #30	$finish;
    end

    always #1 begin
        clk = ~clk;
    end
endmodule
