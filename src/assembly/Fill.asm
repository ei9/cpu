// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// Screen width = 512, height = 256
// 512 / 16 = 32
// 32 * 256 = 8192

// screensize = 8192
// while(true){
//     if (keyboard_pressed)
//         // Blacken the screen
//         for(int i = 0 ; i < screensize ; i++)
//             RAM[SCREEN + i] = -1;
//     else
//         // Clear the screen
//         for(int i = 0 ; i < screensize ; i++)
//             RAM[SCREEN + i] = 0;
// }
//
// -------------------------------------------------------------------
//
//     screensize = 8192
//
// LOOP:
//     i = 0
//     if (KBD > 0) goto BLACKEN
//
// CLEAR:
//     if(i - screensize) == 0 goto LOOP
//     RAM[SCREEN + i] = 0
//     i = i + 1
//     goto CLEAR
//
// BLACKEN:
//     if(i - screensize) == 0 goto LOOP
//     RAM[SCREEN + i ] = -1
//     i = i + 1
//     goto BLACKEN

    @8192
    D=A
    @screensize
    M=D          // screensize = 8192

(LOOP)
    @i
    M=0          // i = 0
    @KBD
    D=M
    @BLACKEN
    D;JGT        // if(KBD > 0) goto BLACKEN

(CLEAR)
    @i
    D=M
    @screensize
    D=D-M
    @LOOP
    D;JEQ        // if (i - screensize) == 0 goto LOOP
    @SCREEN
    D=A
    @i
    A=D+M
    M=0          // RAM[SCREEN + i] = 0
    @i
    M=M+1        // i = i + 1
    @CLEAR
    0;JMP        // goto CLEAR

(BLACKEN)
    @i
    D=M
    @screensize
    D=D-M
    @LOOP
    D;JEQ        // if(i - screensize) == 0 goto LOOP
    @SCREEN
    D=A
    @i
    A=D+M
    M=-1         // RAM[SCREEN + i ] = -1
    @i
    M=M+1        // i = i + 1
    @BLACKEN
    0;JMP        // goto BLACKEN
