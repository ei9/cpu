module pc(inout[7:0] bus, input lp,cp,clk,clr,ep);
    reg[7:0] m;
    assign bus = ep ? (lp ? 8'hzz : m) : 8'hzz;
    
    always @ (posedge clr or posedge clk) begin
        m = clr ? 8'h00 : (lp ? bus : (cp ? (m + 1) : m));
    end
endmodule  // Program counter.

module sc(inout[7:0] bus, input ls,cs,clk,es);
    reg[7:0] m;
    assign bus = es ? (ls ? 8'hzz : m) : 8'hzz;

    always @ (posedge clk) begin
        m = ls ? bus : (cs ? (m + 1) : m);
    end
endmodule  // Subroutine counter.

module input_and_mar (output[7:0] out, input clk,lm,prog, input[7:0] a,in);
    reg[7:0] m;
    assign out = prog ? a : m;  // If prog = 1, out = a.

    always @ (posedge clk) begin
        if (lm)  m = in;
    end
endmodule  // Input and Memory address register.

module ram256x12(output[11:0] out, input clk,we,prog,ce, input[7:0] a, input[11:0] d);
    reg[11:0] m[0:255];
    assign out = prog ? 12'bz : (ce ? m[a] : 12'bz);  // If prog = 1, out = z;

    always @ (posedge clk) begin
        if (we)  m[a] = d;  // If we = 0, m[a] = d;
    end
endmodule  // 256 x 12 RAM

module mdr(output[11:0] to_ram, inout[11:0] bus, input ld,clk,ed);
    reg[11:0] m;
    assign to_ram = m;
    assign bus = ld ? 12'bz : (ed ? m : 12'bz);

    always @ (posedge clk) begin
        if (ld)  m = bus;
    end
endmodule  // Memory data register. It is used to change contents of ram.

module ir(output[7:0] to_ctrl, inout[11:0] bus, input li,clk,clr,ei);
    reg[11:0] m;
    assign bus = li ? 12'bz : (ei ? m[7:0] : 12'bz);
    assign to_ctrl = m[11:4];

    always @ (posedge clk or posedge clr) begin
        m = clr ? 12'b0 : (li ? bus : m);
    end
endmodule  // Instruction register.

// Version 1: Hard-wired.
module ctrl(output[29:0] con, output hlt, input clk,clr,am,az,xm,xz, input[7:0] i);
    reg[5:0] sc;  // State counter.
    
    assign hlt = HLT;

    reg q;  // jkff to select to enable pc or subroutine counter.
    wire j = JMS & sc[3];
    wire k = BRB & sc[3];

    // Instructions
    wire LDA = i[7:4] == 4'b0000;
    wire ADD = i[7:4] == 4'b0001;
    wire SUB = i[7:4] == 4'b0010;
    wire STA = i[7:4] == 4'b0011;
    wire LDB = i[7:4] == 4'b0100;
    wire LDX = i[7:4] == 4'b0101;
    wire JMP = i[7:4] == 4'b0110;
    wire JAN = (i[7:4] == 4'b0111) & am;
    wire JAZ = (i[7:4] == 4'b1000) & az;
    wire JIN = (i[7:4] == 4'b1001) & xm;
    wire JIZ = (i[7:4] == 4'b1010) & xz;
    wire JMS = i[7:4] == 4'b1011;
    wire NOP = i == 8'b1111_0000;
    wire CLA = i == 8'b1111_0001;
    wire XCH = i == 8'b1111_0010;
    wire DEX = i == 8'b1111_0011;
    wire INX = i == 8'b1111_0100;
    wire CMA = i == 8'b1111_0101;
    wire CMB = i == 8'b1111_0110;
    wire IOR = i == 8'b1111_0111;
    wire AND = i == 8'b1111_1000;
    wire NOR = i == 8'b1111_1001;
    wire NAN = i == 8'b1111_1010;
    wire XOR = i == 8'b1111_1011;
    wire BRB = i == 8'b1111_1100;
    wire INP = i == 8'b1111_1101;
    wire OUT = i == 8'b1111_1110;
    wire HLT = i == 8'b1111_1111;

    assign con[29] = sc[3] & (JMP|JAN|JAZ|JIN|JIZ);  // LP
    assign con[28] = sc[1] & (~q);  // CP
    assign con[27] = sc[0] & (~q);  // EP
    assign con[26] = (sc[3] & (JMP|JAN|JAZ|JIN|JIZ)) | (sc[4] & JMS);  // LS
    assign con[25] = sc[1] & (q);  // CS
    assign con[24] = sc[0] & q;  // ES
    assign con[23] = sc[0] | (sc[3] & (LDA|ADD|SUB|STA|LDB|LDX));  // LM
    assign con[22] = sc[5] & STA;  // WE
    assign con[21] = (sc[4] & (LDA|ADD|SUB|LDB|LDX)) | (sc[5] & STA) | sc[2];  // CE
    assign con[20] = (sc[3] & XCH) | (sc[4] & STA);  // LD
    assign con[19] = sc[5] & XCH;  // ED
    assign con[18] = sc[2];  // LI
    assign con[17] = (sc[3] & (LDA|ADD|SUB|STA|LDB|LDX|JMP|JAZ|JIN)) | (sc[4] & JMS);  // EI
    assign con[16] = sc[3] & INP;  // LN
    assign con[15] = sc[4] & INP;  // EN
    assign con[14] = (sc[3] & (CLA|CMA|IOR|AND|NOR|NAN|XOR)) | (sc[4] & (LDA|XCH|INP)) | (sc[5] & (ADD|SUB));  // LA
    assign con[13] = (sc[3] & (XCH|OUT)) | (sc[4] & STA);  // EA
    assign con[12] = (sc[3] & (IOR|AND)) | (sc[5] & ADD);  // S3
    assign con[11] = (sc[3] & (CMB|IOR|XOR)) | (sc[5] & SUB);  // S2
    assign con[10] = (sc[3] & (CLA|IOR|AND|XOR)) | (sc[5] & SUB);  // S1
    assign con[9] = (sc[3] & (CLA|CMB|AND|NOR)) | (sc[5] & ADD);  // S0
    assign con[8] = sc[3] & (CLA|CMA|CMB|IOR|AND|NOR|NAN|XOR);  // M
    assign con[7] = sc[5] & ADD;  // CI
    assign con[6] = (sc[3] & (CMA|CMB|IOR|AND|NOR|NAN|XOR|CLA)) | (sc[5] & (ADD|SUB));  // EU
    assign con[5] = (sc[3] & CMB) | (sc[4] & (ADD|SUB|CMB|LDB));  // LB
    assign con[4] = (sc[4] & LDX) | (sc[5] & XCH);  // LX
    assign con[3] = sc[3] & INX;  // INX
    assign con[2] = sc[4] & XCH;  // DEX
    assign con[1] = sc[4] & XCH;  // EX
    assign con[0] = sc[3] & OUT;  // LO

    always @ (negedge clk or posedge clr) begin
        if (clr)begin
            sc = 4'b0;
            q = 1'b0;
        end else if (!clk) begin
            sc = sc << 1;
            if (sc == 0)  sc = 6'b1;

            // jkff for subroutine.
            case({j, k})
                2'b01 : q = 1'b0;
                2'b10 : q = 1'b1;
                2'b11 : q = ~q;
            endcase
        end
    end
endmodule  // Control unit.

module i(output[11:0] out, input ln,clk,en, input[11:0] in);
    reg[11:0] m;
    assign out = en ? m : 12'bz;

    always @ (posedge clk) begin
        if (ln) m = in;
    end
endmodule  // Input register.

module acc(output[11:0] out, output am,az, inout[11:0] bus, input la,clk,ea);
    reg[11:0] m;
    assign out = m;
    assign am = m[11];  // MSB as negative flag.
    // Zero flag.
    assign az=~(m[11]|m[10]|m[9]|m[8]|m[7]|m[6]|m[5]|m[4]|m[3]|m[2]|m[1]|m[0]);
    assign bus = la ? 12'bz : (ea ? m :12'bz);

    always @ (posedge clk) begin
        if (la)  m = bus;
    end
endmodule  // Accumulator.

module alu(output[11:0] out, input s3,s2,s1,s0,m,ci,eu, input[11:0] a,b);
    wire[5:0] con = {s3, s2, s1, s0, m, ci};
    reg[11:0] result;
    assign out = eu ? result : 12'hz;

    always @ (con) begin
        casex(con)
            6'b00001? : result = ~a;        // cma
            6'b00011? : result = ~(a | b);  // nor
            6'b00111? : result = 12'b0;     // cla
            6'b01001? : result = ~(a & b);  // man
            6'b01011? : result = ~b;        // cmb
            6'b011000 : result = a - b;     // sub
            6'b01101? : result = a ^ b;     // xor
            6'b100101 : result = a + b;     // add
            6'b10111? : result = a & b;     // and
            6'b11101? : result = a | b;     // ior
        endcase
    end
endmodule  // ALU.

module b(output[11:0] out, input lb,clk, input[11:0] in);
    reg[11:0] out;

    always @ (posedge clk) begin
        if (lb)  out = in;
    end
endmodule  // B register.

module x(output im,iz, inout[11:0] bus, input lx,inx,clk,dex,ex);
    reg[11:0] m;
    assign im = m[11];
    assign iz = ~(m[11]|m[10]|m[9]|m[8]|m[7]|m[6]|m[5]|m[4]|m[3]|m[2]|m[1]|m[0]);
    assign bus = lx ? 12'bz : (ex ? m : 12'bz);

    always @ (posedge clk) begin
        if (lx) begin
            m = bus;
        end else if (inx) begin
            m = m + 1;
        end else if (dex) begin
            m = m - 1;
        end
    end
endmodule  // Pointer register.

module output_port(output[11:0] out, input lo,clk, input[11:0] in);
    reg[11:0] out;

    always @ (posedge clk) begin
        if (lo)  out = in;
    end
endmodule  // Output port.

// con:
// 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4   3   2  1  0
// lp cp ep ls cs es lm we ce ld ed li ei ln en la ea s3 s2 s1 s0  m ci eu lb lx inx dex ex lo
module sap2_mini(output[11:0] out, input clk,clr,prog, input[7:0] a, input[11:0] d,i);
    wire[11:0] bus;
    wire[29:0] con;
    wire[7:0] mar_to_ram;
    wire[11:0] mdr_to_ram;
    wire[7:0] ir_to_ctrl;
    wire clock = ~hlt & clk;
    wire am,az,xm,xz;
    wire[11:0] acc_to_alu;
    wire[11:0] b_to_alu;

    wire[11:0] data = prog ? d : mdr_to_ram;
    wire write = prog ? 1 : con[22];

    pc            m0_pc(bus[7:0], con[29],con[28],clock,clr,con[27]);
    sc            m1_sc(bus[7:0], con[26],con[25],clock,con[24]);
    input_and_mar m2_mar(mar_to_ram, clock,con[23],prog, a,bus[7:0]);
    ram256x12     m3_ram(bus, clock,write,prog,con[21], mar_to_ram, data);
    mdr           m4_mdr(mdr_to_ram, bus, con[20],clock,con[19]);
    ir            m5_ir(ir_to_ctrl, bus, con[18],clock,clr,con[17]);
    ctrl          m6_ctrl(con, hlt, clock,clr,am,az,xm,xz, ir_to_ctrl);
    i             m7_i(bus, con[16],clock,con[15], i);
    acc           m8_acc(acc_to_alu, am,az, bus, con[14],clock,con[13]);
    alu           m9_alu(bus, con[12],con[11],con[10],con[9],con[8],con[7],con[6], acc_to_alu,b_to_alu);
    b             m10_b(b_to_alu, con[5],clock, bus);
    x             m11_x(xm,xz, bus, con[4],con[3],clock,con[2],con[1]);
    output_port   m12_out(out, con[0],clock, bus);
endmodule  // SAP2 mini.
