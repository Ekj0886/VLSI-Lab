
//Sklansky Adder
module Sklan_7 (//input
             A_i,
             B_i,
             CIN,
             //output
             OUT);

    input  signed [5:0]  A_i, B_i;
    input CIN;
    output signed [6:0] OUT;

    wire signed [6:0] A, B;

    assign A = A_i; //sign extension
    assign B = B_i; //sign extension

    VLSI_XOR3 xor_0 (.OUT(OUT[0]), .INA(A[0]), .INB(B[0]), .INC(CIN));
    VLSI_XOR3 xor_1 (.OUT(OUT[1]), .INA(A[1]), .INB(B[1]), .INC(C1));
    VLSI_XOR3 xor_2 (.OUT(OUT[2]), .INA(A[2]), .INB(B[2]), .INC(C2));
    VLSI_XOR3 xor_3 (.OUT(OUT[3]), .INA(A[3]), .INB(B[3]), .INC(C3));
    VLSI_XOR3 xor_4 (.OUT(OUT[4]), .INA(A[4]), .INB(B[4]), .INC(C4));
    VLSI_XOR3 xor_5 (.OUT(OUT[5]), .INA(A[5]), .INB(B[5]), .INC(C5));
    VLSI_XOR3 xor_6 (.OUT(OUT[6]), .INA(A[6]), .INB(B[6]), .INC(C6));

    GP_gen gp_gen0  (.P(P0), .G(G0), .A(A[0]),   .B(B[0])  );
    GP_gen gp_gen1  (.P(P1), .G(G1), .A(A[1]),   .B(B[1])  );
    GP_gen gp_gen2  (.P(P2), .G(G2), .A(A[2]),   .B(B[2])  );
    GP_gen gp_gen3  (.P(P3), .G(G3), .A(A[3]),   .B(B[3])  );
    GP_gen gp_gen4  (.P(P4), .G(G4), .A(A[4]),   .B(B[4])  );
    GP_gen gp_gen5  (.P(P5), .G(G5), .A(A[5]),   .B(B[5])  );
    GP_gen gp_gen6  (.P(P6), .G(G6), .A(A[6]),   .B(B[6])  );

    VLSI_AND2 and_0 (.OUT(c1), .INA(P0), .INB(CIN));
    VLSI_OR2 or_0   (.OUT(C1), .INA(G0), .INB(c1));
    GP_trn gp_trn0  (.G_k(C2), .P_k(Pk0), .G_i(G1), .P_i(P1), .G_j(C1), .P_j(P0) );
    GP_trn gp_trn1  (.G_k(C3), .P_k(Pk1), .G_i(G2), .P_i(P2), .G_j(C2), .P_j(Pk0) );
    GP_trn gp_trn2  (.G_k(Gk2), .P_k(Pk2), .G_i(G3), .P_i(P3), .G_j(G2), .P_j(P2) );
    GP_trn gp_trn3  (.G_k(C4), .P_k(Pk3), .G_i(Gk2), .P_i(Pk2), .G_j(C2), .P_j(Pk0) );
    GP_trn gp_trn4  (.G_k(C5), .P_k(Pk4), .G_i(G4), .P_i(P4), .G_j(C4), .P_j(Pk3) );
    GP_trn gp_trn5  (.G_k(Gk5), .P_k(Pk5), .G_i(G5), .P_i(P5), .G_j(G4), .P_j(P4) );
    GP_trn gp_trn6  (.G_k(C6), .P_k(Pk6), .G_i(Gk5), .P_i(Pk5), .G_j(C4), .P_j(Pk3) );

endmodule


// 1-bit MUX --------------------------------------------------------------------
module MUX (//input
            A,
            B,
            sel,
            //output
            OUT);

    input A, B, sel;
    output OUT;

    VLSI_NOT   not_0  (.OUT(sel_bar), .IN(sel)                );
    VLSI_NAND2 nand_0 (.OUT(n_A),     .INA(A),   .INB(sel_bar));
    VLSI_NAND2 nand_1 (.OUT(n_B),     .INA(B),   .INB(sel)    );
    VLSI_NAND2 nand_2 (.OUT(OUT),     .INA(n_A), .INB(n_B)    );

endmodule

// 12-bit MUX -------------------------------------------------------------------
module MUX_12 (//input
             A,
             B,
             sel,
             //output
             OUT);

    input  signed [11:0]  A, B;
    input sel;
    output signed [11:0] OUT;

    MUX m0  (.OUT(OUT[0]),  .A(A[0]),  .B(B[0]),  .sel(sel));   
    MUX m1  (.OUT(OUT[1]),  .A(A[1]),  .B(B[1]),  .sel(sel));
    MUX m2  (.OUT(OUT[2]),  .A(A[2]),  .B(B[2]),  .sel(sel));
    MUX m3  (.OUT(OUT[3]),  .A(A[3]),  .B(B[3]),  .sel(sel));
    MUX m4  (.OUT(OUT[4]),  .A(A[4]),  .B(B[4]),  .sel(sel));
    MUX m5  (.OUT(OUT[5]),  .A(A[5]),  .B(B[5]),  .sel(sel));
    MUX m6  (.OUT(OUT[6]),  .A(A[6]),  .B(B[6]),  .sel(sel));   
    MUX m7  (.OUT(OUT[7]),  .A(A[7]),  .B(B[7]),  .sel(sel));
    MUX m8  (.OUT(OUT[8]),  .A(A[8]),  .B(B[8]),  .sel(sel));
    MUX m9  (.OUT(OUT[9]),  .A(A[9]),  .B(B[9]),  .sel(sel));
    MUX m10 (.OUT(OUT[10]), .A(A[10]), .B(B[10]), .sel(sel));
    MUX m11 (.OUT(OUT[11]), .A(A[11]), .B(B[11]), .sel(sel));

endmodule

// Han-Carlson Adder
module Han_13 (//input
             A,
             B,
             //output
             OUT);

    input  signed [12:0]  A, B;
    output signed [12:0] OUT;

    VLSI_XOR2 xor_0  (.OUT(OUT[0]),  .INA(A[0]),  .INB(B[0]));
    VLSI_XOR3 xor_1  (.OUT(OUT[1]),  .INA(A[1]),  .INB(B[1]),  .INC(G0) );
    VLSI_XOR3 xor_2  (.OUT(OUT[2]),  .INA(A[2]),  .INB(B[2]),  .INC(C2) );
    VLSI_XOR3 xor_3  (.OUT(OUT[3]),  .INA(A[3]),  .INB(B[3]),  .INC(C3) );
    VLSI_XOR3 xor_4  (.OUT(OUT[4]),  .INA(A[4]),  .INB(B[4]),  .INC(C4) );
    VLSI_XOR3 xor_5  (.OUT(OUT[5]),  .INA(A[5]),  .INB(B[5]),  .INC(C5) );
    VLSI_XOR3 xor_6  (.OUT(OUT[6]),  .INA(A[6]),  .INB(B[6]),  .INC(C6) );
    VLSI_XOR3 xor_7  (.OUT(OUT[7]),  .INA(A[7]),  .INB(B[7]),  .INC(C7) );
    VLSI_XOR3 xor_8  (.OUT(OUT[8]),  .INA(A[8]),  .INB(B[8]),  .INC(C8) );
    VLSI_XOR3 xor_9  (.OUT(OUT[9]),  .INA(A[9]),  .INB(B[9]),  .INC(C9) );
    VLSI_XOR3 xor_10 (.OUT(OUT[10]), .INA(A[10]), .INB(B[10]), .INC(C10));
    VLSI_XOR3 xor_11 (.OUT(OUT[11]), .INA(A[11]), .INB(B[11]), .INC(C11));
    VLSI_XOR3 xor_12 (.OUT(OUT[12]), .INA(A[12]), .INB(B[12]), .INC(C12));

    GP_gen gp_gen0   (.P(P0),  .G(G0),  .A(A[0]),    .B(B[0])   );
    GP_gen gp_gen1   (.P(P1),  .G(G1),  .A(A[1]),    .B(B[1])   );
    GP_gen gp_gen2   (.P(P2),  .G(G2),  .A(A[2]),    .B(B[2])   );
    GP_gen gp_gen3   (.P(P3),  .G(G3),  .A(A[3]),    .B(B[3])   );
    GP_gen gp_gen4   (.P(P4),  .G(G4),  .A(A[4]),    .B(B[4])   );
    GP_gen gp_gen5   (.P(P5),  .G(G5),  .A(A[5]),    .B(B[5])   );
    GP_gen gp_gen6   (.P(P6),  .G(G6),  .A(A[6]),    .B(B[6])   );
    GP_gen gp_gen7   (.P(P7),  .G(G7),  .A(A[7]),    .B(B[7])   );
    GP_gen gp_gen8   (.P(P8),  .G(G8),  .A(A[8]),    .B(B[8])   );
    GP_gen gp_gen9   (.P(P9),  .G(G9),  .A(A[9]),    .B(B[9])   );
    GP_gen gp_gen10  (.P(P10), .G(G10), .A(A[10]),   .B(B[10])  );
    GP_gen gp_gen11  (.P(P11), .G(G11), .A(A[11]),   .B(B[11])  );

    GP_trn gp_trn1  (.G_k(C2), .P_k(Pk2), .G_i(G1), .P_i(P1), .G_j(G0), .P_j(P0));
    GP_trn gp_trn2  (.G_k(C3), .P_k(Pk3), .G_i(G2), .P_i(P2), .G_j(C2), .P_j(Pk2));
    GP_trn gp_trn3  (.G_k(g3), .P_k(p3), .G_i(G3), .P_i(P3), .G_j(G2), .P_j(P2));
    GP_trn gp_trn4  (.G_k(C4), .P_k(Pk4), .G_i(g3), .P_i(p3), .G_j(C2), .P_j(Pk2));
    GP_trn gp_trn5  (.G_k(C5), .P_k(Pk5), .G_i(G4), .P_i(P4), .G_j(C4), .P_j(Pk4));
    GP_trn gp_trn6  (.G_k(g6), .P_k(p6), .G_i(G5), .P_i(P5), .G_j(G4), .P_j(P4));
    GP_trn gp_trn7  (.G_k(g7), .P_k(p7), .G_i(g6), .P_i(p6), .G_j(g3), .P_j(p3));
    GP_trn gp_trn8  (.G_k(C6), .P_k(Pk6), .G_i(g7), .P_i(p7), .G_j(C2), .P_j(Pk2));
    GP_trn gp_trn9  (.G_k(C7), .P_k(Pk7), .G_i(G6), .P_i(P6), .G_j(C6), .P_j(Pk6));
    GP_trn gp_trn10  (.G_k(g10), .P_k(p10), .G_i(G7), .P_i(P7), .G_j(G6), .P_j(P6));
    GP_trn gp_trn11  (.G_k(g11), .P_k(p11), .G_i(g10), .P_i(p10), .G_j(g6), .P_j(p6));
    GP_trn gp_trn12  (.G_k(C8), .P_k(Pk8), .G_i(g11), .P_i(p11), .G_j(C4), .P_j(Pk4));
    GP_trn gp_trn13  (.G_k(C9), .P_k(Pk9), .G_i(G8), .P_i(P8), .G_j(C8), .P_j(Pk8));
    GP_trn gp_trn14  (.G_k(g14), .P_k(p14), .G_i(G9), .P_i(P9), .G_j(G8), .P_j(P8));
    GP_trn gp_trn15  (.G_k(g15), .P_k(p15), .G_i(g14), .P_i(p14), .G_j(g10), .P_j(p10));
    GP_trn gp_trn16  (.G_k(g16), .P_k(p16), .G_i(g15), .P_i(p15), .G_j(g7), .P_j(p7));
    GP_trn gp_trn17  (.G_k(C10), .P_k(Pk10), .G_i(g16), .P_i(p16), .G_j(C2), .P_j(Pk2));
    GP_trn gp_trn18  (.G_k(C11), .P_k(Pk11), .G_i(G10), .P_i(P10), .G_j(C10), .P_j(Pk10));
    GP_trn gp_trn19  (.G_k(g19), .P_k(p19), .G_i(G11), .P_i(P11), .G_j(G10), .P_j(P10));
    GP_trn gp_trn20  (.G_k(g20), .P_k(p20), .G_i(g19), .P_i(p19), .G_j(g14), .P_j(p14));
    GP_trn gp_trn21  (.G_k(g21), .P_k(p21), .G_i(g20), .P_i(p20), .G_j(g11), .P_j(p11));
    GP_trn gp_trn22  (.G_k(C12), .P_k(Pk12), .G_i(g21), .P_i(p21), .G_j(C4), .P_j(Pk4));
    
endmodule

//Sklansky Adder 
module Sklan_13 (//input
             A,
             B,
             //output
             OUT);

    input  signed [12:0]  A, B;
    output signed [12:0] OUT;

    VLSI_XOR2 xor_0 (.OUT(OUT[0]), .INA(A[0]), .INB(B[0]));
    VLSI_XOR3 xor_1 (.OUT(OUT[1]), .INA(A[1]), .INB(B[1]), .INC(G0));
    VLSI_XOR3 xor_2 (.OUT(OUT[2]), .INA(A[2]), .INB(B[2]), .INC(C2));
    VLSI_XOR3 xor_3 (.OUT(OUT[3]), .INA(A[3]), .INB(B[3]), .INC(C3));
    VLSI_XOR3 xor_4 (.OUT(OUT[4]), .INA(A[4]), .INB(B[4]), .INC(C4));
    VLSI_XOR3 xor_5 (.OUT(OUT[5]), .INA(A[5]), .INB(B[5]), .INC(C5));
    VLSI_XOR3 xor_6 (.OUT(OUT[6]), .INA(A[6]), .INB(B[6]), .INC(C6));
    VLSI_XOR3 xor_7  (.OUT(OUT[7]),  .INA(A[7]),  .INB(B[7]),  .INC(C7) );
    VLSI_XOR3 xor_8  (.OUT(OUT[8]),  .INA(A[8]),  .INB(B[8]),  .INC(C8) );
    VLSI_XOR3 xor_9  (.OUT(OUT[9]),  .INA(A[9]),  .INB(B[9]),  .INC(C9) );
    VLSI_XOR3 xor_10 (.OUT(OUT[10]), .INA(A[10]), .INB(B[10]), .INC(C10));
    VLSI_XOR3 xor_11 (.OUT(OUT[11]), .INA(A[11]), .INB(B[11]), .INC(C11));
    VLSI_XOR3 xor_12 (.OUT(OUT[12]), .INA(A[12]), .INB(B[12]), .INC(C12));

    GP_gen gp_gen0  (.P(P0), .G(G0), .A(A[0]),   .B(B[0])  );
    GP_gen gp_gen1  (.P(P1), .G(G1), .A(A[1]),   .B(B[1])  );
    GP_gen gp_gen2  (.P(P2), .G(G2), .A(A[2]),   .B(B[2])  );
    GP_gen gp_gen3  (.P(P3), .G(G3), .A(A[3]),   .B(B[3])  );
    GP_gen gp_gen4  (.P(P4), .G(G4), .A(A[4]),   .B(B[4])  );
    GP_gen gp_gen5  (.P(P5), .G(G5), .A(A[5]),   .B(B[5])  );
    GP_gen gp_gen6  (.P(P6), .G(G6), .A(A[6]),   .B(B[6])  );
    GP_gen gp_gen7   (.P(P7),  .G(G7),  .A(A[7]),    .B(B[7])   );
    GP_gen gp_gen8   (.P(P8),  .G(G8),  .A(A[8]),    .B(B[8])   );
    GP_gen gp_gen9   (.P(P9),  .G(G9),  .A(A[9]),    .B(B[9])   );
    GP_gen gp_gen10  (.P(P10), .G(G10), .A(A[10]),   .B(B[10])  );
    GP_gen gp_gen11  (.P(P11), .G(G11), .A(A[11]),   .B(B[11])  );

    GP_trn gp_trn0  (.G_k(C2), .P_k(Pk0), .G_i(G1), .P_i(P1), .G_j(G0), .P_j(P0) );
    GP_trn gp_trn1  (.G_k(C3), .P_k(Pk1), .G_i(G2), .P_i(P2), .G_j(C2), .P_j(Pk0) );
    GP_trn gp_trn2  (.G_k(Gk2), .P_k(Pk2), .G_i(G3), .P_i(P3), .G_j(G2), .P_j(P2) );
    GP_trn gp_trn3  (.G_k(C4), .P_k(Pk3), .G_i(Gk2), .P_i(Pk2), .G_j(C2), .P_j(Pk0) );
    GP_trn gp_trn4  (.G_k(C5), .P_k(Pk4), .G_i(G4), .P_i(P4), .G_j(C4), .P_j(Pk3) );
    GP_trn gp_trn5  (.G_k(Gk5), .P_k(Pk5), .G_i(G5), .P_i(P5), .G_j(G4), .P_j(P4) );
    GP_trn gp_trn6  (.G_k(C6), .P_k(Pk6), .G_i(Gk5), .P_i(Pk5), .G_j(C4), .P_j(Pk3) );
    GP_trn gp_trn7  (.G_k(g7), .P_k(p7), .G_i(G6), .P_i(P6), .G_j(Gk5), .P_j(Pk5) );
    GP_trn gp_trn8  (.G_k(C7), .P_k(p8), .G_i(g7), .P_i(p7), .G_j(C4), .P_j(Pk3) );
    GP_trn gp_trn9  (.G_k(g9), .P_k(p9), .G_i(G7), .P_i(P7), .G_j(G6), .P_j(P6) );
    GP_trn gp_trn10  (.G_k(g10), .P_k(p10), .G_i(g9), .P_i(p9), .G_j(Gk5), .P_j(Pk5) );
    GP_trn gp_trn11  (.G_k(C8), .P_k(p11), .G_i(g10), .P_i(p10), .G_j(C4), .P_j(Pk3) );
    GP_trn gp_trn12  (.G_k(C9), .P_k(p12), .G_i(G8), .P_i(P8), .G_j(C8), .P_j(p11) );
    GP_trn gp_trn13  (.G_k(g13), .P_k(p13), .G_i(G9), .P_i(P9), .G_j(G8), .P_j(P8) );
    GP_trn gp_trn14  (.G_k(C10), .P_k(p14), .G_i(g13), .P_i(p13), .G_j(C8), .P_j(p11) );
    GP_trn gp_trn15  (.G_k(g15), .P_k(p15), .G_i(G10), .P_i(P10), .G_j(g13), .P_j(p13) );
    GP_trn gp_trn16  (.G_k(C11), .P_k(p16), .G_i(g15), .P_i(p15), .G_j(C8), .P_j(p11) );
    GP_trn gp_trn17  (.G_k(g17), .P_k(p17), .G_i(G11), .P_i(P11), .G_j(G10), .P_j(P10) );
    GP_trn gp_trn18  (.G_k(g18), .P_k(p18), .G_i(g17), .P_i(p17), .G_j(g13), .P_j(p13) );
    GP_trn gp_trn19  (.G_k(C12), .P_k(p19), .G_i(g18), .P_i(p18), .G_j(C8), .P_j(p11) );

endmodule