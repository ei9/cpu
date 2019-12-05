module And_test;

    reg a, b;
    wire out;

    initial
        begin
            $dumpfile("And_test.vcd");
            $dumpvars(0, and1);
            $monitor("a = %b, b = %b, out = %b", a, b, out);

            #50 a = 1'b0; b = 1'b0;
            #50 a = 1'b0; b = 1'b1;
            #50 a = 1'b1; b = 1'b0;
            #50 a = 1'b1; b = 1'b1;
            #50 $finish;
        end

    And and1(out, a, b);

endmodule

