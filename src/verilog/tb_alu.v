`include "alu.v"

module tb_alu;

    reg[5:0] ins;  // zx, nx, zy, ny, f, no;
    reg[15:0] x, y;
    wire[15:0] out;
    wire zr, ng;

    ALU16 g0(out, zr, ng, x, y, ins[5], ins[4], ins[3], ins[2], ins[1], ins[0]);

    initial begin
        $dumpfile("tb_alu.vcd");
        $dumpvars(0, g0);
        $monitor("%4dns x = %d, y = %d, out = %d, zr = %b, ng = %b", $stime, x, y, out, zr, ng);

        x = 100;
        y = 3;

        #1 ins = 6'b101010;  // 0
        #1 ins = 6'b111111;  // 1
        #1 ins = 6'b111010;  // -1
        #1 ins = 6'b001100;  // x
        #1 ins = 6'b110000;  // y
        #1 ins = 6'b001101;  // !x
        #1 ins = 6'b110001;  // !y
        #1 ins = 6'b001111;  // -x
        #1 ins = 6'b110011;  // -y
        #1 ins = 6'b011111;  // x + 1;
        #1 ins = 6'b110111;  // y + 1;
        #1 ins = 6'b001110;  // x - 1;
        #1 ins = 6'b110010;  // y - 1;
        #1 ins = 6'b000010;  // x + y
        #1 ins = 6'b010011;  // x - y
        #1 ins = 6'b000111;  // y - x
        #1 ins = 6'b000000;  // x & y
        #1 ins = 6'b010101;  // x | y
        #1 $finish;
    end

endmodule // alu_test
