module Or(out, a, b);

    output out;
    input a, b;
    wire w0, w1;

    Not not0(w0, a);
    Not not1(w1, b);
    nand nand0(out, w0, w1);

endmodule

