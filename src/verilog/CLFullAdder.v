// 1-bit full adder for carry-lookahead adder.
module CLFullAdder(sum, p, g, a, b, cin);

    output sum, p, g;
    input a, b, cin;
    wire g0_out;

    Xor g0(g0_out, a, b);
    Xor g1(sum, g0_out, cin);
    And g2(g, a, b);
    Or g3(p, a, b);

endmodule

