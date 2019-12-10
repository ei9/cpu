module Mux16_test;

    reg sel;
    reg[15:0] a, b;
    wire[15:0] out;

    initial
        begin
            $dumpfile("Mux16_test.vcd");
            $dumpvars(0, mux16);
            $monitor("sel = %b, a = %h, b = %h, out = %h", sel, a, b, out);

            #1 sel = 1'b0; a = 16'h0; b = 16'hffff;
            #1 sel = 1'b0; a = 16'hffff; b = 16'h0;
            #1 sel = 1'b1; a = 16'hffff; b = 16'h0;
            #1 sel = 1'b0; a = 16'h1234; b = 16'h4321;
            #1 sel = 1'b1; a = 16'h1234; b = 16'h4321;
            #1 $finish;
        end

    Mux16 mux16(out, sel, a, b);

endmodule

