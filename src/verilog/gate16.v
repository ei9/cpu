`include "gate.v"

module Not16(out, in);

    output[15:0] out;
    input[15:0] in;

    Not g0(out[0], in[0]);
    Not g1(out[1], in[1]);
    Not g2(out[2], in[2]);
    Not g3(out[3], in[3]);
    Not g4(out[4], in[4]);
    Not g5(out[5], in[5]);
    Not g6(out[6], in[6]);
    Not g7(out[7], in[7]);
    Not g8(out[8], in[8]);
    Not g9(out[9], in[9]);
    Not g10(out[10], in[10]);
    Not g11(out[11], in[11]);
    Not g12(out[12], in[12]);
    Not g13(out[13], in[13]);
    Not g14(out[14], in[14]);
    Not g15(out[15], in[15]);

endmodule


module And16(out, a, b);

    output[15:0] out;
    input[15:0] a, b;

    And g0(out[0], a[0], b[0]);
    And g1(out[1], a[1], b[1]);
    And g2(out[2], a[2], b[2]);
    And g3(out[3], a[3], b[3]);
    And g4(out[4], a[4], b[4]);
    And g5(out[5], a[5], b[5]);
    And g6(out[6], a[6], b[6]);
    And g7(out[7], a[7], b[7]);
    And g8(out[8], a[8], b[8]);
    And g9(out[9], a[9], b[9]);
    And g10(out[10], a[10], b[10]);
    And g11(out[11], a[11], b[11]);
    And g12(out[12], a[12], b[12]);
    And g13(out[13], a[13], b[13]);
    And g14(out[14], a[14], b[14]);
    And g15(out[15], a[15], b[15]);

endmodule


module Or16(out, a, b);

    output[15:0] out;
    input[15:0] a, b;

    Or g0(out[0], a[0], b[0]);
    Or g1(out[1], a[1], b[1]);
    Or g2(out[2], a[2], b[2]);
    Or g3(out[3], a[3], b[3]);
    Or g4(out[4], a[4], b[4]);
    Or g5(out[5], a[5], b[5]);
    Or g6(out[6], a[6], b[6]);
    Or g7(out[7], a[7], b[7]);
    Or g8(out[8], a[8], b[8]);
    Or g9(out[9], a[9], b[9]);
    Or g10(out[10], a[10], b[10]);
    Or g11(out[11], a[11], b[11]);
    Or g12(out[12], a[12], b[12]);
    Or g13(out[13], a[13], b[13]);
    Or g14(out[14], a[14], b[14]);
    Or g15(out[15], a[15], b[15]);

endmodule
