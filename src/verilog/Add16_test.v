module Add16_test;

    reg[15:0] a, b;
    wire[15:0] out;

    initial
        begin
            $dumpfile("Add16_test.vcd");
            $dumpvars(0, add16);
            $monitor("a = %d, b = %d, out = %d", a, b, out);

            #1 a = 16'hffff; b = 16'h0;
            #1 a = 16'h0; b = 16'hffff;
            #1 a = 16'h1; b = 16'hffff;
            #1 a = 0; b = 1;
            while(a < 1024) begin
            #1 a = a + b; b = a + b;
            end
            #1 $finish;
        end

    Add16 add16(out, a, b);

endmodule
