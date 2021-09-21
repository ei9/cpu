`include "rv32i.v"

module tb_rom;
    reg[31:0] a;
    wire[31:0] out;

    rom m(out, a);

    initial begin
        $monitor("%2d a=%h out=%h", $time, a, out);
        $readmemh("rom.dat", m.m);
        a = 0;
    end

    always #1 a = a + 4;

    initial #5 $finish;
endmodule  // tb_rom