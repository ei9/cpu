module CLFullAdder_test;

    reg a, b, cin;
    wire sum, p, g;

    initial
        begin
            $dumpfile("CLFullAdder_test.vcd");
            $dumpvars(0, cLFullAdder);
            $monitor("a = %b, b = %b, cin = %b, sum = %b, p = %b, g = %b", a, b, cin, sum, p, g);

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

    CLFullAdder cLFullAdder(sum, p, g, a, b, cin);

endmodule

