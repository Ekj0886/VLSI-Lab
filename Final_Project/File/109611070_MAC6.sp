***** Define your sub-circuit and self-defined parameter here , and only need to submmit this part ****

.subckt MAC6 CLK A[5] A[4] A[3] A[2] A[1] A[0]
+ B[5] B[4] B[3] B[2] B[1] B[0] 
+ MODE
+ ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0]
+ OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0]

XBOOTH A[0] A[1] A[2] A[3] A[4] A[5]
+ B[0] B[1] B[2] B[3] B[4] B[5]
+ PP0[0] PP0[1] PP0[2] PP0[3] PP0[4] PP0[5] PP0[6]
+ PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5] PP1[6]
+ PP2[0] PP2[1] PP2[2] PP2[3] PP2[4] PP2[5] PP2[6] 
+ A_d[1] A_d[3] A_d[5]
+ CLK Booth

XACCXOR MODE ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0] 
+cACC[11] cACC[10] cACC[9] cACC[8] cACC[7] cACC[6] cACC[5] cACC[4] cACC[3] cACC[2] cACC[1] cACC[0] CLK
+dMODE ACCXOR

XCSA dMODE PP0[6] PP0[5] PP0[4] PP0[3] PP0[2] PP0[1] PP0[0] 
+PP1[6] PP1[5] PP1[4] PP1[3] PP1[2] PP1[1] PP1[0] 
+PP2[6] PP2[5] PP2[4] PP2[3] PP2[2] PP2[1] PP2[0] 
+A_d[1] A_d[3] A_d[5] 
+cACC[11] cACC[10] cACC[9] cACC[8] cACC[7] cACC[6] cACC[5] cACC[4] cACC[3] cACC[2] cACC[1] cACC[0] 
+C[12] C[11] C[10] C[9] C[8] C[7] C[6] C[5] C[4] C[3] C[2] C[1] 
+S[12] S[11] S[10] S[9] S[8] S[7] S[6] S[5] S[4] S[3] S[2] S[1] S[0]
+CLK CIN CSA

XADDER CIN C[12] C[11] C[10] C[9] C[8] C[7] C[6] C[5] C[4] C[3] C[2] C[1] GND
+ S[12] S[11] S[10] S[9] S[8] S[7] S[6] S[5] S[4] S[3] S[2] S[1] S[0]
+ OUT1[12] OUT1[11] OUT1[10] OUT1[9] OUT1[8] OUT1[7] OUT1[6] OUT1[5] OUT1[4] OUT1[3] OUT1[2] OUT1[1] OUT1[0] ADDER

X02 CLK OUT1[12] OUT1[11] OUT1[10] OUT1[9] OUT1[8] OUT1[7] OUT1[6] OUT1[5] OUT1[4] OUT1[3] OUT1[2] OUT1[1] OUT1[0]
+ OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0] DF2
.ends

***************************************************************************************

.subckt Booth A[0] A[1] A[2] A[3] A[4] A[5]
+ B[0] B[1] B[2] B[3] B[4] B[5]
+ PP0[0] PP0[1] PP0[2] PP0[3] PP0[4] PP0[5] PP0[6]
+ PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5] PP1[6]
+ PP2[0] PP2[1] PP2[2] PP2[3] PP2[4] PP2[5] PP2[6]
+ A_d[1] A_d[3] A_d[5]
+ CLK

Xdffa0 A[0] CLK A_d[0] DFF
Xdffa1 A[1] CLK A_d[1] DFF
Xdffa2 A[2] CLK A_d[2] DFF
Xdffa3 A[3] CLK A_d[3] DFF
Xdffa4 A[4] CLK A_d[4] DFF
Xdffa5 A[5] CLK A_d[5] DFF

Xdffb0 B[0] CLK B_d[0] DFF
Xdffb1 B[1] CLK B_d[1] DFF
Xdffb2 B[2] CLK B_d[2] DFF
Xdffb3 B[3] CLK B_d[3] DFF
Xdffb4 B[4] CLK B_d[4] DFF
Xdffb5 B[5] CLK B_d[5] DFF

Xe0   A_d[1] A_d[0] GND  S0 D0 ENCODER
Xsel00 GND  B_d[0] S0 D0 A_d[1] PP0[0] SELECT
Xsel01 B_d[0] B_d[1] S0 D0 A_d[1] PP0[1] SELECT
Xsel02 B_d[1] B_d[2] S0 D0 A_d[1] PP0[2] SELECT
Xsel03 B_d[2] B_d[3] S0 D0 A_d[1] PP0[3] SELECT
Xsel04 B_d[3] B_d[4] S0 D0 A_d[1] PP0[4] SELECT
Xsel05 B_d[4] B_d[5] S0 D0 A_d[1] PP0[5] SELECT
Xsel06 B_d[5] B_d[5] S0 D0 A_d[1] PP0[6] SELECT

Xe1   A_d[3] A_d[2] A_d[1]  S1 D1 ENCODER
Xsel10 GND  B_d[0] S1 D1 A_d[3] PP1[0] SELECT
Xsel11 B_d[0] B_d[1] S1 D1 A_d[3] PP1[1] SELECT
Xsel12 B_d[1] B_d[2] S1 D1 A_d[3] PP1[2] SELECT
Xsel13 B_d[2] B_d[3] S1 D1 A_d[3] PP1[3] SELECT
Xsel14 B_d[3] B_d[4] S1 D1 A_d[3] PP1[4] SELECT
Xsel15 B_d[4] B_d[5] S1 D1 A_d[3] PP1[5] SELECT
Xsel16 B_d[5] B_d[5] S1 D1 A_d[3] PP1[6] SELECT

Xe2   A_d[5] A_d[4] A_d[3]  S2 D2 ENCODER
Xsel20 GND  B_d[0] S2 D2 A_d[5] PP2[0] SELECT
Xsel21 B_d[0] B_d[1] S2 D2 A_d[5] PP2[1] SELECT
Xsel22 B_d[1] B_d[2] S2 D2 A_d[5] PP2[2] SELECT
Xsel23 B_d[2] B_d[3] S2 D2 A_d[5] PP2[3] SELECT
Xsel24 B_d[3] B_d[4] S2 D2 A_d[5] PP2[4] SELECT
Xsel25 B_d[4] B_d[5] S2 D2 A_d[5] PP2[5] SELECT
Xsel26 B_d[5] B_d[5] S2 D2 A_d[5] PP2[6] SELECT
.ends

.param wp = 0.44u
.param wn = 0.44u

.param w1 = 0.44u
.param w2 = 0.58u

.subckt ENCODER A B C S D
M1 N002 _A N005 GND N_18_G2 l=0.18u w=wn
M2 N005 B N007 GND N_18_G2 l=0.18u w=wn
M3 N007 C GND GND N_18_G2 l=0.18u w=wn
M4 N002 _C N006 GND N_18_G2 l=0.18u w=wn
M5 N006 _B N008 GND N_18_G2 l=0.18u w=wn
M6 N008 A GND GND N_18_G2 l=0.18u w=wn
M7 _A A GND GND N_18_G2 l=0.18u w=wn
M8 _B B GND GND N_18_G2 l=0.18u w=wn
M9 _C C GND GND N_18_G2 l=0.18u w=wn
M10 N001 _A VDD VDD P_18_G2 l=0.18u w=wp
M11 N001 B VDD VDD P_18_G2 l=0.18u w=wp
M12 N001 C VDD VDD P_18_G2 l=0.18u w=wp
M13 N002 A N001 VDD P_18_G2 l=0.18u w=wp
M14 N002 _B N001 VDD P_18_G2 l=0.18u w=wp
M15 N002 _C N001 VDD P_18_G2 l=0.18u w=wp
M16 _A A VDD VDD P_18_G2 l=0.18u w=wp
M17 _B B VDD VDD P_18_G2 l=0.18u w=wp
M18 _C C VDD VDD P_18_G2 l=0.18u w=wp

M19 D N002 GND GND N_18_G2 l=0.18u w=w1
M20 D N002 VDD VDD P_18_G2 l=0.18u w=w2

M21 N004 B C GND N_18_G2 l=0.18u w=wn
M22 N004 C B GND N_18_G2 l=0.18u w=wn

M23 S N004 GND GND N_18_G2 l=0.18u w=w1
M24 S N004 VDD VDD P_18_G2 l=0.18u w=w2

M25 N004 B N003 VDD P_18_G2 l=0.18u w=wp
M26 N003 C VDD VDD P_18_G2 l=0.18u w=wp
.ends

.subckt SELECT B0 B1 S D N PP 
M1 N002 D P001 GND N_18_G2 l=0.18u w=wn
M2 P001 B0 GND GND N_18_G2 l=0.18u w=wn
M3 N002 S P002 GND N_18_G2 l=0.18u w=wn
M4 P002 B1 GND GND N_18_G2 l=0.18u w=wn
M6 N002 D N001 VDD P_18_G2 l=0.18u w=wp
M7 N001 S VDD VDD P_18_G2 l=0.18u w=wp
M8 N002 B0 N001 VDD P_18_G2 l=0.18u w=wp
M9 N001 B1 VDD VDD P_18_G2 l=0.18u w=wp

M5 B N002 GND GND N_18_G2 l=0.18u w=0.44u
M10 B N002 VDD VDD P_18_G2 l=0.18u w=0.44u
********XOR********
M11 N004 B N GND N_18_G2 l=0.18u w=wn
M12 N004 N B GND N_18_G2 l=0.18u w=wn
M15 N004 B N003 VDD P_18_G2 l=0.18u w=wp
M16 N003 N VDD VDD P_18_G2 l=0.18u w=wp

M13 PP N004 GND GND N_18_G2 l=0.18u w=0.44u
M14 PP N004 VDD VDD P_18_G2 l=0.18u w=0.44u
.ends

.param dwp = 0.55u
.param dwn = 0.44u
.param lp = 0.18u
.param ln = 0.18u

.subckt DFF D CLK Q
M1 P001 D VDD VDD P_18_G2 w=dwp l=lp
M2 N0 CLK P001 VDD P_18_G2 w=dwp l=lp
M3 N0 D GND GND N_18_G2 w=dwn l=ln
M4 N1 CLK VDD VDD P_18_G2 w=dwp l=lp
M5 N1 N0 P002 GND N_18_G2 w=dwn l=ln
M6 P002 CLK GND GND N_18_G2 w=dwn l=ln
M7 N3 N1 VDD VDD P_18_G2 w=dwp l=lp
M8 N3 CLK P003 GND N_18_G2 w=dwn l=ln
M9 P003 N1 GND GND N_18_G2 w=dwn l=ln

M10 Q N3 VDD VDD P_18_G2 w=dwp l=lp
M11 Q N3 GND GND N_18_G2 w=dwn l=ln
.ends


*****************************CSA********************************************


.subckt ACCXOR MODE ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0] 
+cACC[11] cACC[10] cACC[9] cACC[8] cACC[7] cACC[6] cACC[5] cACC[4] cACC[3] cACC[2] cACC[1] cACC[0] CLK
+ dMODE

Xdffa0  ACC[0] CLK dACC[0]   DFF1
Xdffa1  ACC[1] CLK dACC[1]   DFF1
Xdffa2  ACC[2] CLK dACC[2]   DFF1
Xdffa3  ACC[3] CLK dACC[3]   DFF1
Xdffa4  ACC[4] CLK dACC[4]   DFF1
Xdffa5  ACC[5] CLK dACC[5]   DFF1
Xdffa6  ACC[6] CLK dACC[6]   DFF1
Xdffa7  ACC[7] CLK dACC[7]   DFF1
Xdffa8  ACC[8] CLK dACC[8]   DFF1
Xdffa9  ACC[9] CLK dACC[9]   DFF1
Xdffa10 ACC[10] CLK dACC[10] DFF1
Xdffa11 ACC[11] CLK dACC[11] DFF1
Xdffa12 MODE CLK dMODE DFF1

X_xor0 dMODE dACC[0] cACC[0]    XOR
X_xor1 dMODE dACC[1] cACC[1]    XOR
X_xor2 dMODE dACC[2] cACC[2]    XOR
X_xor3 dMODE dACC[3] cACC[3]    XOR
X_xor4 dMODE dACC[4] cACC[4]    XOR
X_xor5 dMODE dACC[5] cACC[5]    XOR
X_xor6 dMODE dACC[6] cACC[6]    XOR
X_xor7 dMODE dACC[7] cACC[7]    XOR
X_xor8 dMODE dACC[8] cACC[8]    XOR
X_xor9 dMODE dACC[9] cACC[9]    XOR
X_xor10 dMODE dACC[10] cACC[10] XOR
X_xor11 dMODE dACC[11] cACC[11] XOR
.ends


.subckt CSA dMODE PP0[6] PP0[5] PP0[4] PP0[3] PP0[2] PP0[1] PP0[0]
+ PP1[6] PP1[5] PP1[4] PP1[3] PP1[2] PP1[1] PP1[0]
+ PP2[6] PP2[5] PP2[4] PP2[3] PP2[2] PP2[1] PP2[0]
+ PP0_neg PP1_neg PP2_neg 
+ ACC[11] ACC[10] ACC[9] ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0] 
+ C[12] C[11] C[10] C[9] C[8] C[7] C[6] C[5] C[4] C[3] C[2] C[1] 
+ S[12] S[11] S[10] S[9] S[8] S[7] S[6] S[5] S[4] S[3] S[2] S[1] S[0]
+ CLK CIN

X_inv0 PP0[6] PP0_invS INV
X_inv1 PP1[6] PP1_invS INV
X_inv2 PP2[6] PP2_invS INV

***********************************LV1******************************************

X_LV1_HA0 PP0[2] PP1[0]             LV1_C[3]    LV1_S[2]  HA
X_LV1_HA1 PP0[3] PP1[1]             LV1_C[4]    LV1_S[3]  HA
X_LV1_FA0 PP0[4] PP1[2] PP2[0]      LV1_C[5]    LV1_S[4]  FA 
X_LV1_FA1 PP0[5] PP1[3] PP2[1]      LV1_C[6]    LV1_S[5]  FA 
X_LV1_FA2 PP0[6] PP1[4] PP2[2]      LV1_C[7]    LV1_S[6]  FA 
X_LV1_FA3 PP0[6] PP1[5] PP2[3]      LV1_C[8]    LV1_S[7]  FA 
X_LV1_FA4 PP0[6] PP1[6] PP2[4]      LV1_C[9]    LV1_S[8]  FA 
X_LV1_FA5 PP0_invS PP1_invS PP2[5]  LV1_C[10]   LV1_S[9]  FA 
X_LV1_HA2 VDD PP2[6]                LV1_C[11]   LV1_S[10] HA 


***********************************LV2******************************************
X_LV2_HA0 PP0[0] PP0_neg                LV2_C[1]  LV2_S[0]   HA
X_LV2_HA1 LV1_S[2] PP1_neg              LV2_C[3]  LV2_S[2]   HA
X_LV2_HA2 LV1_C[3] LV1_S[3]             LV2_C[4]  LV2_S[3]   HA
X_LV2_FA0 LV1_C[4] LV1_S[4] PP2_neg     LV2_C[5]  LV2_S[4]   FA
X_LV2_HA3 LV1_C[5] LV1_S[5]             LV2_C[6]  LV2_S[5]   HA
X_LV2_HA4 LV1_C[6] LV1_S[6]             LV2_C[7]  LV2_S[6]   HA
X_LV2_HA5 LV1_C[7] LV1_S[7]             LV2_C[8]  LV2_S[7]   HA
X_LV2_HA6 LV1_C[8] LV1_S[8]             LV2_C[9]  LV2_S[8]   HA
X_LV2_HA7 LV1_C[9] LV1_S[9]             LV2_C[10] LV2_S[9]   HA
X_LV2_HA8 LV1_C[10] LV1_S[10]           LV2_C[11] LV2_S[10]  HA
X_LV2_HA9 LV1_C[11] PP2_invS            LV2_C[12] LV2_S[11]  HA


***********************************LV3******************************************
X_LV3_HA0 LV2_S[0] ACC[0]             LV3_C[1] LV3_S[0]   HA
X_LV3_FA0 LV2_C[1] PP0[1] ACC[1]      LV3_C[2] LV3_S[1]   FA
X_LV3_HA1 LV2_S[2] ACC[2]             LV3_C[3] LV3_S[2]   HA
X_LV3_FA1 LV2_C[3] LV2_S[3] ACC[3]    LV3_C[4] LV3_S[3]   FA
X_LV3_FA2 LV2_C[4] LV2_S[4] ACC[4]    LV3_C[5] LV3_S[4]   FA
X_LV3_FA3 LV2_C[5] LV2_S[5] ACC[5]    LV3_C[6] LV3_S[5]   FA
X_LV3_FA4 LV2_C[6] LV2_S[6] ACC[6]    LV3_C[7] LV3_S[6]   FA
X_LV3_FA5 LV2_C[7] LV2_S[7] ACC[7]    LV3_C[8] LV3_S[7]   FA
X_LV3_FA6 LV2_C[8] LV2_S[8] ACC[8]    LV3_C[9] LV3_S[8]   FA
X_LV3_FA7 LV2_C[9] LV2_S[9] ACC[9]    LV3_C[10] LV3_S[9]  FA
X_LV3_FA8 LV2_C[10] LV2_S[10] ACC[10] LV3_C[11] LV3_S[10] FA
X_LV3_FA9 LV2_C[11] LV2_S[11] ACC[11] LV3_C[12] LV3_S[11] FA
X_LV3_FA10 LV2_C[12] VDD ACC[11] LV3_C[13] LV3_S[12] FA

********************************************************************************
Xdffa0   LV3_C[1]  CLK C[1]   DFF1
Xdffa1   LV3_C[2]  CLK C[2]   DFF1
Xdffa2   LV3_C[3]  CLK C[3]   DFF1
Xdffa3   LV3_C[4]  CLK C[4]   DFF1
Xdffa4   LV3_C[5]  CLK C[5]   DFF1
Xdffa5   LV3_C[6]  CLK C[6]   DFF1
Xdffa6   LV3_C[7]  CLK C[7]   DFF1
Xdffa7   LV3_C[8]  CLK C[8]   DFF1
Xdffa8   LV3_C[9]  CLK C[9]   DFF1
Xdffa9   LV3_C[10] CLK C[10]  DFF1
Xdffa10  LV3_C[11] CLK C[11]  DFF1
Xdffa11  LV3_C[12] CLK C[12]  DFF1

Xdffa12  LV3_S[0]   CLK S[0]   DFF1
Xdffa13  LV3_S[1]   CLK S[1]   DFF1
Xdffa14  LV3_S[2]   CLK S[2]   DFF1
Xdffa15  LV3_S[3]   CLK S[3]   DFF1
Xdffa16  LV3_S[4]   CLK S[4]   DFF1
Xdffa17  LV3_S[5]   CLK S[5]   DFF1
Xdffa18  LV3_S[6]   CLK S[6]   DFF1
Xdffa19  LV3_S[7]   CLK S[7]   DFF1
Xdffa20  LV3_S[8]   CLK S[8]   DFF1
Xdffa21  LV3_S[9]   CLK S[9]   DFF1
Xdffa22  LV3_S[10]  CLK S[10]  DFF1
Xdffa23  LV3_S[11]  CLK S[11]  DFF1
Xdffa24  LV3_S[12]  CLK S[12]  DFF1
Xdffmod  dMODE        CLK CIN    DFF1

.ends

.param csa_wp=0.55u
.param csa_wn=0.44u

.subckt FA A B C COUT SUM 
M1 P001 A VDD VDD P_18_G2 l=0.18u w=csa_wp
M2 _COUT B P001 VDD P_18_G2 l=0.18u w=csa_wp
M3 N001 A VDD VDD P_18_G2 l=0.18u w=csa_wp
M4 N001 B VDD VDD P_18_G2 l=0.18u w=csa_wp
M5 _COUT C N001 VDD P_18_G2 l=0.18u w=csa_wp
M6 N002 C VDD VDD P_18_G2 l=0.18u w=csa_wp
M7 N002 A VDD VDD P_18_G2 l=0.18u w=csa_wp
M8 N002 B VDD VDD P_18_G2 l=0.18u w=csa_wp
M9 _SUM _COUT N002 VDD P_18_G2 l=0.18u w=csa_wp
M10 P002 A VDD VDD P_18_G2 l=0.18u w=csa_wp
M11 P003 B P002 VDD P_18_G2 l=0.18u w=csa_wp
M12 _SUM C P003 VDD P_18_G2 l=0.18u w=csa_wp
M13 _COUT B P004 GND N_18_G2 l=0.18u w=csa_wn
M14 P004 A GND GND N_18_G2 l=0.18u w=csa_wn
M15 _COUT C N003 GND N_18_G2 l=0.18u w=csa_wn
M16 N003 A GND GND N_18_G2 l=0.18u w=csa_wn
M17 N003 B GND GND N_18_G2 l=0.18u w=csa_wn
M18 N004 C GND GND N_18_G2 l=0.18u w=csa_wn
M19 N004 A GND GND N_18_G2 l=0.18u w=csa_wn
M20 N004 B GND GND N_18_G2 l=0.18u w=csa_wn
M21 _SUM _COUT N004 GND N_18_G2 l=0.18u w=csa_wn
M22 _SUM C P005 GND N_18_G2 l=0.18u w=csa_wn
M23 P005 B P006 GND N_18_G2 l=0.18u w=csa_wn
M24 P006 A GND GND N_18_G2 l=0.18u w=csa_wn
M25 SUM _SUM GND GND N_18_G2 l=0.18u w=csa_wn
M26 COUT _COUT GND GND N_18_G2 l=0.18u w=csa_wn

M27 SUM _SUM VDD VDD P_18_G2 l=0.18u w=csa_wp
M28 COUT _COUT VDD VDD P_18_G2 l=0.18u w=csa_wp
.ends


.subckt HA A B COUT SUM 
M9 N001 A VDD VDD P_18_G2 l=0.18u w=0.44u
M10 N001 B VDD VDD P_18_G2 l=0.18u w=0.44u
M11 N001 A P001 GND N_18_G2 l=0.18u w=0.44u
M12 P001 B GND GND N_18_G2 l=0.18u w=0.44u
M13 COUT N001 VDD VDD P_18_G2 l=0.18u w=0.44u
M14 COUT N001 GND GND N_18_G2 l=0.18u w=0.44u

X_xor A B SUM XOR
.ends

.subckt INV IN OUT
mp OUT IN VDD VDD P_18_G2 l=0.18u w=csa_wp
mn OUT IN GND GND N_18_G2 l=0.18u w=csa_wn
.ends

.subckt XOR A B OUT
M1 N002 B A GND N_18_G2 l=0.18u w=0.44u
M2 N002 A B GND N_18_G2 l=0.18u w=0.44u
M3 OUT N002 GND GND N_18_G2 l=0.18u w=0.44u
M4 OUT N002 VDD VDD P_18_G2 l=0.18u w=0.44u
M5 N002 B N001 VDD P_18_G2 l=0.18u w=0.44u
M6 N001 A VDD VDD P_18_G2 l=0.18u w=0.44u
.ends

**********************************ADDER***********************************************
**********************************ADDER***********************************************

.subckt ADDER CIN A[12] A[11] A[10] A[9]  A[8] A[7] A[6] A[5] A[4] A[3] A[2] A[1] A[0]
+ B[12] B[11] B[10] B[9]  B[8] B[7] B[6] B[5] B[4] B[3] B[2] B[1] B[0]
+ OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0]


/////stage 0
Xa01 A[0] B[0] P0 G0 RB
* Xa000 P0 CIN c1 and
* Xa001 c1 G0 G00 or 

Xa000 P0 CIN G0 G00 andor

Xa02 A[1] B[1] P1 G1 RB
Xa03 A[2] B[2] P2 G2 RB
Xa04 A[3] B[3] P3 G3 RB
Xa05 A[4] B[4] P4 G4 RB
Xa06 A[5] B[5] P5 G5 RB
Xa07 A[6] B[6] P6 G6 RB
Xa08 A[7] B[7] P7 G7 RB
Xa09 A[8] B[8] P8 G8 RB
Xa010 A[9] B[9] P9 G9 RB
Xa011 A[10] B[10] P10 G10 RB
Xa012 A[11] B[11] P11 G11 RB
* Xa013 A[12] B[12] P12 G12 RB
Xa013 A[12] B[12] P12 xorg
///////stage 1
* Xa00 GND CIN P0 G0 PP0 GG1 YB 
Xa11 P0 G00 P1 G1 PP1 GG1 YB
Xa13 P2 G2 P3 G3 PP3 GG3 YB
Xa15 P4 G4 P5 G5 PP5 GG5 YB
Xa17 P6 G6 P7 G7 PP7 GG7 YB
Xa19 P8 G8 P9 G9 PP9 GG9 YB
Xa111 P10 G10 P11 G11 PP11 GG11 YB

//////stage 2
Xa23 GG1 PP3 GG3 GGG3 andor
Xa27 PP5 GG5 PP7 GG7 PPP7 GGG7 YB
Xa211 PP9 GG9 PP11 GG11 PPP11 GGG11 YB
/////stage 3
Xa37 GGG3 PPP7 GGG7 Gout7 andor
/////stage 4
Xa411 Gout7 PPP11 GGG11 fG11 andor
///stage 5
Xa55 GGG3 PP5 GG5 Gx5[0] andor
Xa59 Gout7 PP9 GG9 Gx5[1] andor
/////stage 6
* Xa62 PP1 GG1 P2 G2 Px6[0] Gx6[0] YB
* Xa64 PPP3 GGG3 P4 G4 Px6[1] Gx6[1] YB
* Xa66 Px5[0] Gx5[0] P6 G6 Px6[2] Gx6[2] YB
* Xa68 Pout7 Gout7 P8 G8 Px6[3] Gx6[3] YB
* Xa610 Px5[1] Gx5[1] P10 G10 Px6[4] Gx6[4] YB
/////stage 6
Xa62 GG1 P2 G2 Gx6[0] andor
Xa64 GGG3 P4 G4 Gx6[1] andor
Xa66 Gx5[0] P6 G6 Gx6[2] andor
Xa68 Gout7 P8 G8 Gx6[3] andor
Xa610 Gx5[1] P10 G10 Gx6[4] andor

* Xa612 fP11 fG11 P12 G12 Px6[5] Gx6[5] YB

/////stage 7
Xa70 P0 CIN OUT[0] xorg 
* Xa700 OUT1[0] OUT[0] buf

Xa71 G00 P1 OUT[1] xorg
Xa72 GG1 P2 OUT[2] xorg
Xa73 Gx6[0] P3 OUT[3] xorg
Xa74 GGG3 P4 OUT[4] xorg
Xa75 Gx6[1] P5 OUT[5] xorg
Xa76 Gx5[0] P6 OUT[6] xorg
Xa77 Gx6[2] P7 OUT[7] xorg 
Xa78 Gout7 P8 OUT[8] xorg
Xa79 Gx6[3] P9 OUT[9] xorg
Xa710 Gx5[1] P10 OUT[10] xorg
Xa711 Gx6[4] P11 OUT[11] xorg
Xa712 fG11 P12 OUT[12] xorg

.ends

.subckt RB A B P G
Xrb1 A B G and
* Xrb2 A B P xorg
Xrb2 B A P xorg
.ends

.subckt YB A B C D P G
Xyb1 A C P and
Xyb2 B C t1 and
Xyb3 T1 D G or
.ends

.subckt andor A B C OUT
Xao1 A B OUT1 and
Xao2 OUT1 C OUT or
.ends

/////xor/////
.param wpg = 0.44u
.param wng = 0.44u
.subckt xorg A B OUT
M1 N002 B A GND N_18_G2 l=0.18u w=wng
M2 N002 A B GND N_18_G2 l=0.18u w=wng
M3 OUT N002 GND GND N_18_G2 l=0.18u w=0.44u
M4 OUT N002 VDD VDD P_18_G2 l=0.18u w=0.44u
M5 N002 B N001 VDD P_18_G2 l=0.18u w=wpg
M6 N001 A VDD VDD P_18_G2 l=0.18u w=wpg
.ends

/////andor//////
.param wni=0.44u 
.param wpi=0.44u
.subckt inv1 A A_bar
M15 VDD A A_bar VDD P_18_G2 l=0.18u w=wpi
M16 A_bar A GND GND N_18_G2 l=0.18u w=wni
.ends

.param wna=0.44u 
.param wpa=0.44u
.subckt and A B OUT
M9 N003 A N004 GND N_18_G2 l=0.18u w=wna
M10 N004 B GND GND N_18_G2 l=0.18u w=wna
M12 N003 B VDD VDD P_18_G2 l=0.18u w=wpa
M11 N003 A VDD VDD P_18_G2 l=0.18u w=wpa
Xand1 N003 OUT inv1
.ends

.subckt or A B OUT
M35 N007 B VDD VDD P_18_G2 l=0.18u w=wpa
M36 N008 A N007 VDD P_18_G2 l=0.18u w=wpa
M37 N008 A GND GND N_18_G2 l=0.18u w=wna
M38 N008 B GND GND N_18_G2 l=0.18u w=wna
Xor1 N008 OUT inv1
.ends

//////////DFF1//////////
.param dwp1 = 0.44u
.param dwn1 = 0.44u
.param lp = 0.18u
.param ln = 0.18u

.subckt DFF1 D CLK Q
M1 P001 D VDD VDD P_18_G2 w=dwp1 l=lp
M2 N0 CLK P001 VDD P_18_G2 w=dwp1 l=lp
M3 N0 D GND GND N_18_G2 w=dwn1 l=ln
M4 N1 CLK VDD VDD P_18_G2 w=dwp1 l=lp
M5 N1 N0 P002 GND N_18_G2 w=dwn1 l=ln
M6 P002 CLK GND GND N_18_G2 w=dwn1 l=ln
M7 N3 N1 VDD VDD P_18_G2 w=dwp1 l=lp
M8 N3 CLK P003 GND N_18_G2 w=dwn1 l=ln
M9 P003 N1 GND GND N_18_G2 w=dwn1 l=ln
M10 Q N3 VDD VDD P_18_G2 w=dwp1 l=lp
M11 Q N3 GND GND N_18_G2 w=dwn1 l=ln
.ends

.subckt DF2 CLK OUT1[12] OUT1[11] OUT1[10] OUT1[9] OUT1[8] OUT1[7] OUT1[6] OUT1[5] OUT1[4] OUT1[3] OUT1[2] OUT1[1] OUT1[0]
+OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0]

xd21 OUT1[0] CLK OUT[0] DFF1 
xd22 OUT1[1] CLK OUT[1] DFF1 
xd23 OUT1[2] CLK OUT[2] DFF1
xd24 OUT1[3] CLK OUT[3] DFF1
xd25 OUT1[4] CLK OUT[4] DFF1
xd26 OUT1[5] CLK OUT[5] DFF1
xd27 OUT1[6] CLK OUT[6] DFF1
xd28 OUT1[7] CLK OUT[7] DFF1
xd29 OUT1[8] CLK OUT[8] DFF1
xd210 OUT1[9] CLK OUT[9] DFF1
xd211 OUT1[10] CLK OUT[10] DFF1
xd212 OUT1[11] CLK OUT[11] DFF1
xd213 OUT1[12] CLK OUT[12] DFF1

.ends


.end


