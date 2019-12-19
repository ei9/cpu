module HalfAdder(sum, carry, a, b);

    output sum, carry;
    input a, b;

    Xor g0(sum, a, b);
    And g1(carry, a, b);

endmodule

