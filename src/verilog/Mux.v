module Mux(out, sel, a, b);

    output out;
    input sel, a, b;
    wire w1, w2, w3;

    Not not1(w1, sel);
    nand nand1(w2, a, w1);
    nand nand2(w3, b, sel);
    nand nand3(out, w2, w3);

endmodule

