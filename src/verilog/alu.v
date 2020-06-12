/*
 * 16-bit ALU.
 */
module ALU16(output[15:0] out, output zr,ng, input[15:0] x,y, input zx,nx,zy,ny,f,no);
    // zx, x = 0
    wire[15:0] zx_out;
    assign zx_out = zx ? 16'b0 : x;

    // nx, x = !x
    wire[15:0] nx_out;
    assign nx_out = nx ? ~zx_out : zx_out;

    // zy, y = 0
    wire[15:0] zy_out;
    assign zy_out = zy ? 16'b0 : y;

    // ny, y = !y
    wire[15:0] ny_out;
    assign ny_out = ny ? ~zy_out : zy_out;

    // f = 0, out = x & y
    // f = 1, out = x + y
    wire[15:0] f_out;
    assign f_out = f ? nx_out + ny_out : nx_out & ny_out;

    // no = 0, out = out
    // no = 1, out = !out
    wire[15:0] nf_out;
    assign out = no ? ~f_out : f_out;

    // out = 0, zr = 1
    assign zr = out == 0;

    // out < 0, ng = 1
    assign ng = out[15] & 1'b1;
endmodule  // 16-bit ALU.
