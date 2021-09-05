module ram(output[31:0] out, input clk,load, input[31:0] address,in);
    reg[31:0] m[0:1023];  // 32 x 1k ram
    assign out = m[address];

    always @ (posedge clk) begin
        if (load)
            m[address] = in;
    end
endmodule  // ram


module rom(output[31:0] out, input[31:0] address);
    reg[31:0] m[0:1023];
    assign out = m[address];
endmodule  // rom


module rv32i(output writeM, output[31:0] pc,addressM,outM, input clk,reset, input[31:0] inM,ins);
    reg[31:0] pc;           // program counter.
    reg[31:0] gpr[0:31];    // 32 general purpose register.

    // x0 is always 0.
    initial begin
        gpr[0] = 32'h0;
    end

endmodule  // cpu

module computer(input clk);

endmodule  // computer
