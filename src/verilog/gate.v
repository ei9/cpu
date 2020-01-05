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


module Or8Way(out, in);

    output out;
    input[7:0] in;
    wire w[5:0];

    Or or0(w0, in[0], in[1]);
    Or or1(w1, in[2], in[3]);
    Or or2(w2, in[4], in[5]);
    Or or3(w3, in[6], in[7]);
    Or or4(w4, w0, w1);
    Or or5(w5, w2, w3);
    Or or6(out, w4, w5);

endmodule
