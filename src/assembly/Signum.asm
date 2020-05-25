// Program: Signum.asm
// Computes: if R0 > 0
//               R1 = 1
//           else
//               R1 = 0
// Usage: Put a value in RAM[0],
//        run and inspect RAM[1].

    @R0
    D=M    // D = RAM[0]

    @POSITIVE
    D;JGT  // if D > 0 goto 8

    @R1    // else
    M=0    // RAM[1] = 0
    @END
    0;JMP  // goto end

(POSITIVE)
    @R1
    M=1    // RAM[1] = 1

(END)
    @10
    0;JMP  // infinity loop (end)
