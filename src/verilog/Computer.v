/*
 * Changed from: https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/computer.v
 */

`include "alu.v"
`include "memory.v"

module CPU(output writeM, output[15:0] outM, output[14:0] addressM,pc, input clk,reset, input[15:0] inM,I);
    wire[15:0] Ain, Aout, AorM, ALUout, Dout, pcOut, addressMOut;

    reg[15:0] A, D;
    assign Aout = A;
    assign Dout = D;

    // PC load.
    wire g = ~(ng | zr);            // g = out > 0 = !(ng|zr)
    wire passLT = ng & I[2];        // ngLT = (ng&LT) = out < 0
    wire passEQ = zr & I[1];        // zrEQ = (zr&EQ) = out == 0
    wire passGT = g & I[0];         // gGT = (g&GT) = out > 0
    wire passLE = passLT | passEQ;  // out <= 0
    wire pass = passLE | passGT;    // out <=> 0

    wire PCload = I[15] & pass;     // PCload = I15&J

    // 16-bit ALU.
    assign AorM = I[12] ? inM : Aout;

    ALU16 alu(ALUout, zr, ng, Dout, AorM, I[11], I[10], I[9], I[8], I[7], I[6]);

    PC pc0(pcOut, clk, 1'b1, PCload, reset, Aout);
    assign pc = pcOut[14:0];

    // Address register.
    wire Atype = ~I[15];          // A-instruction
    wire AluToA = I[15] & I[5];   // AluToA = I[15] & d1
    wire Aload = Atype | AluToA;  // A-instruction or data load to A-register

    assign Ain = AluToA ? ALUout : I;

    // Data register.
    wire Dload = I[15] & I[4];  // Dload = I[15] & d2

    // output
    assign addressM = Aout[14:0];
    wire writeM = I[15] & I[3];  // writeM = I[15] & d3
    assign outM = ALUout;

    always @ (posedge clk) begin
        if(Aload)  A = Ain;
        if(Dload)  D = ALUout;
    end
endmodule  // CPU.

module Memory(output[15:0] out, input clk,load, input[15:0] in, input[14:0] address);
    reg[15:0] m[0:24591];  // 16k + 8k + 16bit - 1 = 2 ^ 14 + 2 ^ 13 + 16 - 1 = 24591
    assign out = m[address];

    always @ (posedge clk) begin
        if(load)  m[address] = in;
    end
endmodule  // Memory.

module Computer(input clk, reset);
    wire[15:0] inM, outM, I;
    wire[14:0] addressM, pc;

    Memory ram(inM, clk, writeM, outM, addressM);
    ROM32K rom(I, pc);
    CPU    cpu(writeM, outM, addressM,pc, clk,reset, inM,I);
endmodule  // Computer.
