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
    wire aOrb, cOrd, eOrf, gOrh, g0Org1, g2Org3;

    Or g0(aOrb, in[0], in[1]);
    Or g1(cOrd, in[2], in[3]);
    Or g2(eOrf, in[4], in[5]);
    Or g3(gOrh, in[6], in[7]);
    Or g4(g0Org1, aOrb, cOrd);
    Or g5(g2Org3, eOrf, gOrh);
    Or g6(out, g0Org1, g2Org3);

endmodule
