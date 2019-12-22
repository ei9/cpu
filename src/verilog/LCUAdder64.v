// 64-bit carry-lookahead adder.
module LCUAdder64(sum, cout, pg, gg, a, b, cin);

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

    LCUAdder16 adder0(sum[15:0], carry[1],  p[0], g[0], a[15:0], b[15:0], carry[0]);
    LCUAdder16 adder1(sum[31:16], carry[2], p[1], g[1], a[31:16], b[31:16], carry[1]);
    LCUAdder16 adder2(sum[47:32], carry[3], p[2], g[2], a[47:32], b[47:32], carry[2]);
    LCUAdder16 adder3(sum[63:48], carry[4], p[3], g[3], a[63:48], b[63:48], carry[3]);

endmodule

