`include "add.v"

module add_test;

    reg[63:0] a, b;
    reg cin;
    wire[63:0] sum;
    wire cout, pg, gg;

    Add64 g0(sum, cout, pg, gg, a, b, cin);

    initial begin
        $dumpfile("add_test.vcd");
        $dumpvars(0, g0);
        $monitor("%4dns cin = %b; a = %h, b = %h, sum = %h, cout = %b, pg = %b, gg = %b", $stime, cin, a, b, sum, cout, pg, gg);

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

        #1 a = 64'h123_4567_89ab_cdef; b = 64'hfedc_ba98_7654_3211;
        #1 $finish;
    end

endmodule
