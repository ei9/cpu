`include "mux.v"

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
    Or  g3(p, a, b);

endmodule  // Carry-lookahead 1-bit adder.


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

    And g0(carry[0], cin, cin);
    And g1(cout, carry[16], carry[16]);
    And g2(pg, p[15], p[15]);
    And g3(gg, g[15], g[15]);

    And16       g4(pandc, p, carry[15:0]);
    Or16        g5(carry[16:1], g, pandc);
    CLFullAdder g6(sum[0], p[0], g[0], a[0], b[0], carry[0]);
    CLFullAdder g7(sum[1], p[1], g[1], a[1], b[1], carry[1]);
    CLFullAdder g8(sum[2], p[2], g[2], a[2], b[2], carry[2]);
    CLFullAdder g9(sum[3], p[3], g[3], a[3], b[3], carry[3]);
    CLFullAdder g10(sum[4], p[4], g[4], a[4], b[4], carry[4]);
    CLFullAdder g11(sum[5], p[5], g[5], a[5], b[5], carry[5]);
    CLFullAdder g12(sum[6], p[6], g[6], a[6], b[6], carry[6]);
    CLFullAdder g13(sum[7], p[7], g[7], a[7], b[7], carry[7]);
    CLFullAdder g14(sum[8], p[8], g[8], a[8], b[8], carry[8]);
    CLFullAdder g15(sum[9], p[9], g[9], a[9], b[9], carry[9]);
    CLFullAdder g16(sum[10], p[10], g[10], a[10], b[10], carry[10]);
    CLFullAdder g17(sum[11], p[11], g[11], a[11], b[11], carry[11]);
    CLFullAdder g18(sum[12], p[12], g[12], a[12], b[12], carry[12]);
    CLFullAdder g19(sum[13], p[13], g[13], a[13], b[13], carry[13]);
    CLFullAdder g20(sum[14], p[14], g[14], a[14], b[14], carry[14]);
    CLFullAdder g21(sum[15], p[15], g[15], a[15], b[15], carry[15]);

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

    And g0(carry[0], cin, cin);
    And g1(cout, carry[4], carry[4]);
    And g2(pg, p[3], p[3]);
    And g3(gg, g[3], g[3]);

    CLAdd16 g4(sum[15:0], carry[1],  p[0], g[0], a[15:0], b[15:0], carry[0]);
    CLAdd16 g5(sum[31:16], carry[2], p[1], g[1], a[31:16], b[31:16], carry[1]);
    CLAdd16 g6(sum[47:32], carry[3], p[2], g[2], a[47:32], b[47:32], carry[2]);
    CLAdd16 g7(sum[63:48], carry[4], p[3], g[3], a[63:48], b[63:48], carry[3]);

endmodule


/*
 * Carry-lookahead version of 16-bit incrementor.
 */
module CLInc16(out, in);

    input[15:0] in;
    output[15:0] out;
    wire cout, pg, gg;

    CLAdd16 g0(out, cout, pg, gg, in, 16'b1, 1'b0);

endmodule


/*
 * 64-bit incrementor.
 */
module Inc64(out, in);

    input[63:0] in;
    output[63:0] out;
    wire cout, pg, gg;

    Add64 g0(out, cout, pg, gg, in, 64'b1, 1'b0);

endmodule


module NotIn (out, su, in);

    output[15:0] out;
    input su;
    input[15:0] in;

    Xor g0(out[0], su, in[0]);
    Xor g1(out[1], su, in[1]);
    Xor g2(out[2], su, in[2]);
    Xor g3(out[3], su, in[3]);
    Xor g4(out[4], su, in[4]);
    Xor g5(out[5], su, in[5]);
    Xor g6(out[6], su, in[6]);
    Xor g7(out[7], su, in[7]);
    Xor g8(out[8], su, in[8]);
    Xor g9(out[9], su, in[9]);
    Xor g10(out[10], su, in[10]);
    Xor g11(out[11], su, in[11]);
    Xor g12(out[12], su, in[12]);
    Xor g13(out[13], su, in[13]);
    Xor g14(out[14], su, in[14]);
    Xor g15(out[15], su, in[15]);

endmodule  // Not in (1's complement)


module ZeroIn (out, z, in);

    output[15:0] out;
    input z;
    input[15:0] in;

    wire notz;

    Not g0(notz, z);
    And g1(out[0], notz, in[0]);
    And g2(out[1], notz, in[1]);
    And g3(out[2], notz, in[2]);
    And g4(out[3], notz, in[3]);
    And g5(out[4], notz, in[4]);
    And g6(out[5], notz, in[5]);
    And g7(out[6], notz, in[6]);
    And g8(out[7], notz, in[7]);
    And g9(out[8], notz, in[8]);
    And g10(out[9], notz, in[9]);
    And g11(out[10], notz, in[10]);
    And g12(out[11], notz, in[11]);
    And g13(out[12], notz, in[12]);
    And g14(out[13], notz, in[13]);
    And g15(out[14], notz, in[14]);
    And g16(out[15], notz, in[15]);

endmodule // Andin


module CL_ALU16(out, zr, ng, x, y, zx, nx, zy, ny, f, no);

    output[15:0] out;
    output zr, ng;
    input zx, nx, zy, ny, f, no;
    input[15:0] x, y;

    // x = 0
    wire zx_not;
    Not g0(zx_not, zx);

    wire[15:0] xzero;
    ZeroIn g1(xzero, zx, x);

    // x = !x
    wire[15:0] xout;
    NotIn g3(xout, nx, xzero);

    // y = 0
    wire zy_not;
    Not g4(zy_not, zy);

    wire[15:0] yzero;
    ZeroIn g5(yzero, zy, y);

    // y = !y
    wire[15:0] yout;
    NotIn g6(yout, ny, yzero);

    // x + y
    wire[15:0] xplusy;
    wire cout, pg, gg;
    CLAdd16 g7(xplusy, cout, pg, gg, xout, yout, 1'b0);

    // out = x & y
    wire[15:0] xandy;
    And16 g8(xandy, xout, yout);

    // f == 1, out = x + y
    // f == 0, out = x & y
    wire[15:0] result;
    Mux16 g9(result, f, xandy, xplusy);

    // out = !out
    NotIn g10(out, no, result);

    // out == 0, zr = 1
    wire part0, part1, p1orp2;
    Or8Way g11(part0, out[7:0]);
    Or8Way g12(part1, out[15:8]);
    Or     g13(p1orp2, part0, part1);
    Not    g14(zr, p1orp2);

    // out < 0, ng = 1;
    And g15(ng, out[15], out[15]);

endmodule // Carry-lookahead version of 16-bit ALU.
