`include "rv32i.v"

module tb_alu;
    reg[3:0] op;
    reg[31:0] i1;
    reg[31:0] i2;
    wire zero;
    wire[31:0] out;

    alu a(out, zero, op, i1, i2);

    initial begin
        $monitor("%2d op=%h i1=%h i2=%h zero=%b out=%h", $time,op,i1,i2,zero,out);
        op = 4'b0;
        i1 = 32'h0000ffff;
        i2 = 32'hffff0000;

        #1 op = 4'd0;  // and
        #1 op = 4'd1;  // or
        #1 op = 4'd2;  // add
        #1 op = 4'd6;  // sub
    end

    initial #5 $finish;
endmodule  // tb_alu