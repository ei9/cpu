module LCUAdder64_test;

    reg[63:0] a, b;
    reg cin;
    wire[63:0] sum;
    wire cout, pg, gg;

    initial
        begin
            $dumpfile("LCUAdder64_test.vcd");
            $dumpvars(0, lCUAdder64);
            $monitor("cin = %b; a = %h, b = %h, sum = %h, cout = %b, pg = %b, gg = %b", cin, a, b, sum, cout, pg, gg);

            #1 cin = 0; a = 64'h0;                   b = 64'hffff_ffff_ffff_ffff;
            #1          a = 64'hffff_ffff_ffff_ffff; b = 64'h0;
            #1          a = 64'hffff_ffff_ffff_ffff; b = 64'hffff_ffff_ffff_ffff;
            #1          a = 64'h1;                   b = 64'hffff_ffff_ffff_ffff;

            #1 cin = 1; a = 64'h0;                   b = 64'hffff_ffff_ffff_ffff;
            #1          a = 64'hffff_ffff_ffff_ffff; b = 64'h0;
            #1          a = 64'hffff_ffff_ffff_ffff; b = 64'hffff_ffff_ffff_ffff;
            #1          a = 64'h1;                   b = 64'hffff_ffff_ffff_ffff;

            #1 cin = 0; a = 64'h1000_0000_0000_0000; b = 64'h1000_0000_0000;
            #1          a = 64'h1000_0000_0000;      b = 64'h1000_0000;
            #1          a = 64'h1000_0000;           b = 64'h1000;
            #1          a = 64'h1000;                b = 64'h1;
            #1          a = 64'h1111_1111_1111_1111; b = 64'heeee_eeee_eeee_eeee;
            #1 $finish;
        end

    LCUAdder64 lCUAdder64(sum, cout, pg, gg, a, b, cin);

endmodule
