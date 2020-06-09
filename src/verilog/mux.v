`include "gate16.v"

module Mux(output out, input sel,a,b);
    wire notsel, g1_out, g2_out;

    not  g0(notsel, sel);
    nand g1(g1_out, a, notsel);
    nand g2(g2_out, b, sel);
    nand g3(out, g1_out, g2_out);
endmodule  // Mux.

module Mux16(output[15:0] out, input sel, input[15:0] a,b);
    Mux g0(out[0], sel, a[0], b[0]);
    Mux g1(out[1], sel, a[1], b[1]);
    Mux g2(out[2], sel, a[2], b[2]);
    Mux g3(out[3], sel, a[3], b[3]);
    Mux g4(out[4], sel, a[4], b[4]);
    Mux g5(out[5], sel, a[5], b[5]);
    Mux g6(out[6], sel, a[6], b[6]);
    Mux g7(out[7], sel, a[7], b[7]);
    Mux g8(out[8], sel, a[8], b[8]);
    Mux g9(out[9], sel, a[9], b[9]);
    Mux g10(out[10], sel, a[10], b[10]);
    Mux g11(out[11], sel, a[11], b[11]);
    Mux g12(out[12], sel, a[12], b[12]);
    Mux g13(out[13], sel, a[13], b[13]);
    Mux g14(out[14], sel, a[14], b[14]);
    Mux g15(out[15], sel, a[15], b[15]);
endmodule  // Mux16.

module Mux4Way16(output[15:0] out, input[1:0] sel, input[15:0] a,b,c,d);
    wire[15:0] out_ab, out_cd;

    Mux16 g0(out_ab, sel[0], a, b);
    Mux16 g1(out_cd, sel[0], c, d);
    Mux16 g2(out, sel[1], out_ab, out_cd);
endmodule  // Mux4Way16.

module Mux8Way16(output[15:0] out, input[2:0] sel, input[15:0] a,b,c,d,e,f,g,h);
    wire[15:0] g0_out, g1_out;

    Mux4Way16 g0(g0_out, sel[1:0], a, b, c, d);
    Mux4Way16 g1(g1_out, sel[1:0], e, f, g, h);
    Mux16     g2(out, sel[2], g0_out, g1_out);
endmodule  // Mux8Way16.

module DMux(output a,b, input in,sel);
    wire notsel;

    not g0(notsel, sel);
    and g1(a, in, notsel);
    and g2(b, in, sel);
endmodule  // DMux.

module DMux4Way(output a,b,c,d, input in, input[1:0] sel);
    wire g0_a, g0_b;

    DMux g0(g0_a, g0_b, in, sel[1]);
    DMux g1(a, b, g0_a, sel[0]);
    DMux g2(c, d, g0_b, sel[0]);
endmodule  // DMux4Way.

module DMux8Way(output a,b,c,d,e,f,g,h, input in, input[2:0] sel);
    wire g0_out0, g0_out1;

    DMux     g0(g0_out0, g0_out1, in, sel[2]);
    DMux4Way g1(a, b, c, d, g0_out0, sel[1:0]);
    DMux4Way g2(e, f, g, h, g0_out1, sel[1:0]);
endmodule  // DMux8Way.
