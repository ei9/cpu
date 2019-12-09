module Or16_test;

    reg[15:0] a, b;
    wire[15:0] out;

    initial
        begin
            $dumpfile("Or16_test.vcd");
            $dumpvars(0, or16);
            $monitor("a = %b, b = %b, out = %b", a, b, out);

            #1 a = 16'h3800; b = 16'h1c;
            #1 a = 16'h4600; b = 16'h62;
            #1 a = 16'h8100; b = 16'h81;
            #1 a = 16'h8000; b = 16'h1;
            #1 a = 16'h6000; b = 16'h6;
            #1 a = 16'h1800; b = 16'h18;
            #1 a = 16'h600; b = 16'h60;
            #1 a = 16'h100; b = 16'h80;
            #1 a = 16'hff; b = 16'hff00;
            #1 $finish;

        end

    Or16 or16(out, a, b);

endmodule

