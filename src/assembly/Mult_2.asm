// Please refers to the "Mult.asm" for more information.
// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2],
// respectively.)

    @343
    D=A
    @R0
    M=D    // R0 = 343
    @7
    D=A
    @R1
    M=D    // R1 = 7
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
