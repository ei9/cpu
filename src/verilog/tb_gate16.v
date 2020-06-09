`include "gate16.v"

module tb_gate16;
    reg[15:0] a, b;
    wire[15:0] aNot, abAnd, abOr;

    Not16 not16(aNot, a);
    And16 and16(abAnd, a, b);
    Or16  or16(abOr, a, b);

    initial begin
        $dumpfile("tb_gate16.vcd");
        $dumpvars(0, not16, and16, or16);
        $monitor("a = %h, b = %h, aNot = %h, abAnd = %h, abOr = %h", a, b, aNot, abAnd, abOr);

        #1 a = 16'h0; b = 16'h0;
        #1 a = 16'hf; b = 16'hf;
        #1 a = 16'b0000000011111111; b = 16'b1111111100000000;
        #1 a = 16'b1111111100000000; b = 16'b0000000011111111;
        #1 a = 16'b0101010101010101; b = 16'b1010101010101010;
        #1 a = 16'b0000000011111111; b = 16'b0000000011111111;
        #1 a = 16'b1010101010101010; b = 16'b1010101010101010;
        #1 a = 16'b1111000011110000; b = 16'b1111000000001111;
        #1 $finish;
    end
endmodule  // tb_gate16.
