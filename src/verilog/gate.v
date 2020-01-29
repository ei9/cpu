module Not(out, in);

    input in;
    output out;

    nand g(out, in, in);

endmodule


module And(out, a, b);

    input a, b;
    output out;
    wire aNandb;

    nand g0(aNandb, a, b);
    Not  g1(out, aNandb);

endmodule


module Or(out, a, b);

    input a, b;
    output out;
    wire nata, natb;

    Not  g0(nota, a);
    Not  g1(notb, b);
    nand g3(out, nota, notb);

endmodule


module Xor(out, a, b);

    input a, b;
    output out;
    wire aNandb, w0, w1;

    nand g0(aNandb, a, b);
    nand g1(w0, a, aNandb);
    nand g2(w1, aNandb, b);
    nand g3(out, w0, w1);

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
