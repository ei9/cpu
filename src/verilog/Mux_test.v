module Mux_test;

    reg sel, a, b;
    wire out;

    initial
        begin
            $dumpfile("Mux_test.vcd");
            $dumpvars(0, mux0);
            $monitor("sel = %b, a = %b, b = %b, out = %b", sel, a, b, out);

            #1 sel = 1'b0; a = 1'b0; b = 1'b0;
            #1 sel = 1'b0; a = 1'b0; b = 1'b1;
            #1 sel = 1'b0; a = 1'b1; b = 1'b0;
            #1 sel = 1'b0; a = 1'b1; b = 1'b1;
            #1 sel = 1'b1; a = 1'b0; b = 1'b0;
            #1 sel = 1'b1; a = 1'b0; b = 1'b1;
            #1 sel = 1'b1; a = 1'b1; b = 1'b0;
            #1 sel = 1'b1; a = 1'b1; b = 1'b1;
            #1 $finish;
        end

    Mux mux0(out, sel, a , b);

endmodule

