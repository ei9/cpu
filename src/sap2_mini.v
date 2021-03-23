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

/*
module mar(output[7:0] out, input lm,clk, input[7:0] in);

endmodule  // Memory address register.

module ram(output[11:0] out, input we,ce, input[11:0] in);

endmodule  // 256 x 12 RAM.

module mdr(output[11:0] to_ram, inout[11:0] bus, input ld,clk,ed);

endmodule  // Memory data register. It is used to change contents of ram.

module ir(output[7:0] to_ctrl, inout[11:0] bus, input li,clk,clr,ei);

endmodule  // Instruction register.

module ctrl(output[29:0] con, output clk,clr, input am,az,xm,xz, input[7:0] ins);

endmodule  // Control unit.

module i(output[11:0] out, input ln,clk,en, input[11:0] in);

endmodule  // Input register.

module acc(output[11:0] out, output am,az, inout[11:0] bus, input la,clk,ea);

endmodule  // Accumulator.

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
