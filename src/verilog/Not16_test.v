module Not16_test;

    reg[15:0] in;
    wire[15:0] out;

    initial
        begin
            $dumpfile("Not16_test.vcd");
            $dumpvars(0, not16);
            $monitor("in = %b16, out = %b16", in, out);

            #1 in = 16'b0000000000000000;
            #1 in = 16'b1111111111111111;
            #1 in = 16'b0000000011111111;
            #1 in = 16'b1111111100000000;
            #1 in = 16'b0000111100001111;
            #1 in = 16'b1111000011110000;
            #1 in = 16'b0011001100110011;
            #1 in = 16'b1100110011001100;
            #1 in = 16'b0101010101010101;
            #1 in = 16'b1010101010101010;
            #1 $finish;
        end

    Not16 not16(out, in);

endmodule

