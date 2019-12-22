`include "Or8Way.v"

module Or8Way_test;

    reg[7:0] in;
    wire out;

    Or8Way or8Way(out, in);

    initial
        begin
            $dumpfile("Or8Way_test.vcd");
            $dumpvars(0, or8Way);
            $monitor("in = %h, out = %b", in, out);

            #1 in = 8'h0;
            #1 in = 8'h1;
            #1 in = 8'h2;
            #1 in = 8'hf;
            #1 in = 8'h00;
            #1 in = 8'hff;
            #1 in = 8'h80;
            #1 $finish;
        end

endmodule
