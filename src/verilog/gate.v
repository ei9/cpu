module Or8Way(output out, input[7:0] in);
    wire w[5:0];
    wire aOrb, cOrd, eOrf, gOrh, g0Org1, g2Org3;

    or g0(aOrb, in[0], in[1]);
    or g1(cOrd, in[2], in[3]);
    or g2(eOrf, in[4], in[5]);
    or g3(gOrh, in[6], in[7]);
    or g4(g0Org1, aOrb, cOrd);
    or g5(g2Org3, eOrf, gOrh);
    or g6(out, g0Org1, g2Org3);
endmodule  // Or8Way.
