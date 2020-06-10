`include "alu.v"

module DFF(output out, input clk,in);
    reg q;
    assign out = q;
    always @ (posedge clk) begin
        q = in;
    end
endmodule  // D Flop-Flip.

module Bit(output out, input clk,load,in);
    wire dffin;

    Mux g0(dffin, load, out, in);
    DFF g1(out, clk, dffin);
endmodule  // 1-bit register.

module Register(output[15:0] out, input clk,load, input[15:0] in);
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
endmodule  // Register.

module RAM8K(output[15:0] out, input clk,load, input[12:0] address, input[15:0] in);
    reg[15:0] m[0:2**13-1];  // 0 ~ (2 ** 4 - 1) = 0 ~ 15
    assign out = m[address];

    always @(posedge clk) begin
        if (load) m[address] = in;
    end
endmodule  // RAM8K.

module RAM16K(output[15:0] out, input clk,load, input[13:0] address, input[15:0] in);
    reg[15:0] m[0:2**14-1];
    assign out = m[address];

    always @ (posedge clk) begin
        if(load) m[address] = in;
    end
endmodule  // RAM16K.

module PC(output[15:0] out, input clk,inc,load,reset, input[15:0] in);
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
