`include "sap2_mini.v"

module tb_alu;
    reg eu;
    reg[5:0] con;  // s3,s2,s1,s0,m,ci
    reg[11:0] a,b;
    wire[11:0] out;

    alu g(out, con[5],con[4],con[3],con[2],con[1],con[0],eu, a,b);

    initial begin
        $monitor("%2dns con=%b a=%h b=%h out=%h eu=%b", $stime, con, a, b, out, eu);
        a = 12'hfff;
        b = 12'b1;
        eu = 0;
        con = 6'b00001x;     // cma

        #1 eu = 1;
        #1 con = 6'b00011x;  // nor
        #1 con = 6'b00111x;  // cla
        #1 con = 6'b01001x;  // man 
        #1 con = 6'b01011x;  // cmb 
        #1 con = 6'b011000;  // sub 
        #1 con = 6'b01101x;  // xor 
        #1 con = 6'b100101;  // add 
        #1 con = 6'b10111x;  // and 
        #1 con = 6'b11101x;  // ior 
    end
endmodule  // tb_alu.
