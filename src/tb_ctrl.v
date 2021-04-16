`include "sap2_mini.v"

module tb_ctrl;
    reg clk, clr,am,az,xm,xz;
    reg[7:0] i;
    wire hlt;
    wire[29:0] con;
    ctrl m(con, hlt, clk,clr,am,az,xm,xz, i);

    initial begin
        $dumpfile("./tb_ctrl.vcd");
        $dumpvars(0, m);
        $monitor("%3dns clk=%b clr=%b am=%b az=%b xm=%b xz=%b i=%h con=%6h hlt=%b sc=%b", $stime,clk,clr,am,az,xm,xz,i,con[23:0],hlt,m.sc);
        clk = 0;
        clr = 0;
        am = 0;
        az = 0;
        xm = 0;
        xz = 0;
        i = 8'hff;

        #10 clr = 1;
        #10 clr = 0;
        
        // Instructions
        #12 i[7:4] = 4'b0000;  // LDA
        #12 i[7:4] = 4'b0001;  // ADD
        #12 i[7:4] = 4'b0010;  // SUB
        #12 i[7:4] = 4'b0011;  // STA
        #12 i[7:4] = 4'b0100;  // LDB
        #12 i[7:4] = 4'b0101;  // LDX
        #12 i[7:4] = 4'b0110;  // JMP
        #12 i[7:4] = 4'b0111;  // JAN
        #12 i[7:4] = 4'b1000;  // JAZ
        #12 i[7:4] = 4'b1001;  // JIN
        #12 i[7:4] = 4'b1010;  // JIZ

        #1 am = 1; az = 1; xm = 1; xz = 1;
        #12 i[7:4] = 4'b0111;  // JAN
        #12 i[7:4] = 4'b1000;  // JAZ
        #12 i[7:4] = 4'b1001;  // JIN
        #12 i[7:4] = 4'b1010;  // JIZ

        #12 i[7:4] = 4'b1011;  // JMS
        #12 i = 8'b1111_0000;  // NOP
        #12 i = 8'b1111_0001;  // CLA
        #12 i = 8'b1111_0010;  // XCH
        #12 i = 8'b1111_0011;  // DEX
        #12 i = 8'b1111_0100;  // INX
        #12 i = 8'b1111_0101;  // CMA
        #12 i = 8'b1111_0110;  // CMB
        #12 i = 8'b1111_0111;  // IOR
        #12 i = 8'b1111_1000;  // AND
        #12 i = 8'b1111_1001;  // NOR
        #12 i = 8'b1111_1010;  // NAN
        #12 i = 8'b1111_1011;  // XOR
        #12 i = 8'b1111_1100;  // BRB
        #12 i = 8'b1111_1101;  // INP
        #12 i = 8'b1111_1110;  // OUT
        #12 i = 8'b1111_1111;  // HLT
    end

    always #1 begin
        clk = ~clk;
    end

    initial #1024 $finish;
endmodule // tb_ctrl.
