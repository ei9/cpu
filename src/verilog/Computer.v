/*
 * Changed from: https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/computer.v
 */

`include "memory.v"

module CPU(output writeM, output[15:0] outM, output[14:0] addressM,pc, input clk,reset, input[15:0] inM,I);
    wire[15:0] Ain, Aout, AorM, ALUout, Dout, pcOut, addressMOut;

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
    Register A(Aout, clk, Aload, Ain);

    // Data register.
    wire Dload = I[15] & I[4];  // Dload = I[15] & d2
    Register D(Dout, clk, Dload, ALUout);

    // output
    assign addressM = Aout[14:0];
    wire writeM = I[15] & I[3];  // writeM = I[15] & d3
    assign outM = ALUout;
endmodule  // CPU.

module Memory(output[15:0] out, input clk,load, input[15:0] in, input[14:0] address);
    wire[15:0] outM, outS, outK, outSK;

    wire Mload = (~address[14]) & load;  // Load ram (ram[13:0]).
    wire Sload = address[14] & load;   // Load screen.

    RAM16K ram(outM, clk, Mload, address[13:0], in);
    RAM8K  screen(outS, clk, Sload, address[12:0], in);
    Register keyboard(outK, clk, 1'b0, 16'h0f0f);  // Read-only keyboard.

    assign out = address[14] ? outSK : outM;
    assign outSK = address[13] ? outK : outS;
endmodule  // Memory.

module Computer(input clk, reset);
    wire[15:0] inM, outM, I;
    wire[14:0] addressM, pc;

    Memory ram(inM, clk, writeM, outM, addressM);
    ROM32K rom(I, pc);
    CPU    cpu(writeM, outM, addressM,pc, clk,reset, inM,I);
endmodule  // Computer.
