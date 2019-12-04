module And_test;

    reg a, b;

    wire out;

    initial
        begin
            $dumpfile("And_test.vcd");
            $dumpvars(0, and1);
            $monitor("a = %b", in, out);

            #50 in = 1'b0;
            #50 in = 1'b1;
            #50 $finish;
        end

    And and1(out, a, b);

endmodule

