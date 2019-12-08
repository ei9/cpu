module Mux(out, sel, a, b);

    output out;
    input sel, a, b;
    wire w0, w1, w2;

    Not not0(w0, sel);
    nand nand0(w1, a, w0);
    nand nand1(w2, b, sel);
    nand nand2(out, w1, w2);

endmodule

