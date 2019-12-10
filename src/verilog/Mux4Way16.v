module Mux4Way16(out, sel, a, b, c, d);

    output[15:0] out;
    input[15:0] a, b, c, d;
    input[1:0] sel;
    wire[15:0] out_ab, out_cd, in;

    Mux16 mux16_0(out_ab, sel[0], a, b);
    Mux16 mux16_1(out_cd, sel[0], c, d);
    Mux16 mux16_2(out, sel[1], out_ab, out_cd);

endmodule

