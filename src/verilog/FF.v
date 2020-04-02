`include "gate.v"

module SR_latch(q, qbar, sbar, rbar);

    input sbar, rbar;
    output q, qbar;

    nand g0(q, sbar, qbar);
    nand g1(qbar, q, rbar);

endmodule  // nand SR-latch

module PTD(ppulse, clk);

    input clk;
    output ppulse;

    wire clk_bar;

    not #1 g0(clk_bar, clk);
    and #1 g1(ppulse, clk_bar, clk);

endmodule  // Pulse Transition Detector.
