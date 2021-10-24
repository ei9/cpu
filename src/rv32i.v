module ram(
    out,
    clk,
    write,
    address,
    in
);

    output[31:0] out;
    input clk, read, write;
    input[31:0] address, in;

    reg[31:0] m[0:511];  // 32 x 512 = 16384 = 2kB
    assign out = m[address];

    always @ (posedge clk) begin
        if (write)
            m[address] = in;
    end
endmodule  // ram


/*
 * sign  s1  s0  out
 *  0    0   0   w(32-bit)
 *  0    1   0   hu(16-bit)
 *  1    1   0   h(16-bit)
 *  0    1   1   bu(8-bit)
 *  1    1   1   b(8-bit)
 */
module ram_mask(
    out,
    sign,
    s1,
    s0,
    in
);

    output[31:0] out;
    input sign, s1, s0;
    input[31:0] in;

    assign out[31:16] = s1 ? (sign ? 16'hffff : 16'h0000) : in[31:16];
    assign out[15:8]  = s0 ? (sign ? 8'hff : 8'h00) : in[15:8];
    assign out[7:0]   = in[7:0];
endmodule  // ram_mask select byte, half-word, word


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


// operation opcode
`define AND  4'b0000
`define OR   4'b0001
`define ADD  4'b0010
`define EQU  4'b0011
`define SGE  4'b0100
`define SGEU 4'b0101
`define SUB  4'b0110
`define XOR  4'b0111
`define SLL  4'b1000
`define SLT  4'b1001
`define SLTU 4'b1010
`define SRL  4'b1011
`define SRA  4'b1100
`define IN1  4'b1101
`define IN2  4'b1110

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
            `EQU:
                out = in_1 == in_2;
            `SGE:
                out = (in_1[31] ^ in_2[31]) ? in_2[31] : (in_1[30:0] >= in_2[30:0]);
            `SGEU:
                out = in_1 >= in_2;
            `SUB:
                out = in_1 - in_2;
            `XOR:
                out = in_1 ^ in_2;
            `SLL:
                out = in_1 << in_2[4:0];
            `SLT:
                out = (in_1[31] ^ in_2[31]) ? in_1[31] : (in_1[30:0] < in_2[30:0]);
            `SLTU:
                out = in_1 < in_2;
            `SRL:
                out = in_1 >> in_2[4:0];
            `SRA:
                out = {in_1[31], in_1[30:0] >> in_2[4:0]};
            `IN1:
                out = in_1;
            `IN2:
                out = in_2;
            default:  // AND operation
                out = in_1 & in_2;
        endcase
    end
endmodule  // alu


// control bus:
// 16  ram mask sign
// 15  ram mask s1
// 14  ram mask s2
// 13  jalr
// 12  pc_src, jal or B-type
// 11  branch
// 10  reg_write
// 9   mem(1) or alu(0) saved to register
// 8   write data to memory
// 7   read data from memory
// 6   alu r1 pc source(0: pc, 1: pc+4)
// 5   alu r1 source(0:r1, 1:pc)
// 4   alu r2 source(0:r2, 1:imm)
// 3:0 alu op
`define U_LUI  7'h37
`define U_AUIP 7'h17
`define J_TYPE 7'h6f
`define I_JALR 7'h67
`define B_TYPE 7'h63
`define I_LOAD 7'h03
`define S_TYPE 7'h23
`define I_IMM  7'h13  // I-type immediate
`define R_TYPE 7'h33
`define I_FENC 7'h0f
`define I_SYS  7'h73

module ctrl_unit(
    out,
    ins
);

    output[16:0] out;
    input[31:0] ins;

    wire[6:0] opcode = ins[6:0];
    wire[6:0] funt7 = ins[31:25];
    wire[2:0] funt3 = ins[14:12];

    reg[16:0] out;

    always @(*) begin
        case(opcode)
            `R_TYPE: begin
                case(funt3)
                    3'h0: begin
                        if(funt7[5])
                            out = 17'h406;  // sub
                        else
                            out = 17'h402;  // add
                    end
                    3'h1:
                        out = 17'h408;  // sll
                    3'h2:
                        out = 17'h409;  // slt
                    3'h3:
                        out = 17'h40a;  // sltu
                    3'h4:
                        out = 17'h407;  // xor.
                    3'h5: begin
                        if(funt7[5])
                            out = 17'h40c;  // sra
                        else
                            out = 17'h40b;  // srl
                    end
                    3'h6:
                        out = 17'h401;  // or
                    3'h7:
                        out = 17'h400;  // and
                    default:
                        out = 17'h400;  // and
                endcase
            end
            `I_IMM: begin
                case(funt3)
                    3'h0:
                        out = 17'h412;  // addi
                    3'h1:
                        out = 17'h418;  // slli
                    3'h2:
                        out = 17'h419;  // slti
                    3'h3:
                        out = 17'h41a;  // sltiu
                    3'h4:
                        out = 17'h417;  // xori
                    3'h5: begin
                        if(funt7[5])
                            out = 17'h41c;  // srai
                        else
                            out = 17'h41b;  // srli
                    end
                    3'h6:
                        out = 17'h411;  // ori
                    3'h7:
                        out = 17'h410;  // andi
                    default:
                        out = 17'h410;  // andi
                endcase
            end
            `U_LUI: begin
                out = 17'h41e;  // lui
            end
            `U_AUIP: begin
                out = 17'h432;  // auipc
            end
            `J_TYPE: begin
                out = 17'h1c6d;  // jal
            end
            `I_JALR: begin
                out = 17'h2412;  // jalr
            end
            `B_TYPE: begin
                case(funt3)
                    3'h0:
                        out = 17'h807;  // beq
                    3'h1:
                        out = 17'h803;  // bne
                    3'h4:
                        out = 17'h804;  // blt
                    3'h5:
                        out = 17'h809;  // bge
                    3'h6:
                        out = 17'h805;  // bltu
                    3'h7:
                        out = 17'h80a;  // bgeu
                    default:
                        out = 17'h80a;  // bgeu
                endcase
            end
            `I_LOAD: begin
                case(funt3)
                    3'h0:
                        out = 17'h1c692;  // lb
                    3'h1:
                        out = 17'h18692;  // lh
                    3'h2:
                        out = 17'h692;  // lw
                    3'h4:
                        out = 17'hc692;  // lbu
                    3'h5:
                        out = 17'h8692;  // lhu
                    default:
                        out = 17'h8692;  // lhu
                endcase
            end
            `S_TYPE: begin
                case(funt3)
                    3'h0:
                        out = 17'hc112;  // sb
                    3'h1:
                        out = 17'h8112;  // sh
                    3'h2:
                        out = 17'h112;  // sw
                    default:
                        out = 17'h112;  // sw
                endcase
            end
            default: begin
                out = 17'h0;  // Not supported instruction.
            end
        endcase
    end
endmodule  // ctrl unit


module imm_gen(
    out,
    in
);

    input[31:0] in;
    output[31:0] out;

    reg[31:0] out;
    wire[6:0] opcode = in[6:0];

    always @(*) begin
        case(opcode)
            `I_JALR, `I_LOAD, `I_IMM:
                out = {(in[31]?20'hfffff:20'h0), in[31:20]};
            `S_TYPE:
                out = {20'b0, in[31:25], in[11:7]};
            `B_TYPE:
                out = {20'b0, in[31], in[7], in[30:25], in[11:8], 1'b0};
            `U_AUIP, `U_LUI:
                out = {in[31:12], 12'b0};
            default:  //`J_TYPE:
                out = {12'b0, in[31], in[19:12], in[20], in[30:21], 1'b0};
        endcase
    end
endmodule  // generate immediate value


module rv32i(
    clk
);

    input clk;

    reg[31:0] pc;  // program counter.

    wire[31:0] ins, r1, r2, r_data, alu_out, alu_in_1, alu_in_2, imm, ram_out, ram_out_masked, ram_in;
    wire[16:0] ctrl;
    wire[4:0] r_addr;
    wire zero;

    assign r_addr = ins[11:7];
    // r_data = jalr ? pc + 4 : ctrl[9] ? ram_out_masked : alu_out;
    assign r_data = ctrl[13] ? (pc + 4) : (ctrl[9] ? ram_out_masked : alu_out);
    assign alu_in_1 = ctrl[5] ? (ctrl[6] ? pc + 4 : pc) : r1;
    assign alu_in_2 = ctrl[4] ? imm : r2;

    rom       im(ins, pc);
    reg_file  rf(r1, r2, clk, ctrl[10], r_addr, r_data, ins[19:15], ins[24:20]);
    alu       a(alu_out, zero, ctrl[3:0], alu_in_1, alu_in_2);
    ram       dm(ram_out, clk, ctrl[8], ctrl[7], alu_out, ram_in);
    ram_mask  dm_i(ram_out_masked, ctrl[16], ctrl[15], ctrl[14], ram_out);  // data memory out through mask
    ram_mask  dm_o(ram_in, 1'b0, ctrl[15], ctrl[14], r2);                   // alu to ram through mask
    ctrl_unit cu(ctrl, ins);
    imm_gen   ig(imm, ins);

    always @(posedge clk) begin
        // pc = jalr ? (x[rs1] + imm) & ~1 : (pc_src | (branch & zero)) ? pc + imm : pc + 4;
        pc = ctrl[13] ? {alu_out[31:1], 1'b0} : ((ctrl[12] | (ctrl[11] & zero)) ? pc + imm : pc + 4);
    end
endmodule  // rv32i
