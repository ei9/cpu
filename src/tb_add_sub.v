`include "sap1.v"

module tb_add_sub;
    reg su, eu;
    reg[7:0] a, b;
    wire[7:0] out;
    add_sub g(out, su, eu, a, b);

    initial begin
        $monitor("%4dns su=%b eu=%b a=%d b=%d out=%d", $stime, su, eu, a, b, out);
        su = 0;
        eu = 0;
        a = 7;
        b = 100;
        #1 eu = 1;
        #1 su = 1;
        #1 su = 0;
        #1 eu = 0;
        #1 $finish;
    end
endmodule // tb_add_sub
