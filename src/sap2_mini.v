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

module ctrl(output[29:0] con, output hlt, input clk,clr,am,az,xm,xz, input[7:0] i);
    // Instructions.
    parameter LDA = 4'b0000;
    parameter ADD = 4'b0001;
    parameter SUB = 4'b0010;
    parameter STA = 4'b0011;
    parameter LDB = 4'b0100;
    parameter LDX = 4'b0101;
    parameter JMP = 4'b0110;
    parameter JAN = 4'b0111;
    parameter JAZ = 4'b1000;
    parameter JIN = 4'b1001;
    parameter JIZ = 4'b1010;
    parameter JMS = 4'b1011;
    parameter NOP = 8'b1111_0000;
    parameter CLA = 8'b1111_0001;
    parameter XCH = 8'b1111_0010;
    parameter DEX = 8'b1111_0011;
    parameter INX = 8'b1111_0100;
    parameter CMA = 8'b1111_0101;
    parameter CMB = 8'b1111_0110;
    parameter IOR = 8'b1111_0111;
    parameter AND = 8'b1111_1000;
    parameter NOR = 8'b1111_1001;
    parameter NAN = 8'b1111_1010;
    parameter XOR = 8'b1111_1011;
    parameter BRB = 8'b1111_1100;
    parameter INP = 8'b1111_1101;
    parameter OUT = 8'b1111_1110;
    parameter HLT = 8'b1111_1111;

    reg[8:0] addr[255:0];      // Address ROM.
    reg[23:0] ctrl_rom[0:86];  // con[23:0] stored in ctrl ROM.
    reg[5:0] sc;               // State counter.
    reg[6:0] counter;          // Counter count from 0-86.
    
    assign hlt = i == HLT;
    assign con[29] = (~q) & flag_jmp;  // LP
    assign con[28] = sc[1] & (~q);  // CP
    assign con[27] = sc[0] & (~q);  // EP
    assign con[26] = q & flag_jmp;  // LS
    assign con[25] = sc[1] & q;  // CS
    assign con[24] = sc[0] & q;  // ES
    assign con[23:0] = ctrl_rom[counter];

    wire nop = con == 30'h0;
    
    // jkff to select to enable pc or subroutine counter.
    reg q;
    wire j = jms & sc[3];
    wire k = brb & sc[3];

    wire flag_jmp = (sc[3] & ((xz & jiz)|(xm & jin)|(az & jaz)|(am & jan)|jmp)) | (sc[4] & jms);

    // Jump instructions
    wire jmp = i[7:4] == 4'b0110;
    wire jan = (i[7:4] == 4'b0111) & am;
    wire jaz = (i[7:4] == 4'b1000) & az;
    wire jin = (i[7:4] == 4'b1001) & xm;
    wire jiz = (i[7:4] == 4'b1010) & xz;
    wire jms = i[7:4] == 4'b1011;
    wire brb = i == 8'b1111_1100;

    always @ (negedge clk or posedge clr or posedge nop) begin
        // Address ROM.
        addr[LDA] = 7'h03;  // LDA
        addr[ADD] = 7'h06;  // ADD
        addr[SUB] = 7'h09;  // SUB
        addr[STA] = 7'h0c;  // STA
        addr[LDB] = 7'h0f;  // LDB
        addr[LDX] = 7'h12;  // LDX
        addr[JMP] = 7'h15;  // JMP
        addr[JAN] = 7'h18;  // JAN
        addr[JAZ] = 7'h1b;  // JAZ
        addr[JIN] = 7'h1e;  // JIN
        addr[JIZ] = 7'h21;  // JIZ
        addr[JMS] = 7'h24;  // JMS
        addr[NOP] = 7'h27;  // NOP
        addr[CLA] = 7'h2a;  // CLA
        addr[XCH] = 7'h2d;  // XCH
        addr[DEX] = 7'h30;  // DEX
        addr[INX] = 7'h33;  // INX
        addr[CMA] = 7'h36;  // CMA
        addr[CMB] = 7'h39;  // CMB
        addr[IOR] = 7'h3c;  // IOR
        addr[AND] = 7'h3f;  // AND
        addr[NOR] = 7'h42;  // NOR
        addr[NAN] = 7'h45;  // NAN
        addr[XOR] = 7'h48;  // XOR
        addr[BRB] = 7'h4b;  // BRB
        addr[INP] = 7'h4e;  // INP
        addr[OUT] = 7'h51;  // OUT
        addr[HLT] = 7'h54;  // HLT

        // Control ROM.
        ctrl_rom[0] = 24'h800000;  // Fetch cycle.
        ctrl_rom[1] = 24'h000000;
        ctrl_rom[2] = 24'h240000;
        ctrl_rom[3] = 24'h820000;  // LDA
        ctrl_rom[4] = 24'h204000;
        ctrl_rom[5] = 24'h000000;
        ctrl_rom[6] = 24'h820000;  // ADD
        ctrl_rom[7] = 24'h200020;
        ctrl_rom[8] = 24'h0052c0;
        ctrl_rom[9] = 24'h820000;  // SUB
        ctrl_rom[10] = 24'h200020;
        ctrl_rom[11] = 24'h004c40;
        ctrl_rom[12] = 24'h820000;  // STA
        ctrl_rom[13] = 24'h102000;
        ctrl_rom[14] = 24'h600000;
        ctrl_rom[15] = 24'h820000;  // LDB
        ctrl_rom[16] = 24'h200020;
        ctrl_rom[17] = 24'h000000;
        ctrl_rom[18] = 24'h820000;  // LDX
        ctrl_rom[19] = 24'h200010;
        ctrl_rom[20] = 24'h000000;
        ctrl_rom[21] = 24'h020000;  // JMP
        ctrl_rom[22] = 24'h000000;
        ctrl_rom[23] = 24'h000000;
        ctrl_rom[24] = 24'h020000;  // & (am<<17);  // JAN
        ctrl_rom[25] = 24'h000000;
        ctrl_rom[26] = 24'h000000;
        ctrl_rom[27] = 24'h020000;  // & (az<<17);  // JAZ
        ctrl_rom[28] = 24'h000000;
        ctrl_rom[29] = 24'h000000;
        ctrl_rom[30] = 24'h020000;  // & (xm<<17);  // JIN
        ctrl_rom[31] = 24'h000000;
        ctrl_rom[32] = 24'h000000;
        ctrl_rom[33] = 24'h020000;  // & (xz<<17);  // JIZ
        ctrl_rom[34] = 24'h000000;
        ctrl_rom[35] = 24'h000000;
        ctrl_rom[36] = 24'h000000;  // JMS
        ctrl_rom[37] = 24'h020000;
        ctrl_rom[38] = 24'h000000;
        ctrl_rom[39] = 24'h000000;  // NOP
        ctrl_rom[40] = 24'h000000;
        ctrl_rom[41] = 24'h000000;
        ctrl_rom[42] = 24'h004740;  // CLA
        ctrl_rom[43] = 24'h000000;
        ctrl_rom[44] = 24'h000000;
        ctrl_rom[45] = 24'h102000;  // XCH
        ctrl_rom[46] = 24'h004002;
        ctrl_rom[47] = 24'h080010;
        ctrl_rom[48] = 24'h000004;  // DEX
        ctrl_rom[49] = 24'h000000;
        ctrl_rom[50] = 24'h000000;
        ctrl_rom[51] = 24'h000008;  // INX
        ctrl_rom[52] = 24'h000000;
        ctrl_rom[53] = 24'h000000;
        ctrl_rom[54] = 24'h004140;  // CMA
        ctrl_rom[55] = 24'h000000;
        ctrl_rom[56] = 24'h000000;
        ctrl_rom[57] = 24'h000b60;  // CMB
        ctrl_rom[58] = 24'h000000;
        ctrl_rom[59] = 24'h000000;
        ctrl_rom[60] = 24'h005d40;  // IOR
        ctrl_rom[61] = 24'h000000;
        ctrl_rom[62] = 24'h000000;
        ctrl_rom[63] = 24'h005740;  // AND
        ctrl_rom[64] = 24'h000000;
        ctrl_rom[65] = 24'h000000;
        ctrl_rom[66] = 24'h004340;  // NOR
        ctrl_rom[67] = 24'h000000;
        ctrl_rom[68] = 24'h000000;
        ctrl_rom[69] = 24'h004940;  // NAN
        ctrl_rom[70] = 24'h000000;
        ctrl_rom[71] = 24'h000000;
        ctrl_rom[72] = 24'h004d40;  // XOR
        ctrl_rom[73] = 24'h000000;
        ctrl_rom[74] = 24'h000000;
        ctrl_rom[75] = 24'h000000;  // BRB
        ctrl_rom[76] = 24'h000000;
        ctrl_rom[77] = 24'h000000;
        ctrl_rom[78] = 24'h010000;  // INP
        ctrl_rom[79] = 24'h00c000;
        ctrl_rom[80] = 24'h000000;
        ctrl_rom[81] = 24'h002001;  // OUT
        ctrl_rom[82] = 24'h000000;
        ctrl_rom[83] = 24'h000000;
        ctrl_rom[84] = 24'h000000;  // HLT
        ctrl_rom[85] = 24'h000000;
        ctrl_rom[86] = 24'h000000;

        if (clr) begin
            q = 1'b0;
            sc = 6'b0;
            counter = 7'b0;
        end else if (~clk) begin
            case (sc)
                6'b000001 : begin
                    sc = 6'd2;
                    counter <= 7'h01;
                end
                6'b000010 : begin
                    sc <= 6'd4;
                    counter <= 7'h02;
                end
                6'b000100 : begin
                    // Load address in T3.
                    sc = 6'd8;
                    counter = (i[7:4] == 4'b1111) ? addr[i] : addr[i[7:4]];
                end
                6'b001000 : begin
                    sc = 6'd16;
                    counter = counter + 1;
                end
                6'b010000 : begin
                    sc = 6'd32;
                    counter = counter + 1;
                end
                6'b100000 : begin
                    sc = 6'd1;
                    counter = 7'h00;
                end
            endcase
            
            if (sc == 6'b0)
                sc = 6'h1;

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
