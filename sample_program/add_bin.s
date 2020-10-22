;Add two 16-bit binary number.
;This program is written in 8051 assembly.

          mov  0x11,#0x12  ;summand high byte
          MOV  0x10,#0x34  ;summand low byte
          MOV  0x21,#0x56  ;addend high byte
          MOV  0x20,#0x78  ;addend low byte

ADD_BIN:  MOV  R0,#0x10    ;16-bit summand
          MOV  R1,#0x20    ;16-bit addend
          MOV  R2,#0x2     ;2 bytes
          CLR  C
NEXT:     MOV  A,@R0
          ADDC A,@R1
          MOV  @R0,A
          INC  R0
          INC  R1
          DJNZ R2,NEXT
          RET
