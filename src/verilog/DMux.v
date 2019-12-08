module DMux(a, b, in, sel);

    input in, sel;
    output a, b;
    wire w;

    Not not0(w1, sel);
    And and0(a, in, w1);
    And and1(b, in, sel);

endmodule

