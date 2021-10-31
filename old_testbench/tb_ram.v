`include "rv32i.v"

module tb_ram;
    reg         clk, write;
    reg  [31:0] addr, data;
    wire [31:0] out;

    ram m(out, clk, write, addr, data);

    initial begin
        $monitor("%2d clk=%b w=%b addr=%h in=%h out=%h", $time, clk, write, addr, data, out);
        clk   = 0;
        write = 1;
        addr  = 0;
        data  = 1;

        #5 write = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        addr = addr + 1;
        data = data + 1;
    end

    initial #10 $finish;
endmodule  // tb_ram