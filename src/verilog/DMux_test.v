module DMux_test;

    reg in, sel;
    wire a, b;

    initial
        begin
            $dumpfile("DMux_test.vcd");
            $dumpvars(0, dmux0);
            $monitor("in = %b, sel = %b, a = %b, b = %b", in, sel, a, b);

            #1 in = 1'b0; sel = 1'b0;
            #1 in = 1'b0; sel = 1'b1;
            #1 in = 1'b1; sel = 1'b0;
            #1 in = 1'b1; sel = 1'b1;
            #1 $finish;
        end

    DMux dmux0(a, b, in, sel);

endmodule

