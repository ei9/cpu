module DMux8Way(a, b, c, d, e, f, g, h, in, sel);

    output a, b, c, d, e, f, g, h;
    input in;
    input[2:0] sel;
    wire g0_out0, g0_out1;

    DMux g0(g0_out0, g0_out1, in, sel[2]);
    DMux4Way g1(a, b, c, d, g0_out0, sel[1:0]);
    DMux4Way g2(e, f, g, h, g0_out1, sel[1:0]);

endmodule

