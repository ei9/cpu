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

module mar(output[7:0] out, input lm,clk, input[7:0] in);
    reg[7:0] out;

    always @ (posedge clk) begin
        if (lm)  out = in;
    end
endmodule  // Memory address register.

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

/*
module ctrl(output[29:0] con, output clk,clr, input am,az,xm,xz, input[7:0] ins);

endmodule  // Control unit.
*/

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

/*
module alu(output[11:0] out, input s3,s2,s1,s0,m,ci,eu, input[11:0] a,b);

endmodule  // ALU.

module b(output[11:0] out, input lb,clk, input[11:0] in);

endmodule  // B register.

module x(output im,iz, input[11:0] bus, input lx,inx,clk,dex,ex);

endmodule  // Pointer register.

module output_port(output[11:0] out, input lo,clk, input[11:0] in);

endmodule  // Output port.

module sap2_mini();

endmodule  // SAP2 mini.
*/
