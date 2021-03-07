module pc (output[3:0] out, input clk,clr,cp,ep);
    reg[3:0] m;
    assign out = ep ? m : 4'bz;

    always @ (posedge clk) begin
        m = clr ? 4'b0 : (cp ? (m + 1) : m);
    end
endmodule  // Program counter (0 to f).

module input_and_mar (output[3:0] out, input clk,lm,prog, input[3:0] a,in);
    reg[4:0] m;
    assign out = prog ? a : m;  // If prog = 1, out = a.

    always @ (posedge clk) begin
        if (lm)  m = in;
    end
endmodule  // Input and MAR.

module RAM16x8 (output[7:0] out, input clk,write,prog,ce, input[3:0] a, input[7:0] d);
    reg[7:0] m[0:15];
    assign out = prog ? 8'bz : (ce ? m[a] : 8'bz);  // If prog = 1, out = z;

    always @ (posedge clk) begin
        if (write)  m[a] = d;  // If write = 0, m[a] = d;
    end
endmodule  // RAM16x8.

module ir (output[3:0] to_ctrl_seq, to_bus, input clk,clr,li,ei, input[7:0] in);
    reg[7:0] m;
    assign to_ctrl_seq = m[7:4];
    assign to_bus = ei ? m[3:0] : 4'bz;

    always @ (posedge clk or posedge clr) begin
        if (clk & li)   m = in;
        if (clr)  m[7:4] = 4'b0;
    end
endmodule  // Instruction register.

module br (output[7:0] out, input clk,lb, input[7:0] in);
    reg[7:0] m;
    assign out = m;

    always @ (posedge clk) begin
        if (lb)  m = in;
    end
endmodule  // B register.

module output_port (output[7:0] out, input clk,lo, input[7:0] in);
    reg[7:0] m;
    assign out = m;

    always @ (posedge clk) begin
        if (lo) m = in;
    end
endmodule  // Output port.

module acc (output[7:0] to_wbus,to_add_sub, input clk,la,ea, input[7:0] in);
    reg[7:0] m;
    assign to_add_sub = m;
    assign to_wbus = ea ? m : 8'bz;

    always @ (posedge clk) begin
        if (la)  m = in;
    end
endmodule  // Accumulator.

module add_sub (output[7:0] out, input su,eu, input[7:0] a, b);
    assign out = eu ? su ? a - b : a + b : 8'bz;
endmodule  // Adder and subtractor.

// Version 1: Hard-wired.
// module ctrl_seq (output[11:0] cb, output hlt, input clk,clr, input[3:0] i);
//     reg[5:0] sc;  // State counter.
//
//     // Instructions
//     parameter LDA = 4'b0000;
//     parameter ADD = 4'b0001;
//     parameter SUB = 4'b0010;
//     parameter OUT = 4'b1110;
//     parameter HLT = 4'b1111;
//
//     assign cb[0] = (i == OUT) & sc[3];  // LO
//     assign cb[1] = ((i == ADD) | (i == SUB)) & sc[4];  // LB
//     assign cb[2] = ((i == ADD) | (i == SUB)) & sc[5];  // EU
//     assign cb[3] = (i == SUB) & sc[5];  // SU
//     assign cb[4] = (i == OUT) & sc[3];  // EA
//     assign cb[5] = ((i == LDA) & sc[4]) | (((i == ADD) | (i == SUB)) & sc[5]);  // LA
//     assign cb[6] = ((i == LDA) | (i == ADD) | (i == SUB)) & sc[3];  // EI
//     assign cb[7] = sc[2];  // LI
//     assign cb[8] = sc[2] | (((i == LDA) | (i == ADD) | (i == SUB)) & sc[4]);  // CE
//     assign cb[9] = sc[0] | (((i == LDA) | (i == ADD) | (i == SUB)) & sc[3]);  // LM
//     assign cb[10] = sc[0];  // EP
//     assign cb[11] = sc[1];  // CP
//     assign hlt = (i == HLT);
//
//     always @ (negedge clk or posedge clr) begin
//         if (clr)  sc = 4'b0;
//         else if (!clk) begin
//             sc = sc << 1;
//             if (sc == 0)  sc = 6'b1;
//         end
//     end
// endmodule // Controller-Sequencer.

/*
// Version 2: Microprogramming.
module ctrl_seq (output[11:0] cb, output hlt, input clk,clr, input[3:0] i);
    // Instructions
    parameter LDA = 4'b0000;
    parameter ADD = 4'b0001;
    parameter SUB = 4'b0010;
    parameter OUT = 4'b1110;
    parameter HLT = 4'b1111;

    reg[3:0] addr[0:15];   // Address ROM.
    reg[11:0] ctrl[0:15];  // Control ROM.
    reg[5:0] sc;           // State counter.
    reg[3:0] counter;      // Counter.

    reg[11:0] cb;
    assign hlt = i == HLT;

    always @ (negedge clk or posedge clr) begin
        // Initialize address ROM.
        addr[LDA] = 4'b0011;
        addr[ADD] = 4'b0110;
        addr[SUB] = 4'b1001;
        addr[OUT] = 4'b1100;

        // Initialize control ROM.
        ctrl[0] = 12'h600;  // 提取
        ctrl[1] = 12'h800;
        ctrl[2] = 12'h180;
        ctrl[3] = 12'h240;  // LDA
        ctrl[4] = 12'h120;
        ctrl[5] = 12'h000;
        ctrl[6] = 12'h240;  // ADD
        ctrl[7] = 12'h102;
        ctrl[8] = 12'h024;
        ctrl[9] = 12'h240;  // SUB
        ctrl[10] = 12'h102;
        ctrl[11] = 12'h02c;
        ctrl[12] = 12'h011;  // OUT
        ctrl[13] = 12'h000;
        ctrl[14] = 12'h000;

        // State counter.
        if (clr) begin
            sc = 4'b0;
            counter = 4'b0;
        end else if (!clk) begin
            if(sc[2])
                counter = addr[i];  // Load address in T3.
            else
                counter = counter + 1;

            sc = sc << 1;
            if (sc == 0)
                sc = 6'b1;
        end

        if (sc[0])
            counter = 4'b0;

        cb = ctrl[counter];
    end
endmodule // Controller-Sequencer.
*/

// Version 3: Skip nop.
module ctrl_seq (output[11:0] cb, output hlt, input clk,clr, input[3:0] i);
    // Instructions
    parameter LDA = 4'b0000;
    parameter ADD = 4'b0001;
    parameter SUB = 4'b0010;
    parameter OUT = 4'b1110;
    parameter HLT = 4'b1111;

    reg[3:0] addr[0:15];   // Address ROM.
    reg[11:0] ctrl[0:15];  // Control ROM.
    reg[5:0] sc;           // State counter.
    reg[3:0] counter;      // Counter.

    assign hlt = i == HLT;
    assign cb = ctrl[counter];

    wire nop = cb == 12'h000;

    always @ (negedge clk or posedge clr or posedge nop) begin
        // Initialize address ROM.
        addr[LDA] = 4'b0011;
        addr[ADD] = 4'b0110;
        addr[SUB] = 4'b1001;
        addr[OUT] = 4'b1100;

        // Initialize control ROM.
        ctrl[0] = 12'h600;  // 提取
        ctrl[1] = 12'h800;
        ctrl[2] = 12'h180;
        ctrl[3] = 12'h240;  // LDA
        ctrl[4] = 12'h120;
        ctrl[5] = 12'h000;  // NOP
        ctrl[6] = 12'h240;  // ADD
        ctrl[7] = 12'h102;
        ctrl[8] = 12'h024;
        ctrl[9] = 12'h240;  // SUB
        ctrl[10] = 12'h102;
        ctrl[11] = 12'h02c;
        ctrl[12] = 12'h011;  // OUT
        ctrl[13] = 12'h000;  // NOP
        ctrl[14] = 12'h000;  // NOP

        // State counter.
        if (clr | nop) begin
            sc = 6'b0;
        end

        if (!clk) begin
            if(sc[2])
                counter = addr[i];  // Load address in T3.
            else
                counter = counter + 1;

            sc = sc << 1;
            if (sc == 0) begin
                sc = 6'b1;
            end
        end

        if (clr | sc[0] | nop) begin
            counter = 4'b0;
        end
    end
endmodule // Controller-Sequencer.


// control bus:
// 11 10 9  8  7  6  5  4  3  2  1  0
// cp ep lm ce li ei la ea su eu lb lo
module sap1 (output[7:0] out, input clk,clr,prog,write, input[3:0] a, input[7:0] d);
    wire[7:0] wbus, alu_a, alu_b;  // wbus, accumulator to add_sub, B register to add_sub.
    wire[3:0] inA, IToCtrl;        // Address from input_and_mar, instructions to ctrl_seq.
    wire[11:0] ctrl_bus;
    wire clock = ~hlt & clk;

    pc            m0_pc(wbus[3:0],  clock,       clr,         ctrl_bus[11], ctrl_bus[10]);
    input_and_mar m1_mar(inA,       clock,       ctrl_bus[9], prog,         a,           wbus[3:0]);
    RAM16x8       m2_ram(wbus,      clock,       write,       prog,         ctrl_bus[8], inA,         d);
    ir            m3_ir(IToCtrl,    wbus[3:0],   clock,       clr,          ctrl_bus[7], ctrl_bus[6], wbus);
    ctrl_seq      m4_ctrl(ctrl_bus, hlt, clock,  clr,         IToCtrl);
    acc           m5_acc(wbus,      alu_a,       clock,       ctrl_bus[5],  ctrl_bus[4], wbus);
    add_sub       m6_add(wbus,      ctrl_bus[3], ctrl_bus[2], alu_a,        alu_b);
    br            m7_br(alu_b,      clock,       ctrl_bus[1], wbus);
    output_port   m8_out(out,       clock,       ctrl_bus[0], wbus);
endmodule  // sap1.
