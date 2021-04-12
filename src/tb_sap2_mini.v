`include "sap2_mini.v"

module tb_sap2_mini;
    reg clk,clr,prog;
    reg[7:0] a;
    reg[11:0] d,i;
    wire[11:0] out;

    sap2_mini c(out, clk,clr,prog, a, d,i);

    initial begin
        $dumpfile("./tb_sap2_mini.vcd");
        $dumpvars(0, c);
        $monitor("%3dns clk=%b clr=%b prog=%b a=%h d=%h i=%h bus=%h out=%d", $stime, clk ,clr, prog, a, d, i, c.bus, out);
        clk = 0;
        clr = 0;
        prog = 0;   // prog = 1 to start programming.
        a = 0;
        d = 0;
        i = 0;

        #4 clr = 1;
        #4 clr = 0;
        #4 prog = 1;

        // // Start [1+2+3-4=2]
        // #4 a = 8'h0; d = 12'h007;  // LDA 07H
        // #4 a = 8'h1; d = 12'h108;  // ADD 08H
        // #4 a = 8'h2; d = 12'h109;  // ADD 09H
        // #4 a = 8'h3; d = 12'h20a;  // SUB 0AH
        // #4 a = 8'h4; d = 12'hfex;  // OUT
        // #4 a = 8'h5; d = 12'hffx;  // HLT
        // #4 a = 8'h6; d = 12'hfff;  // FFFH
        // #4 a = 8'h7; d = 12'h001;  // 001H
        // #4 a = 8'h8; d = 12'h002;  // 002H
        // #4 a = 8'h9; d = 12'h003;  // 003H
        // #4 a = 8'ha; d = 12'h004;  // 004H
        // // End [1+2+3-4=2]

        // // Start [(i&1==0)?o=0:o=fff;]
        // i = 1;
        // #4 a = 8'h0; d = 12'hfdx;  // INP
        // #4 a = 8'h1; d = 12'h409;  // LDB 09H
        // #4 a = 8'h2; d = 12'hf8x;  // AND
        // #4 a = 8'h3; d = 12'h806;  // JAZ 06H
        // #4 a = 8'h4; d = 12'h00a;  // LDA 0AH
        // #4 a = 8'h5; d = 12'h607;  // JMP 07H
        // #4 a = 8'h6; d = 12'h00b;  // LDA 0BH
        // #4 a = 8'h7; d = 12'hfex;  // OUT
        // #4 a = 8'h8; d = 12'hffx;  // HLT
        // #4 a = 8'h9; d = 12'h001;  // 001H
        // #4 a = 8'ha; d = 12'hfff;  // FFFH
        // #4 a = 8'hb; d = 12'h000;  // 000H
        // // End [(i&1==0)?o=0:o=fff;]

        // // Start [13x8=104]
        // #4 a = 8'h0; d = 12'h509;  // LDX 09H
        // #4 a = 8'h1; d = 12'hf1x;  // CLA
        // #4 a = 8'h2; d = 12'hf3x;  // DEX
        // #4 a = 8'h3; d = 12'h108;  // ADD 08H
        // #4 a = 8'h4; d = 12'ha06;  // JIZ 06H
        // #4 a = 8'h5; d = 12'h602;  // JMP 02H
        // #4 a = 8'h6; d = 12'hfex;  // OUT
        // #4 a = 8'h7; d = 12'hffx;  // HLT
        // #4 a = 8'h8; d = 12'h00d;  // 00DH
        // #4 a = 8'h9; d = 12'h008;  // 008H
        // // End [13x8=104]

        // Start [o=~i; o=i;]
        i = 1;
        #4 a = 8'h0; d = 12'hfdx;  // INP
        #4 a = 8'h1; d = 12'h307;  // STA 07H
        #4 a = 8'h2; d = 12'hf5x;  // CMA
        #4 a = 8'h3; d = 12'hfex;  // OUT
        #4 a = 8'h4; d = 12'h007;  // LDA 07H
        #4 a = 8'h5; d = 12'hfex;  // OUT
        #4 a = 8'h6; d = 12'hffx;  // HLT
        // End [o=~i; o=i;]

        #4 prog = 0; clr = 1;
        #4 clr = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    initial #486 $finish;
endmodule // tb_sap2_mini.
