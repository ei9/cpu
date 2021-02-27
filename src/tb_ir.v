`include "sap1.v"

module tb_ir;
    reg clk, clr, li, ei;
    reg[7:0] in;
    wire[3:0] to_ctrl_seq, to_bus;
    ir m(to_ctrl_seq, to_bus, clk, clr, li, ei, in);

    initial begin
        $monitor("%4dns clk=%b clr=%b li=%b ei=%b in=%h out=%h%h", $stime, clk, clr, li, ei, in, to_ctrl_seq, to_bus);
        clk = 0;
        clr = 0;
        li = 0;
        ei = 0;
        in = 0;
        #10 ei = 1;
        #10 li = 1;
        #10 clr = 1;
        #10 clr = 0;
        #10 li = 0;
        #10 ei = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #2 begin
        in = in + 1;
    end

    initial #64 $finish;
endmodule // tb_ir
