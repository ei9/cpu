module Or(out, a, b);

    output out;
    input a, b;
    wire w1, w2;

    Not not1(w1, a);
    Not not2(w2, b);
    nand nand1(out, w1, w2);

endmodule

