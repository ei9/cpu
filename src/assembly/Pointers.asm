// Program: Pointers.asm
// Computes: arr[0:(n - 1)] = -1
// Usage: put a number (arr) in RAM[0] as pointer.
//        put a number (n) in RAM[1]
//
// arr = R0
// n = R1
//
// for (i = 0 ; i < n ; i++){
//     arr[i] = -1;
// }
//
// --------------------------
//
//     arr = R0
//     n = R1
//     i = 0
//
// LOOP:
//     if i == n goto END
//     RAM[arr + i] = -1
//     i = i + 1
//     goto LOOP
//
// END:

    @R0
    D=M
    @arr
    M=D    // arr = RAM[0]

    @R1
    D=M
    @n
    M=D    // n = RAM[1]

    @i
    M=0    // i = 0

(LOOP)
    @i
    D=M    // D = i
    @n
    D=D-M  // D = i - n
    @END
    D;JEQ  // (i - n) == 0

    @arr
    D=M    // D = arr
    @i
    A=D+M  // A = arr + i
    M=-1   // RAM[arr + i] = -1

    @i
    M=M+1  // i = i + 1

    @LOOP
    0;JMP  // goto LOOP

(END)
    @END
    0;JMP
