module Xor(out, a, b);

    output out;
    input a, b;
    wire w1, w2, w3;

    nand nand1(w1, a, b);
    nand nand2(w2, a, w1);
    nand nand3(w3, w1, b);
    nand nand4(out, w2, w3);

endmodule

