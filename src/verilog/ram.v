`include "alu.v"

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


module DFF(q, qbar, clk, d);

    input clk, d;
    output q, qbar;

    wire dbar;

    Not g0(dbar, d);
    SR_FF g1(q, qbar, clk, d, dbar);

endmodule  // D Flop-Flip.


module Bit(out, clk, load, in);

    input clk, load, in;
    output out;

    wire dffin, outbar;

    Mux g0(dffin, load, out, in);
    DFF g1(out, outbar, clk, dffin);

endmodule  // 1-bit register.


module Register(out, clk, load, in);

    input clk, load;
    input[15:0] in;
    output[15:0] out;

    Bit g0(out[0], clk, load, in[0]);
    Bit g1(out[1], clk, load, in[1]);
    Bit g2(out[2], clk, load, in[2]);
    Bit g3(out[3], clk, load, in[3]);
    Bit g4(out[4], clk, load, in[4]);
    Bit g5(out[5], clk, load, in[5]);
    Bit g6(out[6], clk, load, in[6]);
    Bit g7(out[7], clk, load, in[7]);
    Bit g8(out[8], clk, load, in[8]);
    Bit g9(out[9], clk, load, in[9]);
    Bit g10(out[10], clk, load, in[10]);
    Bit g11(out[11], clk, load, in[11]);
    Bit g12(out[12], clk, load, in[12]);
    Bit g13(out[13], clk, load, in[13]);
    Bit g14(out[14], clk, load, in[14]);
    Bit g15(out[15], clk, load, in[15]);

endmodule
