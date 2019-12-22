module LCUAdder16_test;

    reg[15:0] a, b;
    reg cin;
    wire[15:0] sum;
    wire cout, pg, gg;

    initial
        begin
            $dumpfile("LCUAdder16_test.vcd");
            $dumpvars(0, lCUAdder16);
            $monitor("cin = %b; a = %d, b = %d, sum = %d, cout = %b, pg = %b, gg = %b", cin, a, b, sum, cout, pg, gg);

            #1 cin = 0; a = 16'h0; b = 16'hffff;
            #1          a = 16'hffff; b = 16'h0;
            #1 cin = 1; a = 16'h0; b = 16'hffff;
            #1          a = 16'hffff; b = 16'h0;
            #1          a = 16'hffff; b = 16'hffff;
            #1 cin = 0; a = 16'h1; b = 16'hffff;
            #1 cin = 1; a = 16'h1; b = 16'hffff;
            #1 cin = 0; a = 0; b = 1;
            while(a < 1024) begin
            #1 a = a + b; b = a + b;
            end
            #1 $finish;
        end

    LCUAdder16 lCUAdder16(sum, cout, pg, gg, a, b, cin);

endmodule
