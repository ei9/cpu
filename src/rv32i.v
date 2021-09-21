module ram(
    out,
    clk,
    read,
    write,
    address,
    in);

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
    address);

    output[31:0] out;
    input[31:0] address;

    reg[31:0] m[0:1023];  // 32 x 1024 = 4kB
    assign out = m[address];
endmodule  // rom


module reg_file(
    out_1,
    out_2,
    clk,
    write,
    write_addr,
    write_data,
    addr_1,
    addr_2);

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

module alu;
endmodule  // alu


module ctrl_unit;
endmodule  // ctrl unit

module rv32i(output writeM, output[31:0] pc,addressM,outM, input clk,reset, input[31:0] inM,ins);
    reg[31:0] pc;           // program counter.

endmodule  // rv32i
