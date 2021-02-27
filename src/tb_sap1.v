`include "sap1.v"

module tb_sap1;
    reg clk, clr, prog, write;
    reg[3:0] a;
    reg[7:0] d;
    wire[7:0] out;

    sap1 c(out, clk, clr, prog, write, a, d);

    initial begin
        $dumpfile("./tb_sap1.vcd");
        $dumpvars(0, c);
        $monitor("%4dns clk=%b clr=%b prog=%b write=%b a=%h d=%h bus=%h out=%d", $stime, clk ,clr, prog, write, a, d, c.wbus, out);
        clk = 0;
        clr = 0;
        prog = 0;   // prog = 1 to start programming.
        write = 0;  // write = 1 to write to RAM.
        a = 0;
        d = 0;

        #10 clr = 1;
        #10 clr = 0;
        #10 prog = 1; write = 1;
        #10 a = 4'h0; d = 8'h09;  // LDA 9H
        #10 a = 4'h1; d = 8'h1a;  // ADD AH
        #10 a = 4'h2; d = 8'h1b;  // ADD BH
        #10 a = 4'h3; d = 8'h2c;  // SUB CH
        #10 a = 4'h4; d = 8'hex;  // OUT
        #10 a = 4'h5; d = 8'hfx;  // HLT
        #10 a = 4'h6; d = 8'hxx;
        #10 a = 4'h7; d = 8'hxx;
        #10 a = 4'h8; d = 8'hxx;
        #10 a = 4'h9; d = 8'h10;  // 10H
        #10 a = 4'ha; d = 8'h14;  // 14H
        #10 a = 4'hb; d = 8'h18;  // 18H
        #10 a = 4'hc; d = 8'h20;  // 20H
        #10 write = 0; prog = 0; clr = 1;
        #10 clr = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    initial #256 $finish;
endmodule // tb_sap1.
