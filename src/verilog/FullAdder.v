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

