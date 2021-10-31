`include "rv32i.v"

/*
 * Only test some opcode.
 */
module tb_alu;
    reg[3:0] op;
    reg[31:0] i1;
    reg[31:0] i2;
    wire zero;
    wire[31:0] out;

    alu a(
        .out    (out  ),
        .zero   (zero ),
        .alu_op (op   ),
        .x      (i1   ),
        .y      (i2   )
    );

    initial begin
        $monitor("%2d op=%h i1=%h i2=%h zero=%b out=%h", $time,op,i1,i2,zero,out);
        op = 4'b0;
        i1 = 32'h0000ffff;
        i2 = 32'hffff0000;

        #1 op = 4'h0;  // and
        #1 op = 4'h1;  // or
        #1 op = 4'h2;  // add
        #1 op = 4'h6;  // sub
        #1 op = 4'h7;  // xor

        #1 i1 = 32'h8000f000;
           i2 = 32'h00000004;
           op = 4'h8;  // sll  000f0000
        #1 op = 4'h9;  // slt  00000001
        #1 op = 4'ha;  // sltu 00000000
        #1 op = 4'hb;  // srl  08000f00
        #1 op = 4'hc;  // sra  80000f00
    end

    initial #10 $finish;
endmodule  // tb_alu