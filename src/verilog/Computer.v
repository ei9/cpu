/*
 * Changed from: https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/computer.v
 */

`include "memory.v"

module CPU(output writeM, output[15:0] outM, output[14:0] addressM,pc, input clk,reset, input[15:0] inM,I);
    wire[15:0] Ain, Aout, AorM, ALUout, Dout, pcOut, addressMOut;

    // PC load.
    or  g0(ngzr, ng, zr);  // ngzr = ng | zr
    not g1(g, ngzr);       // g = out > 0 = !(ng|zr)
    and g2(passLT, ng, I[2]);  // ngLT = (ng&LT) = out < 0
    and g3(passEQ, zr, I[1]);  // zrEQ = (zr&EQ) = out = 0
    and g4(passGT, g, I[0]);  // gGT = (g&GT) = out > 0
    or  g5(passLE, passLT, passEQ);  // out <= 0
    or  g6(pass, passLE, passGT);  // out <=> 0

    and g7(PCload, I[15], pass);  // PCload = I15&J

    // 16-bit ALU.
    Mux16 g8(AorM, I[12], Aout, inM); // Mux ALU in : cAorM = I[12]

    ALU16 alu(ALUout, zr, ng, Dout, AorM, I[11], I[10], I[9], I[8], I[7], I[6]);

    PC pc0(pcOut, clk, 1'b1, PCload, reset, Aout);
    assign pc = pcOut[14:0];

    // Address register.
    not g9(Atype, I[15]);  // A-instruction
    and g10(AluToA, I[15], I[5]);  // AluToA = I[15] & d1
    or  g11(Aload, Atype, AluToA);  // A-instruction or load to A-register

    Mux16 g12(Ain, AluToA, I, ALUout);  // sel = I[15]
    Register A(Aout, clk, Aload, Ain);

    // Data register.
    and g13(Dload, I[15], I[4]);  // Dload = I[15] & d2
    Register D(Dout, clk, Dload, ALUout);

    // output
    assign addressM = Aout[14:0];
    and g14(writeM, I[15], I[3]);  // writeM = I[15] & d3
    And16 g15(outM, ALUout, ALUout);  // Just a buffer;
endmodule  // CPU.

module Memory(output[15:0] out, input clk,load, input[15:0] in, input[14:0] address);
    wire[15:0] outM, outS, outK, outSK;

    not g0(N14, address[14]);  // ram[13:0]
    and g1(Mload, N14, load);  // Load ram.
    and g2(Sload, address[14], load);  // Load screen.

    RAM16K ram(outM, clk, Mload, address[13:0], in);
    RAM8K  screen(outS, clk, Sload, address[12:0], in);
    Register keyboard(outK, clk, 1'b0, 16'h0f0f);  // Read-only keyboard.

    Mux16 g3(out, address[14], outM, outSK);
    Mux16 g4(outSK, address[13], outS, outK);
endmodule  // Memory.

module Computer(input clk, reset);
    wire[15:0] inM, outM, I;
    wire[14:0] addressM, pc;

    Memory ram(inM, clk, writeM, outM, addressM);
    ROM32K rom(I, pc);
    CPU    cpu(writeM, outM, addressM,pc, clk,reset, inM,I);
endmodule  // Computer.