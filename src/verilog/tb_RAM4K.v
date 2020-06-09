`include "memory.v"

module tb_RAM4K;
    reg clk, load;
    reg[11:0] address;
    reg[15:0] in;
    wire[15:0] out;

    RAM4K m(out, clk, load, address, in);

    initial begin
        $dumpfile("tb_RAM4K.vcd");
        $dumpvars(0, m);
        $monitor("%4dns clk = %b, load = %b, address = %d in = %x, out = %x", $stime, clk, load, address, in, out);

        clk = 0;
        load = 1;
        address = 0;
        in = 0;
    end

    always #5 begin
        clk = ~clk;
    end

    always #10 begin
        address = address + 1;
        address = address % 20;
    end

    always #20 begin
        in = in + 1;
    end

    always #100 begin
        load = load + 1;
    end

    initial #250 $finish;
endmodule  // tb_RAM4K.