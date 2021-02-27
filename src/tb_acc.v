`include "sap1.v"

module tb_acc;
    reg clk, la, ea;
    reg[7:0] in;
    wire[7:0] to_bus, to_add_sub;
    acc m(to_bus, to_add_sub, clk, la, ea, in);

    initial begin
        $monitor("%4dns clk=%b la=%b ea=%b in=%d bus=%d add_sub=%d", $stime, clk, la, ea, in, to_bus, to_add_sub);
        clk = 0;
        la = 0;
        ea = 0;
        in = 0;
        #10 ea = 1;
        #10 la = 1;
        #10 la = 0;
        #10 ea = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
    end

    initial #64 $finish;
endmodule // tb_acc
