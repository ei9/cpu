`include "memory.v"

module RAM8_test;

    reg clk, load;
    reg[2:0] address;
    reg[15:0] in;
    wire[15:0] out;

    RAM8 m0(out, clk, load, address, in);

    initial begin
        $dumpfile("RAM8_test.vcd");
        $dumpvars(0, m0);
        $monitor("%4dns clk = %b, load = %b, address = %d in = %x, out = %x", $stime, clk, load, address, in, out);

        clk = 0;
        load = 1;
        address = 0;
        in = 0;
    end

    always #5 begin
        clk = ~clk;
    end

    always #20 begin
        address = address + 1;
    end

    always #40 begin
        in = in + 1;
    end

    always #200 begin
        load = load + 1;
    end

    initial #500 $finish;

endmodule  // RAM8_test
