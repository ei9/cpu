`include "alu.v"

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
        if (reset)
            m = 16'b0;
        else if (load)
            m = in;
        else if (inc)
            m = m + 1'b1;
    end
endmodule  // 16-bit program counter.

module ROM32K(output[15:0] out, input[14:0] address);
    reg[15:0] m[0:2**15-1];
    assign out = m[address];
endmodule  // ROM32K.
