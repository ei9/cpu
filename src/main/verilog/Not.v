module Not(out, in);

    input in;
    output out;

    nand nand1(out, in, in);

endmodule
