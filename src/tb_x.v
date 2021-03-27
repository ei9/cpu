`include "sap2_mini.v"

module tb_x;
    reg lx,inx,clk,dex,ex;
    wire im, iz;
    wire[11:0] bus;
    reg[11:0] in;

    assign bus = lx ? in : 12'bz;

    x m(im,iz, bus, lx,inx,clk,dex,ex);

    initial begin
        $monitor("%2dns clk=%b lx=%b ex=%b inx=%b dex=%b bus=%h im=%b iz=%b", $stime,clk,lx,ex,inx,dex,bus,im,iz);
        clk = 0;
        lx = 0;
        ex = 0;
        inx = 0;
        dex = 0;
        in = 12'h000;

        #4 ex = 1;
        #4 lx = 1;  ex = 0;
        #4 lx = 0;  ex = 1; inx = 1;
        #4 dex = 1;
        #4 inx = 0;
        #4 dex = 0;
        #4 lx = 1;  ex = 0; in = 12'hfff;
        #4 lx = 0;  ex = 1;
    end

    always #1 begin
        clk = ~clk;
    end

    initial #32 $finish;
endmodule // Pointer register test bench.
