module Add16(out, a, b);

    output[15:0] out;
    input[15:0] a, b;
    wire[15:0] carry;

    FullAdder g0(out[0], carry[0], a[0], b[0], 0);
    FullAdder g1(out[1], carry[1], a[1], b[1], carry[0]);
    FullAdder g2(out[2], carry[2], a[2], b[2], carry[1]);
    FullAdder g3(out[3], carry[3], a[3], b[3], carry[2]);
    FullAdder g4(out[4], carry[4], a[4], b[4], carry[3]);
    FullAdder g5(out[5], carry[5], a[5], b[5], carry[4]);
    FullAdder g6(out[6], carry[6], a[6], b[6], carry[5]);
    FullAdder g7(out[7], carry[7], a[7], b[7], carry[6]);
    FullAdder g8(out[8], carry[8], a[8], b[8], carry[7]);
    FullAdder g9(out[9], carry[9], a[9], b[9], carry[8]);
    FullAdder g10(out[10], carry[10], a[10], b[10], carry[9]);
    FullAdder g11(out[11], carry[11], a[11], b[11], carry[10]);
    FullAdder g12(out[12], carry[12], a[12], b[12], carry[11]);
    FullAdder g13(out[13], carry[13], a[13], b[13], carry[12]);
    FullAdder g14(out[14], carry[14], a[14], b[14], carry[13]);
    FullAdder g15(out[15], carry[15], a[15], b[15], carry[14]);

endmodule
