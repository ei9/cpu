module Or_test;

    reg a, b;
    wire out;

    initial
        begin
            $dumpfile("Or_test.vcd");
            $dumpvars(0, or0);
            $monitor("a = %b, b = %b, out = %b", a, b, out);

            #5 a = 1'b0; b = 1'b0;
            #5 a = 1'b0; b = 1'b1;
            #5 a = 1'b1; b = 1'b0;
            #5 a = 1'b1; b = 1'b1;
            #5 $finish;
        end 
    
    Or or0(out, a, b);
    
endmodule 
