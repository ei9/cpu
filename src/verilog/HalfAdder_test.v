module HalfAdder_test;

    reg a, b;
    wire sum, carry;

    initial
        begin
            $dumpfile("HalfAdder_test.vcd");
            $dumpvars(0, halfAdder);
            $monitor("a = %b, b = %b, sum = %b, carry = %b", a, b, sum, carry);

            #1 a = 1'b0; b = 1'b0;
            #1           b = 1'b1;
            #1 a = 1'b1; b = 1'b0;
            #1           b = 1'b1;
            #1 $finish;
        end

    HalfAdder halfAdder(sum, carry, a, b);

endmodule

