`include "gate.v"

module Not16(output[15:0] out, input[15:0] in);
    not g0(out[0], in[0]);
    not g1(out[1], in[1]);
    not g2(out[2], in[2]);
    not g3(out[3], in[3]);
    not g4(out[4], in[4]);
    not g5(out[5], in[5]);
    not g6(out[6], in[6]);
    not g7(out[7], in[7]);
    not g8(out[8], in[8]);
    not g9(out[9], in[9]);
    not g10(out[10], in[10]);
    not g11(out[11], in[11]);
    not g12(out[12], in[12]);
    not g13(out[13], in[13]);
    not g14(out[14], in[14]);
    not g15(out[15], in[15]);
endmodule  // Not16.

module And16(output[15:0] out, input[15:0] a,b);
    and g0(out[0], a[0], b[0]);
    and g1(out[1], a[1], b[1]);
    and g2(out[2], a[2], b[2]);
    and g3(out[3], a[3], b[3]);
    and g4(out[4], a[4], b[4]);
    and g5(out[5], a[5], b[5]);
    and g6(out[6], a[6], b[6]);
    and g7(out[7], a[7], b[7]);
    and g8(out[8], a[8], b[8]);
    and g9(out[9], a[9], b[9]);
    and g10(out[10], a[10], b[10]);
    and g11(out[11], a[11], b[11]);
    and g12(out[12], a[12], b[12]);
    and g13(out[13], a[13], b[13]);
    and g14(out[14], a[14], b[14]);
    and g15(out[15], a[15], b[15]);
endmodule  // And16.

module Or16(output[15:0] out, input[15:0] a,b);
    or g0(out[0], a[0], b[0]);
    or g1(out[1], a[1], b[1]);
    or g2(out[2], a[2], b[2]);
    or g3(out[3], a[3], b[3]);
    or g4(out[4], a[4], b[4]);
    or g5(out[5], a[5], b[5]);
    or g6(out[6], a[6], b[6]);
    or g7(out[7], a[7], b[7]);
    or g8(out[8], a[8], b[8]);
    or g9(out[9], a[9], b[9]);
    or g10(out[10], a[10], b[10]);
    or g11(out[11], a[11], b[11]);
    or g12(out[12], a[12], b[12]);
    or g13(out[13], a[13], b[13]);
    or g14(out[14], a[14], b[14]);
    or g15(out[15], a[15], b[15]);
endmodule  // Or16.
