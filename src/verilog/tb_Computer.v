`include "Computer.v"

module tb_Computer;
    reg reset, clk;
    Computer c(clk, reset);

    integer i;

    initial begin
        $readmemb("../assembly/Mult_2.hack", c.rom.m);
        for(i = 0 ; i < 32 ; i = i + 1) begin
            $display("%4x: %x", i, c.rom.m[i]);
        end
        $monitor("%4dns clk=%d pc=%d I=%d A=%d D=%d M=%d", $stime, clk, c.pc, c.I, c.addressM, c.cpu.Dout, c.outM);
        clk = 0;
        #10 reset = 1;
        #20 reset = 0;
    end

    always #5 begin
        clk = ~clk;
    end

    initial #1800 $finish;
endmodule  // tb_Computer.
