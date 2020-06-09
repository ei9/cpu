`include "gate.v"

module tb_gate;
    reg[7:0] in;
    wire or8Way;

    Or8Way g(or8Way, in);

    initial begin
        $dumpfile("tb_gate.vcd");
        $dumpvars(0, g);
        $monitor("%4dns in=%d or8Way=%b", $stime, in, or8Way);

        in = 8'b1111_1111;
    end

    always #1 begin
        in = in + 1;
    end

    initial #9 $finish;
endmodule  // tb_gate.
