/*
 * Changed from: https://github.com/cccbook/co/blob/master/code/verilog/nand2tetris/computer.v
 */

module CPU(output writeM, output[15:0] outM, output[14:0] addressM,pc, input clk,reset, input[15:0] inM,I);
    wire[15:0] Aout, AorM, ALUout, Dout;

    reg[15:0] A, D, pcReg;
    assign Aout = A;
    assign Dout = D;
    assign pc = pcReg[14:0];

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

    // I[11], x = 0
    wire[15:0] zx = I[11] ? 16'b0 : Dout;

    // I[10], x = ~x
    wire[15:0] nx = I[10] ? ~zx : zx;

    // I[9], y = 0
    wire[15:0] zy = I[9] ? 16'b0 : AorM;

    // I[8], y = !y
    wire[15:0] ny = I[8] ? ~zy : zy;

    // I[7] = 0, ALUout = x & y
    // I[7] = 1, ALUout = x + y
    wire[15:0] f = I[7] ? nx + ny : nx & ny;

    // I[6] = 0, ALUout = f
    // I[6] = 1, ALUout = ~f
    assign ALUout = I[6] ? ~f : f;

    // ALUout = 0, zr = 1
    wire zr = ALUout == 0;

    // ALUout < 0, ng = 1
    wire ng = ALUout[15];

    // output
    assign addressM = Aout[14:0];
    wire writeM = I[15] & I[3];  // writeM = I[15] & d3
    assign outM = ALUout;

    // Address register.
    wire Atype = ~I[15];          // A-instruction
    wire AluToA = I[15] & I[5];   // AluToA = I[15] & d1
    wire Aload = Atype | AluToA;  // A-instruction or data load to A-register

    // Data register.
    wire Dload = I[15] & I[4];  // Dload = I[15] & d2

    always @ (posedge clk) begin
        // Registers
        if(Aload)  A = AluToA ? ALUout : I;
        if(Dload)  D = ALUout;

        // Program Counter.
        if(reset)
            pcReg = 16'b0;
        else if(PCload)
            pcReg = Aout;
        else
            pcReg = pcReg + 1'b1;
    end
endmodule  // CPU.

module Memory(output[15:0] out, input clk,load, input[15:0] in, input[14:0] address);
    reg[15:0] m[0:24591];  // 16k + 8k + 16bit - 1 = 2 ^ 14 + 2 ^ 13 + 16 - 1 = 24591
    assign out = m[address];

    always @ (posedge clk) begin
        if(load)  m[address] = in;
    end
endmodule  // Memory.

module ROM32K(output[15:0] out, input[14:0] address);
    reg[15:0] m[0:2**15-1];
    assign out = m[address];
endmodule  // ROM32K.

module Computer(input clk, reset);
    wire[15:0] inM, outM, I;
    wire[14:0] addressM, pc;

    ROM32K rom(I, pc);
    CPU    cpu(writeM, outM, addressM,pc, clk,reset, inM,I);
    Memory ram(inM, clk, writeM, outM, addressM);
endmodule  // Computer.
