module Not(out, in);

    input in;
    output out;

    nand nand0(out, in, in);

endmodule

