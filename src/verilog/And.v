module And(out, a, b);

    output out;
    input a, b;
    wire w;

    nand nand0(w, a, b);
    Not not0(out, w);

endmodule

