module Xor(out, a, b);

    output out;
    input a, b;
    wire w0, w1, w2;

    nand nand0(w0, a, b);
    nand nand1(w1, a, w0);
    nand nand2(w2, w0, b);
    nand nand3(out, w1, w2);

endmodule

