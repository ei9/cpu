module Mux16_test;

    reg[15:0] sel, a, b;
    wire[15:0] out;

    initial
        begin
            $dumpfile("Mux16_test.vcd");
            $dumpvars(0, mux16);
            $monitor("sel = %h, a = %h, b = %h, out = %h", sel, a, b, out);

            #1 sel = 16'h0; a = 16'h0; b = 16'hffff;
            #1 sel = 16'h0f0f; a = 16'hffff; b = 16'h0000;
            #1 sel = 16'hffff; a = 16'h1234; b = 16'h4321;
            #1 sel = 16'h1234; a = 16'h1234; b = 16'h4321;
            #1 sel = 16'h5555; a = 16'h1234; b = 16'h4321;
            #1 $finish;
        end

    Mux16 mux16(out, sel, a, b);

endmodule

