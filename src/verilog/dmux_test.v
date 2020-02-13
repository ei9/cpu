`include "mux.v"

module dmux_test;

    reg in;
    reg[2:0] sel;
    wire[1:0] dmux;
    wire[3:0] dmux4;
    wire[7:0] dmux8;

    DMux     g0(dmux[1], dmux[0], in, sel[2]);
    DMux4Way g1(dmux4[3], dmux4[2], dmux4[1], dmux4[0], in, sel[2:1]);
    DMux8Way g2(dmux8[7], dmux8[6], dmux8[5], dmux8[4], dmux8[3], dmux8[2], dmux8[1], dmux8[0], in, sel);

    initial begin
        $dumpfile("dmux_test.vcd");
        $dumpvars(0, g0, g1, g2);
        $monitor("%4dns in = %b, sel = %d, dmux = %b, dmux4 = %d, dmux8 = %d", $stime, in, sel, dmux, dmux4, dmux8);

        in = 0;
        sel = 0;
    end

    always #1 begin
        sel = sel + 1;
    end

    always #8 begin
        in = in + 1;
    end

    initial #16 $finish;

endmodule
