module FullAdder_test;

    reg a, b, cin;
    wire sum, carry;

    initial
        begin
            $dumpfile("FullAdder_test.vcd");
            $dumpvars(0, fullAdder);
            $monitor("a = %b, b = %b, cin = %b, sum = %b, carry = %b", a, b, cin, sum, carry);

            #1 a = 1'b0; b = 1'b0; cin = 1'b0;
            #1                     cin = 1'b1;
            #1           b = 1'b1; cin = 1'b0;
            #1                     cin = 1'b1;
            #1 a = 1'b1; b = 1'b0; cin = 1'b0;
            #1                     cin = 1'b1;
            #1           b = 1'b1; cin = 1'b0;
            #1                     cin = 1'b1;
            #1 $finish;
        end

    FullAdder fullAdder(sum, carry, a, b, cin);

endmodule

