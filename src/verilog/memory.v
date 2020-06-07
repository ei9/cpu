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

endmodule  // Register


module RAM8 (out, clk, load, address, in);

    input clk, load;
    input[2:0] address;
    input[15:0] in;
    output[15:0] out;

    wire l0, l1, l2, l3, l4, l5, l6, l7;
    wire[15:0] o0, o1, o2, o3, o4, o5, o6, o7;

    DMux8Way g0(l0, l1, l2, l3, l4, l5, l6, l7, load, address);

    Register r0(o0, clk, l0, in);
    Register r1(o1, clk, l1, in);
    Register r2(o2, clk, l2, in);
    Register r3(o3, clk, l3, in);
    Register r4(o4, clk, l4, in);
    Register r5(o5, clk, l5, in);
    Register r6(o6, clk, l6, in);
    Register r7(o7, clk, l7, in);

    Mux8Way16 g1(out, address, o0, o1, o2, o3, o4, o5, o6, o7);

endmodule  // RAM8


module RAM64 (out, clk, load, address, in);

    input clk, load;
    input[5:0] address;
    input[15:0] in;
    output[15:0] out;

    wire l0, l1, l2, l3, l4, l5, l6, l7;
    wire[15:0] o0, o1, o2, o3, o4, o5, o6, o7;

    DMux8Way g0(l0, l1, l2, l3, l4, l5, l6, l7, load, address[5:3]);

    RAM8 m0(o0, clk, l0, address[2:0], in);
    RAM8 m1(o1, clk, l1, address[2:0], in);
    RAM8 m2(o2, clk, l2, address[2:0], in);
    RAM8 m3(o3, clk, l3, address[2:0], in);
    RAM8 m4(o4, clk, l4, address[2:0], in);
    RAM8 m5(o5, clk, l5, address[2:0], in);
    RAM8 m6(o6, clk, l6, address[2:0], in);
    RAM8 m7(o7, clk, l7, address[2:0], in);

    Mux8Way16 g1(out, address[5:3], o0, o1, o2, o3, o4, o5, o6, o7);

endmodule // RAM64


module RAM512(out, clk, load, address, in);

    input clk, load;
    input[8:0] address;
    input[15:0] in;
    output[15:0] out;

    wire l0, l1, l2, l3, l4, l5, l6, l7;
    wire[15:0] o0, o1, o2, o3, o4, o5, o6, o7;

    DMux8Way g0(l0, l1, l2, l3, l4, l5, l6, l7, load, address[8:6]);

    RAM64 m0(o0, clk, l0, address[5:0], in);
    RAM64 m1(o1, clk, l1, address[5:0], in);
    RAM64 m2(o2, clk, l2, address[5:0], in);
    RAM64 m3(o3, clk, l3, address[5:0], in);
    RAM64 m4(o4, clk, l4, address[5:0], in);
    RAM64 m5(o5, clk, l5, address[5:0], in);
    RAM64 m6(o6, clk, l6, address[5:0], in);
    RAM64 m7(o7, clk, l7, address[5:0], in);

    Mux8Way16 g1(out, address[8:6], o0, o1, o2, o3, o4, o5, o6, o7);

endmodule  // RAM512


module RAM4K(out, clk, load, address, in);

    input clk, load;
    input[11:0] address;
    input[15:0] in;
    output[15:0] out;

    reg[15:0] m[0:2**12-1];  // 0 ~ (2 ** 4 - 1) = 0 ~ 15

    assign out = m[address];

    always @(posedge clk) begin
      if (load) m[address] = in;
    end

endmodule  // RAM4K


module RAM8K(out, clk, load, address, in);

    input clk, load;
    input[12:0] address;
    input[15:0] in;
    output[15:0] out;

    reg[15:0] m[0:2**13-1];

    assign out = m[address];

    always @(posedge clk) begin
        if (load) m[address] = in;
    end

endmodule  // RAM8K


module RAM16K(out, clk, load, address, in);

    input clk, load;
    input[13:0] address;
    input[15:0] in;
    output[15:0] out;

    reg[15:0] m[0:2**14-1];

    assign out = m[address];

    always @ (posedge clk) begin
        if(load) m[address] = in;
    end

endmodule  // RAM16K


module PC(out, clk, inc, load, reset, in);

    input clk, inc, load, reset;
    input[15:0] in;
    output[15:0] out;

    reg[15:0] m;

    assign out = m;

    always @ (posedge clk) begin
        if(reset)
            m = 16'b0;
        else if(load)
            m = in;
        else if(inc)
            m = m + 1;
    end

endmodule  // 16-bit counter.


module ROM32K(output[15:0] out, input[14:0] address);

    reg[15:0] m[0:2**15-1];
    assign out = m[address];

endmodule  // ROM32K.
