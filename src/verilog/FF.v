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


module en_latch(q, qbar, en, s, r);

    input en, s, r;
    output q, qbar;

    wire snanden, rnanden;

    nand g0(snanden, s, en);
    nand g1(rnanden, en, r);
    SR_latch g3(q, qbar, snanden, rnanden);

endmodule  // SR-latch with enable pin.


module SR_FF(q, qbar, clk, s, r);

    input clk, s, r;
    output q, qbar;

    wire en;

    PTD g0(en, clk);
    en_latch g1(q, qbar, en, s, r);

endmodule  // SR-Flip-Flop.
