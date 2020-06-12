`include "mux.v"

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
    assign zr = out == 0;

    // out < 0, ng = 1
    and g15(ng, out[15], 1'b1);
endmodule  // 16-bit ALU.
