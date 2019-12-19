module HalfAdder(sum, carry, a, b);

    output sum, carry;
    input a, b;
    wire w0, w1, w2;

    nand nand0(w0, a, b);
    nand nand1(w1, a, w0);
    nand nand2(w2, w0, b);
    nand nand3(sum, w1, w2);
    Not not0(carry, w0);

endmodule

