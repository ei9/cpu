`include "gate.v"

module gate_test;

    reg a, b;
    wire aNot, abAnd, abOr, abXor;

    Not g0(aNot,  a);
    And g1(abAnd, a, b);
    Or  g2(abOr,  a, b);
    Xor g3(abXor, a, b);

    initial
        begin
            $dumpfile("gate_test.vcd");
            $dumpvars(0, g0, g1, g2, g3);
            $monitor("a = %b, b = %b, aNot = %b, abAnd = %b, abOr = %b, abXor = %b", a, b, aNot, abAnd, abOr, abXor);

            #1 a = 1'b0; b = 1'b0;
            #1 a = 1'b0; b = 1'b1;
            #1 a = 1'b1; b = 1'b0;
            #1 a = 1'b1; b = 1'b1;
            #1 $finish;
        end

endmodule
