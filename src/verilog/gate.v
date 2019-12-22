module Not(out, in);

    input in;
    output out;

    nand nand0(out, in, in);

endmodule


module And(out, a, b);

    output out;
    input a, b;
    wire w;

    nand nand0(w, a, b);
    Not not0(out, w);

endmodule


module Or(out, a, b);

    output out;
    input a, b;
    wire w0, w1;

    Not not0(w0, a);
    Not not1(w1, b);
    nand nand0(out, w0, w1);

endmodule


module Xor(out, a, b);

    output out;
    input a, b;
    wire w0, w1, w2;

    nand nand0(w0, a, b);
    nand nand1(w1, a, w0);
    nand nand2(w2, w0, b);
    nand nand3(out, w1, w2);

endmodule
