;Two 16-bit binary number subtraction.
;This program is written in 8051 assembly.

          mov  0x11,#0x12  ;minuend high byte
          MOV  0x10,#0x34  ;minuend low byte
          MOV  0x21,#0x56  ;subtrahend high byte
          MOV  0x20,#0x78  ;subtrahend low byte

SUB_BIN:  MOV  R0,#0x10    ;16-bit minuend
          MOV  R1,#0x20    ;16-bit subtrahend
          MOV  R2,#0x2     ;2 bytes
          CLR  C
NEXT:     MOV  A,@R0
          SUBB A,@R1
          MOV  @R0,A
          INC  R0
          INC  R1
          DJNZ R2,NEXT
          RET
