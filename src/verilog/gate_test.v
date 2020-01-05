`include "gate.v"

module gate_test;

    reg[7:0] in;
    wire aNot, abAnd, abOr, abXor, or8Way;

    Not    g0(aNot,   in[0]);
    And    g1(abAnd,  in[1], in[0]);
    Or     g2(abOr,   in[1], in[0]);
    Xor    g3(abXor,  in[1], in[0]);
    Or8Way g4(or8Way, in);

    initial begin
        $dumpfile("gate_test.vcd");
        $dumpvars(0, g0, g1, g2, g3, g4);
        $monitor("%4dns in = %d, aNot = %b, abAnd = %b, abOr = %b, abXor = %b, or8Way = %b", $stime, in, aNot, abAnd, abOr, abXor, or8Way);

        in = 8'b1111_1111;
    end

    always #1 begin
        in = in + 1;
    end

    initial #9 $finish;


endmodule
