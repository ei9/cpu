`include "sap2_mini.v"

module tb_mdr;
    reg ld, clk, ed;
    wire[11:0] bus;
    wire[11:0] to_ram;

    assign bus = ld ? 12'haaa : 12'hzzz;

    mdr m(to_ram, bus, ld,clk,ed);

    initial begin
        $monitor("%4dns clk=%b ld=%b ed=%b bus=%h to_ram=%h", $stime, clk, ld, ed, bus, to_ram);
        clk = 0;
        ld = 0;
        ed = 0;

        #4 ld = 1;
        #4 ld = 0;
        #4 ed = 1;
        #4 ed = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    initial #16 $finish;
endmodule  // tb_mdr.
