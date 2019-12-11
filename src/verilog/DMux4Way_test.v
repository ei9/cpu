module DMux4Way_test;

    reg in;
    reg[1:0] sel;
    wire a, b, c, d;

    initial
        begin
            $dumpfile("DMux4Way_test.vcd");
            $dumpvars(0, dmux4way);
            $monitor("in = %b, sel = %b, a = %b, b = %b, c = %b, d = %b", in, sel, a, b, c, d);

            #1 in = 1'b0; sel = 2'h0;
            #1 sel = 2'h1;
            #1 sel = 2'h2;
            #1 sel = 2'h3;
            #1 in = 1'b1; sel = 2'h0;
            #1 sel = 2'h1;
            #1 sel = 2'h2;
            #1 sel = 2'h3;
            #1 $finish;
        end

    DMux4Way dmux4way(a, b, c, d, in, sel);

endmodule

