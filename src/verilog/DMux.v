module DMux(a, b, in, sel);

    input in, sel;
    output a, b;
    wire w;

    Not not1(w1, sel);
    And and1(a, in, w1);
    And and2(b, in, sel);

endmodule

