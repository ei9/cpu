// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2],
// respectively.)

// Put your code here.

// R2 = R0 * R1
// ans = a * b
//
// a = R0;
// b = R1;
// ans = 0;
// for(int i = 0 ; i < b ; i++){
//     ans += a;
// }
//
// -------------------------------------------------
//
//     i = 0
//
// LOOP:
//     if i == R1 goto END
//     R2 = R2 + R0
//     i = i + 1
//     goto LOOP
//
// END:

    @i
    M=0    // i = 0
    @R2
    M=0    // R2 = 0

(LOOP)
    @i
    D=M    // D = i
    @R1
    D=D-M  // D = i - RAM[1]
    @END
    D;JEQ  // if (i - RAM[1]) == 0 goto END

    @R0
    D=M    // D = RAM[0]
    @R2
    M=M+D  // RAM[2] = RAM[2] + RAM[0]
    @i
    M=M+1  // i += 1

    @LOOP
    0;JMP  // goto LOOP

(END)
    @END
    0;JMP
