 `include "GATE_LIB.v"

module MAC6 (//input
             A,
             B,
             MODE,
             ACC,
             //output
             OUT);

    input  signed [5:0]  A, B;
    input  signed [11:0] ACC;
    input  signed [1:0]  MODE;
    output signed [12:0] OUT;

    wire signed [5:0]  B_b;
    wire signed [6:0]  op23;
    wire signed [11:0] ACC_b, AxB;
    wire signed [12:0] OP01, OP23;

    assign OP23 = op23;

    COM_6  com_6  (.B_bar(B_b),     .B(B),     .MODE(MODE[0]));
    COM_12 com_12 (.ACC_bar(ACC_b), .ACC(ACC), .MODE(MODE[0]));

    MULT_6   mult_6  (.OUT(OP01), .A(A), .B(B),   .ACC(ACC_b), .MODE(MODE)); //op01 output
    ADDER_7  adder_7 (.OUT(op23), .A(A), .B(B_b), .CIN(MODE[0])           ); //op23 output

    MUX_13 mux_13 (.OUT(OUT), .A(OP01), .B(OP23), .sel(MODE[1]));            //select output
    
endmodule

//---------------------------------------------------------------------------------//
//                            Functional Blocks below                              //
//---------------------------------------------------------------------------------//

// 6-bit Booth Multiplier-----------------------------------------------------------
module MULT_6(//input
            A,
            B,
            ACC,
            MODE,
            //output
            OUT
            );

    input signed  [1:0]  MODE;
    input signed  [5:0]  A, B;
    input signed  [11:0] ACC;
    output signed [12:0] OUT;

    wire N0, N1, N2;
    wire signed [6:0] A_i, Pi0, Pi1, Pi2, Pi3;
    wire signed [12:0] P0, P1, P2, P3, P4, P5;
    wire signed [12:0] S, C;

    assign A_i  = A;
    assign Pi3 = {1'b0, N2, 1'b0, N1, 1'b0, N0};

    assign P0 = Pi0;
    assign P1 = Pi1 << 2;
    assign P2 = Pi2 << 4;
    assign P3 = Pi3;
    assign P4 = ACC;
    assign P5 = MODE[0];

    ENCODER en0   (.S(S0), .D(D0), .N(N0), .Xa(B[1]), .Xb(B[0]), .Xc(1'b0));
    ENCODER en1   (.S(S1), .D(D1), .N(N1), .Xa(B[3]), .Xb(B[2]), .Xc(B[1]));
    ENCODER en2   (.S(S2), .D(D2), .N(N2), .Xa(B[5]), .Xb(B[4]), .Xc(B[3]));

    SELECTOR sl0  (.P(Pi0[0]), .A0(1'b0),   .A1(A_i[0]), .S(S0), .D(D0), .N(N0));
    SELECTOR sl1  (.P(Pi0[1]), .A0(A_i[0]), .A1(A_i[1]), .S(S0), .D(D0), .N(N0));
    SELECTOR sl2  (.P(Pi0[2]), .A0(A_i[1]), .A1(A_i[2]), .S(S0), .D(D0), .N(N0));
    SELECTOR sl3  (.P(Pi0[3]), .A0(A_i[2]), .A1(A_i[3]), .S(S0), .D(D0), .N(N0));
    SELECTOR sl4  (.P(Pi0[4]), .A0(A_i[3]), .A1(A_i[4]), .S(S0), .D(D0), .N(N0));
    SELECTOR sl5  (.P(Pi0[5]), .A0(A_i[4]), .A1(A_i[5]), .S(S0), .D(D0), .N(N0));
    SELECTOR sl6  (.P(Pi0[6]), .A0(A_i[5]), .A1(A_i[6]), .S(S0), .D(D0), .N(N0));

    SELECTOR sl7  (.P(Pi1[0]), .A0(1'b0),   .A1(A_i[0]), .S(S1), .D(D1), .N(N1));
    SELECTOR sl8  (.P(Pi1[1]), .A0(A_i[0]), .A1(A_i[1]), .S(S1), .D(D1), .N(N1));
    SELECTOR sl9  (.P(Pi1[2]), .A0(A_i[1]), .A1(A_i[2]), .S(S1), .D(D1), .N(N1));
    SELECTOR sl10 (.P(Pi1[3]), .A0(A_i[2]), .A1(A_i[3]), .S(S1), .D(D1), .N(N1));
    SELECTOR sl11 (.P(Pi1[4]), .A0(A_i[3]), .A1(A_i[4]), .S(S1), .D(D1), .N(N1));
    SELECTOR sl12 (.P(Pi1[5]), .A0(A_i[4]), .A1(A_i[5]), .S(S1), .D(D1), .N(N1));
    SELECTOR sl13 (.P(Pi1[6]), .A0(A_i[5]), .A1(A_i[6]), .S(S1), .D(D1), .N(N1));

    SELECTOR sl14 (.P(Pi2[0]), .A0(1'b0),   .A1(A_i[0]), .S(S2), .D(D2), .N(N2));
    SELECTOR sl15 (.P(Pi2[1]), .A0(A_i[0]), .A1(A_i[1]), .S(S2), .D(D2), .N(N2));
    SELECTOR sl16 (.P(Pi2[2]), .A0(A_i[1]), .A1(A_i[2]), .S(S2), .D(D2), .N(N2));
    SELECTOR sl17 (.P(Pi2[3]), .A0(A_i[2]), .A1(A_i[3]), .S(S2), .D(D2), .N(N2));
    SELECTOR sl18 (.P(Pi2[4]), .A0(A_i[3]), .A1(A_i[4]), .S(S2), .D(D2), .N(N2));
    SELECTOR sl19 (.P(Pi2[5]), .A0(A_i[4]), .A1(A_i[5]), .S(S2), .D(D2), .N(N2));
    SELECTOR sl20 (.P(Pi2[6]), .A0(A_i[5]), .A1(A_i[6]), .S(S2), .D(D2), .N(N2));

    CSA csa (.SUM(S), .COUT(C), .A(P0), .B(P1), .C(P2), .D(P3), .E(P4), .F(P5));

    ADDER_13 adder_13 (.OUT(OUT), .A(S), .B(C));

endmodule

module ENCODER (//input
                Xa, Xb, Xc,
                //output
                S, D, N
                );

    input Xa, Xb, Xc;
    output S, D, N;

    VLSI_XOR2  xor_0 (.OUT(S),    .INA(Xb),   .INB(Xc)              );
    VLSI_NOT   not_a (.OUT(Xa_b), .IN(Xa)                           );
    VLSI_NOT   not_b (.OUT(Xb_b), .IN(Xb)                           );
    VLSI_NOT   not_c (.OUT(Xc_b), .IN(Xc)                           );
    VLSI_NAND3 nd3_0 (.OUT(d0),   .INA(Xa_b), .INB(Xb),   .INC(Xc)  );
    VLSI_NAND3 nd3_1 (.OUT(d1),   .INA(Xa),   .INB(Xb_b), .INC(Xc_b));
    VLSI_NAND2 nd2_0 (.OUT(D),    .INA(d0),   .INB(d1)              );
    assign N = Xa;

endmodule

module SELECTOR (//input
                A0, A1,
                S, D, N,
                //output
                P
                );

    input A0, A1, S, D, N;
    output P;

    VLSI_NAND2 nd_0 (.OUT(Di),  .INA(A0),  .INB(D) );
    VLSI_NAND2 nd_1 (.OUT(Si),  .INA(A1),  .INB(S) );
    VLSI_NAND2 nd_2 (.OUT(P_i), .INA(Di),  .INB(Si));
    VLSI_XOR2  xr_0 (.OUT(P),   .INA(P_i), .INB(N) );

endmodule

module CSA (//input
            A, B, 
            C, D,
            E, F,
            //output
            SUM, COUT
            );

    input signed  [12:0] A, B, C, D, E, F;
    output signed [12:0] SUM, COUT;
    wire signed [12:0] G, H, I, J, K, L;

    assign H[0] = 1'b0;
    FA f0  (.SUM(G[0]),  .COUT(H[1]),  .A(A[0]),  .B(B[0]),  .CIN(C[0]));
    FA f1  (.SUM(G[1]),  .COUT(H[2]),  .A(A[1]),  .B(B[1]),  .CIN(C[1]));
    FA f2  (.SUM(G[2]),  .COUT(H[3]),  .A(A[2]),  .B(B[2]),  .CIN(C[2]));
    FA f3  (.SUM(G[3]),  .COUT(H[4]),  .A(A[3]),  .B(B[3]),  .CIN(C[3]));
    FA f4  (.SUM(G[4]),  .COUT(H[5]),  .A(A[4]),  .B(B[4]),  .CIN(C[4]));
    FA f5  (.SUM(G[5]),  .COUT(H[6]),  .A(A[5]),  .B(B[5]),  .CIN(C[5]));
    FA f6  (.SUM(G[6]),  .COUT(H[7]),  .A(A[6]),  .B(B[6]),  .CIN(C[6]));
    FA f7  (.SUM(G[7]),  .COUT(H[8]),  .A(A[7]),  .B(B[7]),  .CIN(C[7]));
    FA f8  (.SUM(G[8]),  .COUT(H[9]),  .A(A[8]),  .B(B[8]),  .CIN(C[8]));
    FA f9  (.SUM(G[9]),  .COUT(H[10]), .A(A[9]),  .B(B[9]),  .CIN(C[9]));
    FA f10 (.SUM(G[10]), .COUT(H[11]), .A(A[10]), .B(B[10]), .CIN(C[10]));
    FA f44 (.SUM(G[11]), .COUT(H[12]), .A(A[11]), .B(B[11]), .CIN(C[11]));
    VLSI_XOR3 x0 (.OUT(G[12]), .INA(A[12]), .INB(B[12]), .INC(C[12]));

    assign L[0] = 1'b0;
    FA f11 (.SUM(I[0]),  .COUT(L[1]),  .A(D[0]),  .B(E[0]),  .CIN(F[0]));
    FA f12 (.SUM(I[1]),  .COUT(L[2]),  .A(D[1]),  .B(E[1]),  .CIN(F[1]));
    FA f13 (.SUM(I[2]),  .COUT(L[3]),  .A(D[2]),  .B(E[2]),  .CIN(F[2]));
    FA f14 (.SUM(I[3]),  .COUT(L[4]),  .A(D[3]),  .B(E[3]),  .CIN(F[3]));
    FA f15 (.SUM(I[4]),  .COUT(L[5]),  .A(D[4]),  .B(E[4]),  .CIN(F[4]));
    FA f16 (.SUM(I[5]),  .COUT(L[6]),  .A(D[5]),  .B(E[5]),  .CIN(F[5]));
    FA f17 (.SUM(I[6]),  .COUT(L[7]),  .A(D[6]),  .B(E[6]),  .CIN(F[6]));
    FA f18 (.SUM(I[7]),  .COUT(L[8]),  .A(D[7]),  .B(E[7]),  .CIN(F[7]));
    FA f19 (.SUM(I[8]),  .COUT(L[9]),  .A(D[8]),  .B(E[8]),  .CIN(F[8]));
    FA f20 (.SUM(I[9]),  .COUT(L[10]), .A(D[9]),  .B(E[9]),  .CIN(F[9]));
    FA f21 (.SUM(I[10]), .COUT(L[11]), .A(D[10]), .B(E[10]), .CIN(F[10]));
    FA f45 (.SUM(I[11]), .COUT(L[12]), .A(D[11]), .B(E[11]), .CIN(F[11]));
    VLSI_XOR3 x1 (.OUT(I[12]), .INA(D[12]), .INB(E[12]), .INC(F[12]));

    assign K[0] = 1'b0;
    FA f22 (.SUM(J[0]),  .COUT(K[1]),  .A(  G[0]),    .B(H[0]),  .CIN(I[0]));
    FA f23 (.SUM(J[1]),  .COUT(K[2]),  .A(  G[1]),    .B(H[1]),  .CIN(I[1]));
    FA f24 (.SUM(J[2]),  .COUT(K[3]),  .A(  G[2]),    .B(H[2]),  .CIN(I[2]));
    FA f25 (.SUM(J[3]),  .COUT(K[4]),  .A(  G[3]),    .B(H[3]),  .CIN(I[3]));
    FA f26 (.SUM(J[4]),  .COUT(K[5]),  .A(  G[4]),    .B(H[4]),  .CIN(I[4]));
    FA f27 (.SUM(J[5]),  .COUT(K[6]),  .A(  G[5]),    .B(H[5]),  .CIN(I[5]));
    FA f28 (.SUM(J[6]),  .COUT(K[7]),  .A(  G[6]),    .B(H[6]),  .CIN(I[6]));
    FA f29 (.SUM(J[7]),  .COUT(K[8]),  .A(  G[7]),    .B(H[7]),  .CIN(I[7]));
    FA f30 (.SUM(J[8]),  .COUT(K[9]),  .A(  G[8]),    .B(H[8]),  .CIN(I[8]));
    FA f31 (.SUM(J[9]),  .COUT(K[10]), .A(  G[9]),    .B(H[9]),  .CIN(I[9]));
    FA f32 (.SUM(J[10]), .COUT(K[11]), .A(  G[10]),   .B(H[10]), .CIN(I[10]));
    FA f46 (.SUM(J[11]), .COUT(K[12]), .A(  G[11]),   .B(H[11]), .CIN(I[11]));
    VLSI_XOR3 x2 (.OUT(J[12]), .INA(G[12]), .INB(H[12]), .INC(I[12]));

    assign COUT[0] = 1'b0;
    FA f33 (.SUM(SUM[0]),  .COUT(COUT[1]),  .A(  J[0]),    .B(K[0]),  .CIN(L[0]));
    FA f34 (.SUM(SUM[1]),  .COUT(COUT[2]),  .A(  J[1]),    .B(K[1]),  .CIN(L[1]));
    FA f35 (.SUM(SUM[2]),  .COUT(COUT[3]),  .A(  J[2]),    .B(K[2]),  .CIN(L[2]));
    FA f36 (.SUM(SUM[3]),  .COUT(COUT[4]),  .A(  J[3]),    .B(K[3]),  .CIN(L[3]));
    FA f37 (.SUM(SUM[4]),  .COUT(COUT[5]),  .A(  J[4]),    .B(K[4]),  .CIN(L[4]));
    FA f38 (.SUM(SUM[5]),  .COUT(COUT[6]),  .A(  J[5]),    .B(K[5]),  .CIN(L[5]));
    FA f39 (.SUM(SUM[6]),  .COUT(COUT[7]),  .A(  J[6]),    .B(K[6]),  .CIN(L[6]));
    FA f40 (.SUM(SUM[7]),  .COUT(COUT[8]),  .A(  J[7]),    .B(K[7]),  .CIN(L[7]));
    FA f41 (.SUM(SUM[8]),  .COUT(COUT[9]),  .A(  J[8]),    .B(K[8]),  .CIN(L[8]));
    FA f42 (.SUM(SUM[9]),  .COUT(COUT[10]), .A(  J[9]),    .B(K[9]),  .CIN(L[9]));
    FA f43 (.SUM(SUM[10]), .COUT(COUT[11]), .A(  J[10]),   .B(K[10]), .CIN(L[10]));
    FA f47 (.SUM(SUM[11]), .COUT(COUT[12]), .A(  J[11]),   .B(K[11]), .CIN(L[11]));
    VLSI_XOR3 x3 (.OUT(SUM [12]), .INA(J[12]), .INB(K[12]), .INC(L[12]));

endmodule

module FA (A, B, CIN, COUT, SUM);
    input A, B, CIN;
    output COUT, SUM;

    VLSI_XOR3  X_XOR3_1  (.OUT(SUM),  .INA(A),  .INB(B), .INC(CIN));
    VLSI_NAND2 X_NAND2_1 (.OUT(L1),   .INA(A),  .INB(B));
    VLSI_NAND2 X_NAND2_2 (.OUT(L2),   .INA(B),  .INB(CIN));
    VLSI_NAND2 X_NAND2_3 (.OUT(L3),   .INA(A),  .INB(CIN));
    VLSI_NAND3 X_NAND3_1 (.OUT(COUT), .INA(L1), .INB(L2), .INC(L3));
endmodule


//Han-Carlson Adder for Mode 2, 3 ---------------------------------------------------------------- 
module ADDER_7 (//input
             A,
             B,
             CIN,
             //output
             OUT);

    input  signed [5:0]  A, B;
    input CIN;
    output signed [6:0] OUT;

    wire signed [6:0] A_i, B_i;

    assign A_i = A; //sign extension
    assign B_i = B; //sign extension

    VLSI_XOR3 xor_0 (.OUT(OUT[0]), .INA(A_i[0]), .INB(B_i[0]), .INC(CIN));
    VLSI_XOR3 xor_1 (.OUT(OUT[1]), .INA(A_i[1]), .INB(B_i[1]), .INC(C1));
    VLSI_XOR3 xor_2 (.OUT(OUT[2]), .INA(A_i[2]), .INB(B_i[2]), .INC(C2));
    VLSI_XOR3 xor_3 (.OUT(OUT[3]), .INA(A_i[3]), .INB(B_i[3]), .INC(C3));
    VLSI_XOR3 xor_4 (.OUT(OUT[4]), .INA(A_i[4]), .INB(B_i[4]), .INC(C4));
    VLSI_XOR3 xor_5 (.OUT(OUT[5]), .INA(A_i[5]), .INB(B_i[5]), .INC(C5));
    VLSI_XOR3 xor_6 (.OUT(OUT[6]), .INA(A_i[6]), .INB(B_i[6]), .INC(C6));

    GP_gen gp_gen0  (.P(P0), .G(G0), .A(A_i[0]),   .B(B_i[0])  );
    GP_gen gp_gen1  (.P(P1), .G(G1), .A(A_i[1]),   .B(B_i[1])  );
    GP_gen gp_gen2  (.P(P2), .G(G2), .A(A_i[2]),   .B(B_i[2])  );
    GP_gen gp_gen3  (.P(P3), .G(G3), .A(A_i[3]),   .B(B_i[3])  );
    GP_gen gp_gen4  (.P(P4), .G(G4), .A(A_i[4]),   .B(B_i[4])  );
    GP_gen gp_gen5  (.P(P5), .G(G5), .A(A_i[5]),   .B(B_i[5])  );
    GP_gen gp_gen6  (.P(P6), .G(G6), .A(A_i[6]),   .B(B_i[6])  );

    VLSI_AND2 and_0 (.OUT(c1), .INA(P0), .INB(CIN));
    VLSI_OR2 or_0   (.OUT(C1), .INA(G0), .INB(c1));
    GP_trn gp_trn1  (.G_k(C2), .P_k(Pk2), .G_i(G1), .P_i(P1), .G_j(C1), .P_j(P0));
    GP_trn gp_trn2  (.G_k(C3), .P_k(Pk3), .G_i(G2), .P_i(P2), .G_j(C2), .P_j(Pk2));
    GP_trn gp_trn3  (.G_k(g3), .P_k(p3), .G_i(G3), .P_i(P3), .G_j(G2), .P_j(P2));
    GP_trn gp_trn4  (.G_k(C4), .P_k(Pk4), .G_i(g3), .P_i(p3), .G_j(C2), .P_j(Pk2));
    GP_trn gp_trn5  (.G_k(C5), .P_k(Pk5), .G_i(G4), .P_i(P4), .G_j(C4), .P_j(Pk4));
    GP_trn gp_trn6  (.G_k(g6), .P_k(p6), .G_i(G5), .P_i(P5), .G_j(G4), .P_j(P4));
    GP_trn gp_trn7  (.G_k(g7), .P_k(p7), .G_i(g6), .P_i(p6), .G_j(g3), .P_j(p3));
    GP_trn gp_trn8  (.G_k(C6), .P_k(Pk6), .G_i(g7), .P_i(p7), .G_j(C2), .P_j(Pk2));
    
endmodule
//------------------------------------------------------------------------------------

//Han-Carlson Adder for Mode 0, 1 ---------------------------------------------------------------- 
module ADDER_13 (//input
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
//------------------------------------------------------------------------------------


//two's complement of B input      Output: B_bar[5:0]
module COM_6 (//input
             B,
             MODE  ,
             //output
             B_bar);

    input  signed [5:0]  B;
    input MODE;
    output signed [5:0] B_bar;

    VLSI_XOR2 xor_0 (.OUT(B_bar[0]), .INA(B[0]), .INB(MODE));
    VLSI_XOR2 xor_1 (.OUT(B_bar[1]), .INA(B[1]), .INB(MODE));
    VLSI_XOR2 xor_2 (.OUT(B_bar[2]), .INA(B[2]), .INB(MODE));
    VLSI_XOR2 xor_3 (.OUT(B_bar[3]), .INA(B[3]), .INB(MODE));
    VLSI_XOR2 xor_4 (.OUT(B_bar[4]), .INA(B[4]), .INB(MODE));
    VLSI_XOR2 xor_5 (.OUT(B_bar[5]), .INA(B[5]), .INB(MODE));

endmodule
//------------------------------------------------------------------------------------

//two's complement of ACC input      Output: ACC_bar[11:0]
module COM_12 (//input
             ACC,
             MODE  ,
             //output
             ACC_bar);

    input  signed [11:0]  ACC;
    input MODE;
    output signed [11:0] ACC_bar;

    VLSI_XOR2 xor_0  (.OUT(ACC_bar[0]),  .INA(ACC[0]),  .INB(MODE));
    VLSI_XOR2 xor_1  (.OUT(ACC_bar[1]),  .INA(ACC[1]),  .INB(MODE));
    VLSI_XOR2 xor_2  (.OUT(ACC_bar[2]),  .INA(ACC[2]),  .INB(MODE));
    VLSI_XOR2 xor_3  (.OUT(ACC_bar[3]),  .INA(ACC[3]),  .INB(MODE));
    VLSI_XOR2 xor_4  (.OUT(ACC_bar[4]),  .INA(ACC[4]),  .INB(MODE));
    VLSI_XOR2 xor_5  (.OUT(ACC_bar[5]),  .INA(ACC[5]),  .INB(MODE));
    VLSI_XOR2 xor_6  (.OUT(ACC_bar[6]),  .INA(ACC[6]),  .INB(MODE));
    VLSI_XOR2 xor_7  (.OUT(ACC_bar[7]),  .INA(ACC[7]),  .INB(MODE));
    VLSI_XOR2 xor_8  (.OUT(ACC_bar[8]),  .INA(ACC[8]),  .INB(MODE));
    VLSI_XOR2 xor_9  (.OUT(ACC_bar[9]),  .INA(ACC[9]),  .INB(MODE));
    VLSI_XOR2 xor_10 (.OUT(ACC_bar[10]), .INA(ACC[10]), .INB(MODE));
    VLSI_XOR2 xor_11 (.OUT(ACC_bar[11]), .INA(ACC[11]), .INB(MODE));

endmodule
//------------------------------------------------------------------------------------


// 13-bit MUX -------------------------------------------------------------------
module MUX_13 (//input
             A,
             B,
             sel,
             //output
             OUT);

    input  signed [12:0]  A, B;
    input sel;
    output signed [12:0] OUT;

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
    MUX m12 (.OUT(OUT[12]), .A(A[12]), .B(B[12]), .sel(sel));

endmodule

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
//------------------------------------------------------------------------------------


//block for adder---------------------------------------------------------------------
module GP_gen (//input
            A, B,
            //output
            G, P);

    input  A, B;
    output G, P;

    VLSI_OR2  or_0  (.OUT(P), .INA(A), .INB(B));
    VLSI_AND2 and_0 (.OUT(G), .INA(A), .INB(B));

endmodule

module GP_trn (//input
            G_i, P_i,
            G_j, P_j,
            //output
            G_k,
            P_k);

    input  G_i, G_j, P_i, P_j;
    output G_k, P_k;

    VLSI_AND2 and_0 (.OUT(P_k), .INA(P_j), .INB(P_i));
    VLSI_AND2 and_1 (.OUT(g_i), .INA(P_i), .INB(G_j));
    VLSI_OR2  or_0  (.OUT(G_k), .INA(g_i), .INB(G_i));

endmodule
//------------------------------------------------------------------------------------------