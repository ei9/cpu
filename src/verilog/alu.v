`include "mux.v"

module HalfAdder(output sum,carry, input a,b);
    wire w0, w1, w2;

    nand g0(w0, a, b);
    nand g1(w1, a, w0);
    nand g2(w2, w0, b);
    nand g3(sum, w1, w2);
    not  g4(carry, w0);
endmodule  // HalfAdder.

module FullAdder(output sum,carry, input a,b,cin);
    wire axorb, g2_out, anandb;

    xor  g0(axorb, a, b);
    xor  g1(sum, axorb, cin);
    nand g2(g2_out, axorb, cin);
    nand g3(anandb, a, b);
    nand g4(carry, g2_out, anandb);
endmodule  // FullAdder.

module Add16(output[15:0] out, input[15:0] a,b);
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
endmodule  // Add16.

/*
 * 16-bit incrementor.
 */
module Inc16(output[15:0] out, input[15:0] in);
    Add16 g(out, in, 16'b1);
endmodule  // Inc16.

/*
 * 16-bit ALU.
 */
module ALU16(output[15:0] out, output zr,ng, input[15:0] x,y, input zx,nx,zy,ny,f,no);
    // zx, x = 0
    wire[15:0] zx_out;
    Mux16 g0(zx_out, zx, x, 16'b0);

    // nx, x = !x
    wire[15:0] notzx, nx_out;
    Not16 g1(notzx, zx_out);
    Mux16 g2(nx_out, nx, zx_out, notzx);

    // zy, y = 0
    wire[15:0] zy_out;
    Mux16 g3(zy_out, zy, y, 16'b0);

    // ny, y = !y
    wire[15:0] notzy, ny_out;
    Not16 g4(notzy, zy_out);
    Mux16 g5(ny_out, ny, zy_out, notzy);

    // f = 0, out = x & y
    // f = 1, out = x + y
    wire[15:0] nxandny, nxaddny, f_out;
    And16 g6(nxandny, nx_out, ny_out);
    Add16 g7(nxaddny, nx_out, ny_out);
    Mux16 g8(f_out, f, nxandny, nxaddny);

    // no = 0, out = out
    // no = 1, out = !out
    wire[15:0] nf_out;
    Not16 g9(nf_out, f_out);
    Mux16 g10(out, no, f_out, nf_out);

    // out = 0, zr = 1
    wire part0, part1, p1orp2;
    Or8Way g11(part0, out[7:0]);
    Or8Way g12(part1, out[15:8]);
    or g13(p1orp2, part0, part1);
    not g14(zr, p1orp2);

    // out < 0, ng = 1
    and g15(ng, out[15], 1'b1);
endmodule  // 16-bit ALU.
