module DMux8Way_test;

    reg in;
    reg[2:0] sel;
    wire a, b, c, d, e, f, g, h;

    initial
        begin
            $dumpfile("DMux8Way_test.vcd");
            $dumpvars(0, dmux8way);
            $monitor("in = %b, sel = %b, a = %b, b = %b, c = %b, d = %b, e = %b, f = %b, g = %b, h = %b", in, sel, a, b, c, d, e, f, g, h);

            #1 in = 1'b0; sel = 3'h0;
            #1 sel = 3'h1;
            #1 sel = 3'h2;
            #1 sel = 3'h3;
            #1 sel = 3'h4;
            #1 sel = 3'h5;
            #1 sel = 3'h6;
            #1 sel = 3'h7;
            #1 in = 1'b1; sel = 3'h0;
            #1 sel = 3'h1;
            #1 sel = 3'h2;
            #1 sel = 3'h3;
            #1 sel = 3'h4;
            #1 sel = 3'h5;
            #1 sel = 3'h6;
            #1 sel = 3'h7;
            #1 $finish;
        end

    DMux8Way dmux8way(a, b, c, d, e, f, g, h, in, sel);

endmodule

