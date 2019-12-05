module And(out, a, b);

    output out;
    input a, b;
    wire w;

    nand nand1(w, a, b);
    Not not1(out, w);

endmodule
