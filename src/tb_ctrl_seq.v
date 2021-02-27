`include "sap1.v"

module tb_ctrl_seq;
    reg clk, clr;
    reg[3:0] i;
    wire hlt;
    wire[11:0] cb;
    ctrl_seq m(cb, hlt, clk, clr, i);

    initial begin
        $monitor("%4dns clk=%b clr=%b i=%d cb=%h hlt=%b sc=%d c=%d nop=%b", $stime, clk, clr, i, cb, hlt, m.sc, m.counter, m.nop);
        clk = 0;
        clr = 0;
        i = 4'b1111;
        #10 clr = 1;
        #10 clr = 0;
        #12 i = 4'b0000;  // LDA
        #12 i = 4'b0001;  // ADD
        #12 i = 4'b0010;  // SUB
        #12 i = 4'b1110;  // OUT
        #12 i = 4'b1111;  // HLT
    end

    always #1 begin
        clk = ~clk;
    end

    initial #150 $finish;
endmodule // tb_ctrl_seq
