`include "sap2_mini.v"

module tb_acc;
    reg la, clk, ea;
    wire am, az;
    wire[11:0] bus;
    wire[11:0] out;
    reg[11:0] in;

    assign bus = la ? in : 12'bz;

    acc m(out, am,az, bus, la,clk,ea);

    initial begin
        $monitor("%2dns clk=%b la=%b ea=%b bus=%d out=%d am=%b az=%b", $stime,clk,la,ea,bus,out,am,az);
        clk = 0;
        la = 0;
        ea = 0;
        in = 12'h000;

        #4 ea = 1;
        #4 la = 1; ea = 0;
        #4 ea = 1; in = 12'hfff;
        #4 la = 0;
    end

    always #1 begin
        clk = ~clk;
    end

    initial #20 $finish;
endmodule // tb_acc.
