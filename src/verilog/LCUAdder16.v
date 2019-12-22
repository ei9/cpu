// 16-bit carry-lookahead adder.
module LCUAdder16(sum, cout, pg, gg, a, b, cin);

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

    And16 and16(pandc, p, carry[15:0]);
    Or16 or16(carry[16:1], g, pandc);
    CLFullAdder adder0(sum[0], p[0], g[0], a[0], b[0], carry[0]);
    CLFullAdder adder1(sum[1], p[1], g[1], a[1], b[1], carry[1]);
    CLFullAdder adder2(sum[2], p[2], g[2], a[2], b[2], carry[2]);
    CLFullAdder adder3(sum[3], p[3], g[3], a[3], b[3], carry[3]);
    CLFullAdder adder4(sum[4], p[4], g[4], a[4], b[4], carry[4]);
    CLFullAdder adder5(sum[5], p[5], g[5], a[5], b[5], carry[5]);
    CLFullAdder adder6(sum[6], p[6], g[6], a[6], b[6], carry[6]);
    CLFullAdder adder7(sum[7], p[7], g[7], a[7], b[7], carry[7]);
    CLFullAdder adder8(sum[8], p[8], g[8], a[8], b[8], carry[8]);
    CLFullAdder adder9(sum[9], p[9], g[9], a[9], b[9], carry[9]);
    CLFullAdder adder10(sum[10], p[10], g[10], a[10], b[10], carry[10]);
    CLFullAdder adder11(sum[11], p[11], g[11], a[11], b[11], carry[11]);
    CLFullAdder adder12(sum[12], p[12], g[12], a[12], b[12], carry[12]);
    CLFullAdder adder13(sum[13], p[13], g[13], a[13], b[13], carry[13]);
    CLFullAdder adder14(sum[14], p[14], g[14], a[14], b[14], carry[14]);
    CLFullAdder adder15(sum[15], p[15], g[15], a[15], b[15], carry[15]);

endmodule
