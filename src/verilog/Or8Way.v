`include "gate.v"

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
