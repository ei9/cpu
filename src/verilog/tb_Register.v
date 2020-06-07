`include "memory.v"

module tb_Register;

    reg clk, load;
    reg[15:0] in;
    wire[15:0] out;

    Register g0(out, clk, load, in);

    initial begin
        $dumpfile("tb_Register.vcd");
        $dumpvars(0, g0);
        $monitor("%4dns clk = %b, load = %b, in = %x, out = %x", $stime, clk, load, in, out);

        clk = 0;
        load = 0;
        in = 0;
    end

    always #5 begin
        clk = ~clk;
    end

    always #10 begin
        load = load + 1;
    end

    always #20 begin
        in = in + 1;
    end

    initial #100 $finish;

endmodule
