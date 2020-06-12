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
