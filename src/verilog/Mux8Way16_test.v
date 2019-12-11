module Mux8Way16_test;

    reg[2:0] sel;
    reg[15:0] a, b, c, d, e, f, g, h;
    wire[15:0] out;

    initial
        begin
            $dumpfile("Mux8Way16_test.vcd");
            $dumpvars(0, mux8Way16);
            $monitor("sel = %h, a = %h, b = %h, c = %h, d = %h, e = %h, f = %h, g = %h, h = %h, out = %h", sel, a, b, c, d, e, f, g, h, out);

            #1 sel = 3'h0; a = 16'h3141; b = 16'h5926; c = 16'h5358; d = 16'h9793; e = 16'h2384; f = 16'h6264; g = 16'h3383; h = 16'h2795;
            #1 sel = 3'h1;
            #1 sel = 3'h2;
            #1 sel = 3'h3;
            #1 sel = 3'h4;
            #1 sel = 3'h5;
            #1 sel = 3'h6;
            #1 sel = 3'h7;
            #1 $finish;
        end

    Mux8Way16 mux8Way16(out, sel, a, b, c, d, e, f, g, h);

endmodule

