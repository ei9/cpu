module Xor(out, a, b);

    output out;
    input a, b;
    wire w1, w2, w3, w4;

    Not not1(w1, a);
    Not not2(w2, b);
    And And1(w3, w1, b);
    And And2(w4, a, w2);
    Or or1(out, w3, w4);

endmodule

