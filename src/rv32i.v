module ram(
    out,
    clk,
    read,
    write,
    address,
    in
);

    output[31:0] out;
    input clk, read, write;
    input[31:0] address, in;

    reg[31:0] m[0:511];  // 32 x 512 = 16384 = 2kB
    assign out = read ? m[address] : 32'bz;

    always @ (posedge clk) begin
        if (write)
            m[address] = in;
    end
endmodule  // ram


module rom(
    out,
    address
);

    output[31:0] out;
    input[31:0] address;

    reg[31:0] m[0:1023];  // 32 x 1024 = 4kB
    // discard last 2 bits to perform shift right (>>2 == /4)
    assign out = m[address[31:2]];
endmodule  // rom


module reg_file(
    out_1,
    out_2,
    clk,
    write,
    write_addr,
    write_data,
    addr_1,
    addr_2
);

    output[31:0] out_1, out_2;
    input clk, write;
    input[4:0] write_addr, addr_1, addr_2;
    input[31:0] write_data;

    reg[31:0] regs[0:31];   // 31 general purpose register.
    assign out_1 = (~|addr_1) ? 32'b0 : regs[addr_1];
    assign out_2 = (~|addr_2) ? 32'b0 : regs[addr_2];

    always @(posedge clk) begin
        if((|write_addr) & write)
            regs[write_addr] = write_data;
    end
endmodule  // register file


// operation | opcode
//    and    |  0000
//    or     |  0001
//    add    |  0010
//    sub    |  0110
`define AND 4'b0000
`define OR  4'b0001
`define ADD 4'b0010
`define SUB 4'b0110

module alu(
    out,
    zero,
    alu_op,
    in_1,
    in_2
);

    output[31:0] out;
    output zero;
    input[3:0] alu_op;
    input[31:0] in_1, in_2;

    assign zero = ~|out;

    reg[31:0] out;

    always @(alu_op, in_1, in_2) begin
        case(alu_op)
            `AND:
                out = in_1 & in_2;
            `OR:
                out = in_1 | in_2;
            `ADD:
                out = in_1 + in_2;
            `SUB:
                out = in_1 - in_2;
            default:  // AND operation
                out = in_1 & in_2;
        endcase
    end
endmodule  // alu


// control bus:
// 10  reg_write
// 9   alu select r2(1) or imm(0)
// 8   mem read
// 7   mem write
// 6   branch
// 5   mem or alu save to register
// 3~0 alu ctrl
module ctrl_unit(
    out,
    clk,
    ins
);

    output[10:0] out;
    input clk;
    input[31:0] ins;

endmodule  // ctrl unit


module rv32i(
    clk
);

    input clk;

    reg[31:0] pc;  // program counter.

    wire[31:0] ins, r1, r2, r_data, alu_out, alu_in_2, imm, ram_out;
    wire[10:0] ctrl;
    wire[4:0] r_addr;
    wire zero;

    assign imm = 32'b0; // TODO: generate imm
    assign alu_in_2 = ctrl[9] ? r2 : imm;

    rom       im(ins, pc);
    reg_file  rf(r1, r2, clk, ctrl[10], r_addr, r_data, ins[19:15], ins[24:20]);
    alu       a(alu_out, zero, ctrl[3:0], r1, alu_in_2);
    ram       dm(ram_out, clk, ctrl[8], ctrl[7], alu_out, r2);
    ctrl_unit cu(ctrl, clk, ins);
endmodule  // rv32i
