`include "gate.v"

module Not16(out, in);

    output[15:0] out;
    input[15:0] in;

    Not not0(out[0], in[0]);
    Not not1(out[1], in[1]);
    Not not2(out[2], in[2]);
    Not not3(out[3], in[3]);
    Not not4(out[4], in[4]);
    Not not5(out[5], in[5]);
    Not not6(out[6], in[6]);
    Not not7(out[7], in[7]);
    Not not8(out[8], in[8]);
    Not not9(out[9], in[9]);
    Not not10(out[10], in[10]);
    Not not11(out[11], in[11]);
    Not not12(out[12], in[12]);
    Not not13(out[13], in[13]);
    Not not14(out[14], in[14]);
    Not not15(out[15], in[15]);

endmodule


module And16(out, a, b);

    output[15:0] out;
    input[15:0] a, b;

    And and0(out[0], a[0], b[0]);
    And and1(out[1], a[1], b[1]);
    And and2(out[2], a[2], b[2]);
    And and3(out[3], a[3], b[3]);
    And and4(out[4], a[4], b[4]);
    And and5(out[5], a[5], b[5]);
    And and6(out[6], a[6], b[6]);
    And and7(out[7], a[7], b[7]);
    And and8(out[8], a[8], b[8]);
    And and9(out[9], a[9], b[9]);
    And and10(out[10], a[10], b[10]);
    And and11(out[11], a[11], b[11]);
    And and12(out[12], a[12], b[12]);
    And and13(out[13], a[13], b[13]);
    And and14(out[14], a[14], b[14]);
    And and15(out[15], a[15], b[15]);

endmodule


module Or16(out, a, b);

    output[15:0] out;
    input[15:0] a, b;

    Or or0(out[0], a[0], b[0]);
    Or or1(out[1], a[1], b[1]);
    Or or2(out[2], a[2], b[2]);
    Or or3(out[3], a[3], b[3]);
    Or or4(out[4], a[4], b[4]);
    Or or5(out[5], a[5], b[5]);
    Or or6(out[6], a[6], b[6]);
    Or or7(out[7], a[7], b[7]);
    Or or8(out[8], a[8], b[8]);
    Or or9(out[9], a[9], b[9]);
    Or or10(out[10], a[10], b[10]);
    Or or11(out[11], a[11], b[11]);
    Or or12(out[12], a[12], b[12]);
    Or or13(out[13], a[13], b[13]);
    Or or14(out[14], a[14], b[14]);
    Or or15(out[15], a[15], b[15]);

endmodule
