`include "ram.v"

/*
 * Changed from: https://github.com/cccbook/co/blob/1c86da267d19d5e2ec1b5e2dfcb6f53cac2cf74e/code/verilog/nand2tetris/computer.v#L18
 */
module CPU(outM, writeM, addressM, pc, clock, reset, inM, I);

    input clock, reset;
    input[15:0] inM, I;

    output[15:0] outM;
    output writeM;
    output[14:0] addressM, pc;

    wire[15:0] Ain, Aout, AorM, ALUout, Dout, pcOut, addressMOut;

    // PC load.
    Or  g0(ngzr, ng, zr);  // ngzr = ng | zr
    Not g1(g, ngzr);       // g = out > 0 = !(ng|zr)
    And g2(passLT, ng, I[2]);  // ngLT = (ng&LT) = out < 0
    And g3(passEQ, zr, I[1]);  // zrEQ = (zr&EQ) = out = 0
    And g4(passGT, g, I[0]);  // gGT = (g&GT) = out > 0
    Or  g5(passLE, passLT, passEQ);  // out <= 0
    or  g6(pass, passLE, passGT);  // out <=> 0

    And g7(PCload, I[15], pass);  // PCload = I15&J

    // 16-bit ALU.
    Mux16 g8(AorM, I[12], Aout, inM); // Mux ALU in : cAorM = I[12]

    ALU16 alu(.out(ALUout), .zr(zr), .ng(ng), .x(Dout), .y(AorM), .zx(I[11]), .nx(I[10]), .zy(I[9]), .ny(I[8]), .f(I[7]), .no(I[6]));

    PC pc0(.out(pcOut), .clk(clock), .inc(1'b1), .load(PCload), .reset(reset), .in(Aout));
    assign pc = pcOut[14:0];

    // Address register.
    Not g9(Atype, I[15]);  // A-instruction
    And g10(AluToA, I[15], I[5]);  // AluToA = I[15] & d1
    Or  g11(Aload, Atype, AluToA);  // A-instruction or load to A-register

    Mux16 g12(Ain, AluToA, I, ALUout);  // sel = I[15]
    Register A(Aout, clock, Aload, Ain);

    // Data register.
    And g13(Dload, I[15], I[4]);  // Dload = I[15] & d2
    Register D(Dout, clock, Dload, ALUout);

    // output
    assign addressM = Aout[14:0];
    And g14(writeM, I[15], I[3]);  // writeM = I[15] & d3
    And16 g15(outM, ALUout, ALUout);  // Just a buffer;

endmodule  // CPU
