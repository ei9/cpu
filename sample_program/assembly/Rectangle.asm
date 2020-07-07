// Program: Rectangle.asm
// Draws a filled rectangle at the screen's top left
// corner, with width of 16pixels and height of RAM[0]
// pixels.
// Usage: put a non-negative number (rectangle's
// height) in RAM[0].
//
// Screen width = 512, height = 256
// 512 / 16 = 32
//
// addr = SCREEN;
// n = R0;
// for(int i = 0 ; i < n ; i++){
//     RAM[addr] = -1;
//     addr += 32;
// }
//
// ---------------------------------------------------
//
//     addr = SCREEN
//     n = R0
//     i = 0
//
// LOOP:
//     if (i - n) == 0 goto END
//     RAM[addr] = -1
//     addr = addr + 32
//     i = i + 1
//     goto LOOP
//
// END:

    @SCREEN
    D=A
    @addr
    M=D      // addr = SCREEN

    @R0
    D=M
    @n
    M=D      // n = RAM[0]

    @i
    M=0      // i = 0

(LOOP)
    @i
    D=M      // D = i
    @n
    D=D-M    // D = i - n
    @END
    D;JEQ    // if (i - n) == 0 goto END


    @addr
    A=M      // addr as address
    M=-1     // RAM[addr] = -1

    @32
    D=A      // D = 32
    @addr
    M=M+D    // addr += 32

    @i
    M=M+1    // i += 1

    @LOOP
    0;JMP    // goto LOOP

(END)
    @END
    0;JMP
