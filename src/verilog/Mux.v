`include "gate.v"

module Mux(out, sel, a, b);

    output out;
    input sel, a, b;
    wire w0, w1, w2;

    Not not0(w0, sel);
    nand nand0(w1, a, w0);
    nand nand1(w2, b, sel);
    nand nand2(out, w1, w2);

endmodule


module Mux16(out, sel, a, b);

    output[15:0] out;
    input sel;
    input[15:0] a, b;

    Mux mux0(out[0], sel, a[0], b[0]);
    Mux mux1(out[1], sel, a[1], b[1]);
    Mux mux2(out[2], sel, a[2], b[2]);
    Mux mux3(out[3], sel, a[3], b[3]);
    Mux mux4(out[4], sel, a[4], b[4]);
    Mux mux5(out[5], sel, a[5], b[5]);
    Mux mux6(out[6], sel, a[6], b[6]);
    Mux mux7(out[7], sel, a[7], b[7]);
    Mux mux8(out[8], sel, a[8], b[8]);
    Mux mux9(out[9], sel, a[9], b[9]);
    Mux mux10(out[10], sel, a[10], b[10]);
    Mux mux11(out[11], sel, a[11], b[11]);
    Mux mux12(out[12], sel, a[12], b[12]);
    Mux mux13(out[13], sel, a[13], b[13]);
    Mux mux14(out[14], sel, a[14], b[14]);
    Mux mux15(out[15], sel, a[15], b[15]);

endmodule


module Mux4Way16(out, sel, a, b, c, d);

    output[15:0] out;
    input[1:0] sel;
    input[15:0] a, b, c, d;
    wire[15:0] out_ab, out_cd, in;

    Mux16 mux16_0(out_ab, sel[0], a, b);
    Mux16 mux16_1(out_cd, sel[0], c, d);
    Mux16 mux16_2(out, sel[1], out_ab, out_cd);

endmodule


module Mux8Way16(out, sel, a, b, c, d, e, f, g, h);

    output[15:0] out;
    input[2:0] sel;
    input[15:0] a, b, c, d, e, f, g, h;
    wire[15:0] g0_out, g1_out;

    Mux4Way16 g0(g0_out, sel[1:0], a, b, c, d);
    Mux4Way16 g1(g1_out, sel[1:0], e, f, g, h);
    Mux16 g2(out, sel[2], g0_out, g1_out);

endmodule
