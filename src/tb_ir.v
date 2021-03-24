`include "sap2_mini.v"

module tb_ir;
    reg li, clk, clr, ei;
    wire[11:0] bus;
    wire[7:0] to_ctrl;

    assign bus = li ? 12'habb : 12'hzzz;

    ir m(to_ctrl, bus, li,clk,clr,ei);

    initial begin
        $monitor("%4dns clk=%b clr=%b li=%b ei=%b bus=%h to_ctrl=%h", $stime, clk, clr, li, ei, bus, to_ctrl);
        clk = 0;
        clr = 0;
        li = 0;
        ei = 0;
        
        #4 ei = 1;
        #4 li = 1; ei = 0;
        #4 ei = 1;
        #4 clr = 1;
        #4 clr = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    initial #24 $finish;
endmodule // tb_ir
