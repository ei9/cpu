module Mux4Way16_test;

    reg[1:0] sel;
    reg[15:0] a, b, c, d;
    wire[15:0] out;

    initial
        begin
            $dumpfile("Mux4Way16_test.vcd");
            $dumpvars(0, mux4Way16);
            $monitor("sel = %h, a = %h, b = %h, c = %h, d = %h, out = %h", sel, a, b, c, d, out);
            #1 sel = 2'h0; a = 16'hf; b = 16'hf0; c = 16'hf00; d = 16'hf000;
            #1 sel = 2'h1;
            #1 sel = 2'h2;
            #1 sel = 2'h3;
            #1 $finish;
        end

    Mux4Way16 mux4Way16(out, sel, a , b, c, d);

endmodule

