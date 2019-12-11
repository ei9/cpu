module DMux4Way(a, b, c, d, in, sel);

    output a ,b ,c, d;
    input in;
    input[1:0] sel;
    wire w0, w1;

    DMux g0(w0, w1, in, sel[1]);
    DMux g1(a, b, w0, sel[0]);
    DMux g2(c, d, w1, sel[0]);

endmodule

