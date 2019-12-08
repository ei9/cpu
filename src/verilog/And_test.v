module And_test;

    reg a, b;
    wire out;

    initial
        begin
            $dumpfile("And_test.vcd");
            $dumpvars(0, and0);
            $monitor("a = %b, b = %b, out = %b", a, b, out);

            #1 a = 1'b0; b = 1'b0;
            #1 a = 1'b0; b = 1'b1;
            #1 a = 1'b1; b = 1'b0;
            #1 a = 1'b1; b = 1'b1;
            #1 $finish;
        end

    And and0(out, a, b);

endmodule

