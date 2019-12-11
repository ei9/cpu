module Mux8Way16(out, sel, a, b, c, d, e, f, g, h);

    output[15:0] out;
    input[2:0] sel;
    input[15:0] a, b, c, d, e, f, g, h;
    wire[15:0] g0_out, g1_out;

    Mux4Way16 g0(g0_out, sel[1:0], a, b, c, d);
    Mux4Way16 g1(g1_out, sel[1:0], e, f, g, h);
    Mux16 g2(out, sel[2], g0_out, g1_out);

endmodule

