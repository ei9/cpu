module ram(
    output [31:0] out,
    input         clk,
    input         write,
    input  [31:0] address,
    input  [31:0] in
);

    reg [31:0] m[0:511];  // 32 x 512 = 16384 = 2kB
    assign out = m[address];

    always @ (posedge clk) begin
        if (write)
            m[address] <= in;
    end
endmodule  // ram


module rom(
    output [31:0] out,
    input  [31:0] address
);

    reg [31:0] m[0:1023];  // 32 x 1024 = 4kB
    // discard last 2 bits to perform shift right (>>2 == /4)
    assign out = m[address[31:2]];
endmodule  // rom


// ----------------------------------------------------------------------------
// modules inside rv32i
// ----------------------------------------------------------------------------

/*
 * sign  s1  s0  out
 *  0    0   0   w(32-bit)
 *  0    1   0   hu(16-bit)
 *  1    1   0   h(16-bit)
 *  0    1   1   bu(8-bit)
 *  1    1   1   b(8-bit)
 */
module ram_mask(
    output [31:0] out,
    input         sign,
    input         s1,
    input         s0,
    input  [31:0] in
);

    assign out[31:16] = s1 ? {16{sign}} : in[31:16];
    assign out[15:8]  = s0 ? {8 {sign}} : in[15:8];
    assign out[7:0]   = in[7:0];
endmodule  // ram_mask select byte, half-word, word


module reg_file(
    output [31:0] out_x,
    output [31:0] out_y,
    input  [4:0]  addr_x,
    input  [4:0]  addr_y,
    input         clk,
    input         write,
    input  [4:0]  write_addr,
    input  [31:0] write_data
);

    reg [31:0] regs[0:31];   // 31 general purpose register.

    assign out_x = (~|addr_x) ? 32'b0 : regs[addr_x];
    assign out_y = (~|addr_y) ? 32'b0 : regs[addr_y];

    always @(posedge clk) begin
        if((|write_addr) & write)
            regs[write_addr] <= write_data;
    end
endmodule  // register file


module alu(
    output [31:0] out,
    output        zero,
    input  [2:0]  alu_op,
    input         alt,
    input  [31:0] x,
    input  [31:0] y
);

    assign zero = ~|out;

    reg [31:0] out;

    always @(alu_op, alt, x, y) begin
        case(alu_op)
            3'b000:  // sub or add
                out = alt ? (x - y) : (x + y);
            3'b001:  // sll
                out <= x << y[4:0];
            3'b010:  // slt
                out <= (x[31] ^ y[31]) ? x[31] : (x[30:0] < y[30:0]);
            3'b011:  // sltu
                out <= x < y;
            3'b100:  // xor
                out <= x ^ y;
            3'b101:  // sra or srl
                out <= alt ? {x[31], x[30:0] >> y[4:0]} :  x >> y[4:0];
            3'b110:  // or
                out <= x | y;
            3'b111:  // and
                out <= x & y;
            default:
                out <= x & y;
        endcase
    end
endmodule  // alu


module branch_comp(
    output eq,
    output lt,
    input  unsign,
    input [31:0] a,
    input [31:0] b
);

    assign eq = a == b;
    assign lt = unsign ? (a < b) : ($signed(a) < $signed(b));
endmodule  // branch comparator


// control bus:
// 16  ram mask sign
// 15  ram mask s1
// 14  ram mask s0
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
    output [15:0] out,
    input  [31:0] ins
);

    wire [6:0]  opcode = ins[6:0];
    wire [6:0]  funt7  = ins[31:25];
    wire [2:0]  funt3  = ins[14:12];

    reg  [15:0] out;

    always @(*) begin
        case(opcode)
            `R_TYPE: begin
                case(funt3)
                    3'h0: begin
                        if(funt7[5])
                            out <= 16'h206;   // sub
                        else
                            out <= 16'h202;   // add
                    end
                    3'h1:   out <= 16'h208;   // sll
                    3'h2:   out <= 16'h209;   // slt
                    3'h3:   out <= 16'h20a;   // sltu
                    3'h4:   out <= 16'h207;   // xor.
                    3'h5: begin
                        if(funt7[5])
                            out <= 16'h20c;   // sra
                        else
                            out <= 16'h20b;   // srl
                    end
                    3'h6:   out <= 16'h201;   // or
                    3'h7:   out <= 16'h200;   // and
                    default:
                            out <= 16'h200;   // and
                endcase
            end

            `I_IMM: begin
                case(funt3)
                    3'h0:   out <= 16'h212;   // addi
                    3'h1:   out <= 16'h218;   // slli
                    3'h2:   out <= 16'h219;   // slti
                    3'h3:   out <= 16'h21a;   // sltiu
                    3'h4:   out <= 16'h217;   // xori
                    3'h5: begin
                        if(funt7[5])
                            out <= 16'h21c;   // srai
                        else
                            out <= 16'h21b;   // srli
                    end
                    3'h6:   out <= 16'h211;   // ori
                    3'h7:   out <= 16'h210;   // andi
                    default:
                            out <= 16'h210;   // andi
                endcase
            end

            `U_LUI:         out <= 16'h21e;   // lui
            `U_AUIP:        out <= 16'h232;   // auipc
            `J_TYPE:        out <= 16'he6d;   // jal
            `I_JALR:        out <= 16'h1212;  // jalr

            `B_TYPE: begin
                case(funt3)
                    3'h0:   out <= 16'h407;   // beq
                    3'h1:   out <= 16'h403;   // bne
                    3'h4:   out <= 16'h404;   // blt
                    3'h5:   out <= 16'h409;   // bge
                    3'h6:   out <= 16'h405;   // bltu
                    3'h7:   out <= 16'h40a;   // bgeu
                    default:
                            out <= 16'h40a;   // bgeu
                endcase
            end

            `I_LOAD: begin
                case(funt3)
                    3'h0:   out <= 16'he312;  // lb
                    3'h1:   out <= 16'hc312;  // lh
                    3'h2:   out <= 16'h312;   // lw
                    3'h4:   out <= 16'h6312;  // lbu
                    3'h5:   out <= 16'h4312;  // lhu
                    default:
                            out <= 16'h4312;  // lhu
                endcase
            end

            `S_TYPE: begin
                case(funt3)
                    3'h0:   out <= 16'h6092;  // sb
                    3'h1:   out <= 16'h4092;  // sh
                    3'h2:   out <= 16'h92;    // sw
                    default:
                            out <= 16'h92;    // sw
                endcase
            end

            default:        out <= 16'h0;     // Not supported instruction.
        endcase
    end
endmodule  // ctrl unit


module imm_gen(
    output [31:0] out,
    input  [31:0] in
);

    reg  [31:0] out;
    wire [6:0]  opcode = in[6:0];

    always @(*) begin
        case(opcode)
            `I_JALR, `I_LOAD, `I_IMM:
                out <= {{20{in[31]}}, in[31:20]};
            `S_TYPE:
                out <= {20'b0, in[31:25], in[11:7]};
            `B_TYPE:
                out <= {20'b0, in[31], in[7], in[30:25], in[11:8], 1'b0};
            `U_AUIP, `U_LUI:
                out <= {in[31:12], 12'b0};
            default:  //`J_TYPE:
                out <= {12'b0, in[31], in[19:12], in[20], in[30:21], 1'b0};
        endcase
    end
endmodule  // generate immediate value


module rv32i(
    output [31:0] dmem_addr_o,
    input  [31:0] dmem_r_data_i,
    output        dmem_w_o,
    output [31:0] dmem_w_data_o,
    input         reset,
    input         clk,
    output [31:0] imem_addr_o,
    input  [31:0] imem_r_data_i
);

// ----------------------------------------------------------------------------
// wires, regs, assignments
// ----------------------------------------------------------------------------

    // ctrl bus:
    wire ram_mask_sign = ctrl[15];  // ram mask sign
    wire ram_mask_s1   = ctrl[14];  // ram mask s1
    wire ram_mask_s0   = ctrl[13];  // ram mask s2
    wire jalr          = ctrl[12];  // jalr
    wire pc_src        = ctrl[11];  // pc_src, jal or B-type
    wire branch        = ctrl[10];  // branch
    wire reg_write     = ctrl[9];   // reg_write
    wire mem_alu_2_reg = ctrl[8];   // mem(1) or alu(0) saved to register
    wire dmem_w_o      = ctrl[7];   // write data to memory
    wire alu_r1_src_pc = ctrl[6];   // alu r1 pc source(0: pc, 1: pc+4)
    wire alu_r1_src    = ctrl[5];   // alu r1 source(0:r1, 1:pc)
    wire alu_r2_src    = ctrl[4];   // alu r2 source(0:r2, 1:imm)
    wire [3:0] alu_op  = ctrl[3:0]; // alu op

    // program counter
    reg  [31:0] new_pc;
    reg  [31:0] pc;
    wire [31:0] ins;

    // register file
    wire [31:0] r1, r2;
    wire [4:0]  r_addr;
    wire [31:0] r_data;

    // alu
    wire [31:0] alu_out, alu_x, alu_y;
    wire [31:0] dmem_i_masked;
    wire [15:0] ctrl;
    wire        zero;

    // imm_gen
    wire [31:0] imm;

    assign r_addr = ins[11:7];

    assign r_data = jalr ?
                        (pc + 4) :
                        (mem_alu_2_reg ? dmem_i_masked : alu_out);

    assign alu_x  = alu_r1_src ? (alu_r1_src_pc ? pc + 4 : pc) : r1;
    assign alu_y  = alu_r2_src ? imm : r2;

// ----------------------------------------------------------------------------
// ports
// ----------------------------------------------------------------------------

    // to instruction memory
    assign imem_addr_o   = pc;
    assign ins           = imem_r_data_i;

    // to data memory
    assign dmem_addr_o   = alu_out;


// ----------------------------------------------------------------------------
// instance
// ----------------------------------------------------------------------------

    reg_file rf(
        .out_x      (r1             ),
        .out_y      (r2             ),
        .addr_x     (ins[19:15]     ),
        .addr_y     (ins[24:20]     ),
        .clk        (clk            ),
        .write      (reg_write      ),
        .write_addr (r_addr         ),
        .write_data (r_data         )
    );

    alu a(
        .out        (alu_out        ),
        .zero       (zero           ),
        .alu_op     (alu_op         ),
        .x          (alu_x          ),
        .y          (alu_y          )
    );

    // data memory input through mask
    ram_mask  dm_r_mask(
        .out        (dmem_i_masked  ),
        .sign       (ram_mask_sign  ),
        .s1         (ram_mask_s1    ),
        .s0         (ram_mask_s0    ),
        .in         (dmem_r_data_i  )
    );

    // cpu data to ram through mask
    ram_mask  dm_w_mask(
        .out        (dmem_w_data_o  ),
        .sign       (1'b0           ),
        .s1         (ram_mask_s1    ),
        .s0         (ram_mask_s0    ),
        .in         (r2             )
    );

    ctrl_unit cu(
        .out        (ctrl           ),
        .ins        (ins            )
    );

    imm_gen ig(
        .out        (imm            ),
        .in         (ins            )
    );


// ----------------------------------------------------------------------------
// program counter
// ----------------------------------------------------------------------------

    always @(posedge clk) begin
        if(reset) begin
            new_pc <= 32'b0;
            pc     <= 32'b0;
        end else begin
            pc <= new_pc;

            // new_pc = jalr ?
            //          (x[rs1] + imm) & ~1 :
            //              (pc_src | (branch & zero)) ?
            //                  pc + imm : pc + 4;
            new_pc <= jalr ?
                    {alu_out[31:1], 1'b0} :
                        ((pc_src | (branch & zero)) ?
                            pc + imm : pc + 4);
        end
    end
endmodule  // rv32i
