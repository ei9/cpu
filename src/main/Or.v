module Or(out, a, b);

    output out;
    input a, b;
    wire w1, w2;

    Not(w1, a);
    Not(w2, b);
    nand nand1(w1, w2);

endmodule
