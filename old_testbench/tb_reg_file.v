`include "rv32i.v"

module tb_reg_file;

    reg         clk, w;
    reg  [4:0]  aw, a1, a2;
    reg  [31:0] d;
    wire [31:0] o1, o2;

    reg_file m(
        .out_x      (o1  ),
        .out_y      (o2  ),
        .addr_x     (a1  ),
        .addr_y     (a2  ),
        .clk        (clk ),
        .write      (w   ),
        .write_addr (aw  ),
        .write_data (d   )
    );

    initial begin
        $monitor("%2d clk=%b w=%b aw=%h d=%h a1=%h a2=%h o1=%h o2=%h",$time,clk,w,aw,d,a1,a2,o1,o2);
        $readmemh("reg.dat", m.regs);
        w   = 0;
        clk = 0;
        aw  = 1;
        d   = 32'habcd_1234;
        a1  = 0;
        a2  = 1;

        #4 w = 1;
        #4 w = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    always #4 begin
        a1 = a1 + 1;
        a2 = a2 + 1;
    end

    initial #20 $finish;
endmodule  // tb_reg_file