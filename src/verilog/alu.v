`include "gate16.v"

module HalfAdder(sum, carry, a, b);

    output sum, carry;
    input a, b;
    wire w0, w1, w2;

    nand nand0(w0, a, b);
    nand nand1(w1, a, w0);
    nand nand2(w2, w0, b);
    nand nand3(sum, w1, w2);
    Not not0(carry, w0);

endmodule


module FullAdder(sum, carry, a, b, cin);

    output sum, carry;
    input a, b, cin;
    wire g0_out, g2_out, g3_out;

    Xor g0(g0_out, a, b);
    Xor g1(sum, g0_out, cin);
    nand g2(g2_out, g0_out, cin);
    nand g3(g3_out, a, b);
    nand g4(carry, g2_out, g3_out);

endmodule


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


/*
 * 1-bit full adder for carry-lookahead adder.
 */
module CLFullAdder(sum, p, g, a, b, cin);

    output sum, p, g;
    input a, b, cin;
    wire g0_out;

    Xor g0(g0_out, a, b);
    Xor g1(sum, g0_out, cin);
    And g2(g, a, b);
    Or g3(p, a, b);

endmodule


/*
 * 16-bit carry-lookahead adder.
 */
module CLAdd16(sum, cout, pg, gg, a, b, cin);

    output[15:0] sum;
    output cout, pg, gg;
    input[15:0] a, b;
    input cin;
    wire[15:0] p, g;
    wire[16:0] carry;
    wire[15:0] pandc;  // p & carry

    assign carry[0] = cin;
    assign cout = carry[16];
    assign pg = p[15];
    assign gg = g[15];

    And16       and16(pandc, p, carry[15:0]);
    Or16        or16(carry[16:1], g, pandc);
    CLFullAdder add0(sum[0], p[0], g[0], a[0], b[0], carry[0]);
    CLFullAdder add1(sum[1], p[1], g[1], a[1], b[1], carry[1]);
    CLFullAdder add2(sum[2], p[2], g[2], a[2], b[2], carry[2]);
    CLFullAdder add3(sum[3], p[3], g[3], a[3], b[3], carry[3]);
    CLFullAdder add4(sum[4], p[4], g[4], a[4], b[4], carry[4]);
    CLFullAdder add5(sum[5], p[5], g[5], a[5], b[5], carry[5]);
    CLFullAdder add6(sum[6], p[6], g[6], a[6], b[6], carry[6]);
    CLFullAdder add7(sum[7], p[7], g[7], a[7], b[7], carry[7]);
    CLFullAdder add8(sum[8], p[8], g[8], a[8], b[8], carry[8]);
    CLFullAdder add9(sum[9], p[9], g[9], a[9], b[9], carry[9]);
    CLFullAdder add10(sum[10], p[10], g[10], a[10], b[10], carry[10]);
    CLFullAdder add11(sum[11], p[11], g[11], a[11], b[11], carry[11]);
    CLFullAdder add12(sum[12], p[12], g[12], a[12], b[12], carry[12]);
    CLFullAdder add13(sum[13], p[13], g[13], a[13], b[13], carry[13]);
    CLFullAdder add14(sum[14], p[14], g[14], a[14], b[14], carry[14]);
    CLFullAdder add15(sum[15], p[15], g[15], a[15], b[15], carry[15]);

endmodule


/*
 * 64-bit carry-lookahead adder.
 */
module Add64(sum, cout, pg, gg, a, b, cin);

    output[63:0] sum;
    output cout, pg, gg;
    input[63:0] a, b;
    input cin;
    wire[4:0] p, g;
    wire[5:0] carry;
    wire[4:0] pandc;  // p & carry

    assign carry[0] = cin;
    assign cout = carry[4];
    assign pg = p[3];
    assign gg = g[3];

    CLAdd16 g0(sum[15:0], carry[1],  p[0], g[0], a[15:0], b[15:0], carry[0]);
    CLAdd16 g1(sum[31:16], carry[2], p[1], g[1], a[31:16], b[31:16], carry[1]);
    CLAdd16 g2(sum[47:32], carry[3], p[2], g[2], a[47:32], b[47:32], carry[2]);
    CLAdd16 g3(sum[63:48], carry[4], p[3], g[3], a[63:48], b[63:48], carry[3]);

endmodule


/*
 * 16-bit incrementor.
 */
module Inc16(out, in);

    input[15:0] in;
    output[15:0] out;
    wire cout, pg, gg;

    CLAdd16 add(out, cout, pg, gg, in, 64'b1, 1'b0);

endmodule


/*
 * 64-bit incrementor.
 */
module Inc64(out, in);

    input[63:0] in;
    output[63:0] out;
    wire cout, pg, gg;

    Add64 add(out, cout, pg, gg, in, 64'b1, 1'b0);

endmodule
