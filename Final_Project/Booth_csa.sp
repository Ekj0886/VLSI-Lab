****  Final Project: Two stage pipeline Two mode 6-bit MAC  ***

*************************************************************
*************************************************************
***************Don't touch settings below********************
*************************************************************
*************************************************************
.lib "umc018.l" L18U18V_TT 
.vec 'MAC6.vec'

.temp 25
.op
.options brief post

***************** parameter ****************************
.global  VDD  GND
.param supply = 1.8v
.param load = 10f
.param tr = 0.2n

***************** voltage source ****************************
Vclk CLK GND pulse(0 supply 0.83n 0.1ns 0.1ns "1*period/2-tr" "period*1")
Vd1 VDD GND supply

***************** top-circuit ****************************
* XMAC6  CLK A[5] A[4] A[3] A[2] A[1] A[0]
* + B[5] B[4] B[3] B[2] B[1] B[0] 
* + MODE
* + ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0]
* + OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0] MAC6
     
* CLOAD01 OUT[0] GND load
* CLOAD02 OUT[1] GND load 
* CLOAD03 OUT[2] GND load 
* CLOAD04 OUT[3] GND load 
* CLOAD05 OUT[4] GND load 
* CLOAD06 OUT[5] GND load 
* CLOAD07 OUT[6] GND load 
* CLOAD08 OUT[7] GND load 
* CLOAD09 OUT[8] GND load 
* CLOAD10 OUT[9] GND load 
* CLOAD11 OUT[10] GND load 
* CLOAD12 OUT[11] GND load 
* CLOAD13 OUT[12] GND load 

***************** Average Power ****************************
.meas tran Iavg avg I(Vd1) from=0ns to='100*period'
.meas Pavg param='abs(Iavg)*supply'

* .meas tran tp trig v(A[0]) val = 'supply/2' rise=1
* +targ v(OUT) val = 'supply/2' rise=1

* .meas tran trs trig v(OUT) val = 'supply*0.1' rise=1
* +targ v(OUT) val = 'supply*0.9' rise=1
* .meas tran tfs trig v(OUT) val = 'supply*0.9' fall=1
* +targ v(OUT) val = 'supply*0.1' fall=1


.meas tran tps trig v(a[2]) val = 'supply/2' rise=1
+targ v(S1) val = 'supply/2' rise=1
.meas tran tpd trig v(a[2]) val = 'supply/2' fall=1
+targ v(D1) val = 'supply/2' rise=1

.meas tran trs trig v(S1) val = 'supply*0.1' rise=1
+targ v(S1) val = 'supply*0.9' rise=1
.meas tran tfs trig v(S1) val = 'supply*0.9' fall=1
+targ v(S1) val = 'supply*0.1' fall=1

.meas tran trd trig v(D1) val = 'supply*0.1' rise=1
+targ v(D1) val = 'supply*0.9' rise=1
.meas tran tfd trig v(D1) val = 'supply*0.9' fall=1
+targ v(D1) val = 'supply*0.1' fall=1

.tran 0.1n '100*period'

*************************************************************
*************************************************************
***************Don't touch settings above********************
*************************************************************
*************************************************************

***** you can modify clock cycle here, remember synchronize with clock cycle in MAC6.vec ****
.param period = 1.66n
.param wp = 0.44u
.param wn = 0.44u

.param w1 = 0.44u
.param w2 = 0.88u

.param wnd = 0.44u
.param wpd = 0.8u

XBOOTH A[0] A[1] A[2] A[3] A[4] A[5]
+ B[0] B[1] B[2] B[3] B[4] B[5]
+ PP0[0] PP0[1] PP0[2] PP0[3] PP0[4] PP0[5] PP0[6]
+ PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5] PP1[6]
+ PP2[0] PP2[1] PP2[2] PP2[3] PP2[4] PP2[5] PP2[6] 
+ CLK Booth

XACCXOR MODE ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0] 
+cACC[11] cACC[10] cACC[9] cACC[8] cACC[7] cACC[6] cACC[5] cACC[4] cACC[3] cACC[2] cACC[1] cACC[0] CLK ACCXOR

XCSA PP0[6] PP0[5] PP0[4] PP0[3] PP0[2] PP0[1] PP0[0] 
+PP1[6] PP1[5] PP1[4] PP1[3] PP1[2] PP1[1] PP1[0] 
+PP2[6] PP2[5] PP2[4] PP2[3] PP2[2] PP2[1] PP2[0] 
+PP0[6] PP1[6] PP2[6] 
+cACC[11] cACC[10] cACC[9] cACC[8] cACC[7] cACC[6] cACC[5] cACC[4] cACC[3] cACC[2] cACC[1] cACC[0] 
+C[12] C[11] C[10] C[9] C[8] C[7] C[6] C[5] C[4] C[3] C[2] C[1] 
+S[11] S[10] S[9] S[8] S[7] S[6] S[5] S[4] S[3] S[2] S[1] S[0]
+CLK CSA



.subckt Booth A[0] A[1] A[2] A[3] A[4] A[5]
+ B[0] B[1] B[2] B[3] B[4] B[5]
+ PP0[0] PP0[1] PP0[2] PP0[3] PP0[4] PP0[5] PP0[6]
+ PP1[0] PP1[1] PP1[2] PP1[3] PP1[4] PP1[5] PP1[6]
+ PP2[0] PP2[1] PP2[2] PP2[3] PP2[4] PP2[5] PP2[6]
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

***** Define your sub-circuit and self-defined parameter here , and only need to submmit this part ****

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

M5 B N002 GND GND N_18_G2 l=0.18u w=w1
M10 B N002 VDD VDD P_18_G2 l=0.18u w=w2

M11 N004 B N GND N_18_G2 l=0.18u w=wn
M12 N004 N B GND N_18_G2 l=0.18u w=wn
M15 N004 B N003 VDD P_18_G2 l=0.18u w=wp
M16 N003 N VDD VDD P_18_G2 l=0.18u w=wp

M13 PP N004 GND GND N_18_G2 l=0.18u w=w1
M14 PP N004 VDD VDD P_18_G2 l=0.18u w=w2
.ends

.param dwp = 0.88u
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
M10 Q N3 VDD VDD P_18_G2 w=0.88u l=lp
M11 Q N3 GND GND N_18_G2 w=dwn l=ln
.ends



* /////////////////////////////////////////////

.param csa_wp=0.96u
.param csa_wn=0.48u



.subckt ACCXOR MODE ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0] 
+cACC[11] cACC[10] cACC[9] cACC[8] cACC[7] cACC[6] cACC[5] cACC[4] cACC[3] cACC[2] cACC[1] cACC[0] CLK

Xdffa0  ACC[0] CLK dACC[0]   DFF
Xdffa1  ACC[1] CLK dACC[1]   DFF
Xdffa2  ACC[2] CLK dACC[2]   DFF
Xdffa3  ACC[3] CLK dACC[3]   DFF
Xdffa4  ACC[4] CLK dACC[4]   DFF
Xdffa5  ACC[5] CLK dACC[5]   DFF
Xdffa6  ACC[6] CLK dACC[6]   DFF
Xdffa7  ACC[7] CLK dACC[7]   DFF
Xdffa8  ACC[8] CLK dACC[8]   DFF
Xdffa9  ACC[9] CLK dACC[9]   DFF
Xdffa10 ACC[10] CLK dACC[10] DFF
Xdffa11 ACC[11] CLK dACC[11] DFF
Xdffa12 MODE CLK dMODE DFF

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


.subckt CSA PP0[6] PP0[5] PP0[4] PP0[3] PP0[2] PP0[1] PP0[0]
+ PP1[6] PP1[5] PP1[4] PP1[3] PP1[2] PP1[1] PP1[0]
+ PP2[6] PP2[5] PP2[4] PP2[3] PP2[2] PP2[1] PP2[0]
+ PP0_neg PP1_neg PP2_neg 
+ ACC[11] ACC[10] ACC[9] ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0] 
+ C[12] C[11] C[10] C[9] C[8] C[7] C[6] C[5] C[4] C[3] C[2] C[1] 
+ S[11] S[10] S[9] S[8] S[7] S[6] S[5] S[4] S[3] S[2] S[1] S[0]
+ CLK

X_inv0 PP0[6] PP0_invS INV
X_inv1 PP1[6] PP1_invS INV

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
X_LV2_HA0 PP0[0] PP0_neg                LV2_C[1] LV2_S[0] HA
X_LV2_HA1 LV1_S[2] PP1_neg              LV2_C[3] LV2_S[2] HA
X_LV2_HA2 LV1_C[3] LV1_S[3]             LV2_C[4] LV2_S[3] HA
X_LV2_FA0 LV1_C[4] LV1_S[4] PP2_neg     LV2_C[5] LV2_S[4] FA
X_LV2_HA3 LV1_C[5] LV1_S[5] LV2_C[6]    LV2_S[5]          HA
X_LV2_HA4 LV1_C[6] LV1_S[6] LV2_C[7]    LV2_S[6]          HA
X_LV2_HA5 LV1_C[7] LV1_S[7] LV2_C[8]    LV2_S[7]          HA
X_LV2_HA6 LV1_C[8] LV1_S[8] LV2_C[9]    LV2_S[8]          HA
X_LV2_HA7 LV1_C[9] LV1_S[9] LV2_C[10]   LV2_S[9]          HA
X_LV2_HA8 LV1_C[10] LV1_S[10] LV2_C[11] LV2_S[10]         HA


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
X_LV3_FA9 LV2_C[11] LV1_C[11] ACC[11] LV3_C[12] LV3_S[11] FA

********************************************************************************
Xdffa0   LV3_C[1]  CLK C[1]   DFF
Xdffa1   LV3_C[2]  CLK C[2]   DFF
Xdffa2   LV3_C[3]  CLK C[3]   DFF
Xdffa3   LV3_C[4]  CLK C[4]   DFF
Xdffa4   LV3_C[5]  CLK C[5]   DFF
Xdffa5   LV3_C[6]  CLK C[6]   DFF
Xdffa6   LV3_C[7]  CLK C[7]   DFF
Xdffa7   LV3_C[8]  CLK C[8]   DFF
Xdffa8   LV3_C[9]  CLK C[9]   DFF
Xdffa9   LV3_C[10] CLK C[10]  DFF
Xdffa10  LV3_C[11] CLK C[11]  DFF
Xdffa11  LV3_C[12] CLK C[12]  DFF

Xdffa12  LV3_S[0]   CLK S[0]   DFF
Xdffa13  LV3_S[1]   CLK S[1]   DFF
Xdffa14  LV3_S[2]   CLK S[2]   DFF
Xdffa15  LV3_S[3]   CLK S[3]   DFF
Xdffa16  LV3_S[4]   CLK S[4]   DFF
Xdffa17  LV3_S[5]   CLK S[5]   DFF
Xdffa18  LV3_S[6]   CLK S[6]   DFF
Xdffa19  LV3_S[7]   CLK S[7]   DFF
Xdffa20  LV3_S[8]   CLK S[8]   DFF
Xdffa21  LV3_S[9]   CLK S[9]   DFF
Xdffa22  LV3_S[10]  CLK S[10]  DFF
Xdffa23  LV3_S[11]  CLK S[11]  DFF

.ends



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
M1 P001 B VDD VDD P_18_G2 l=0.18u w=csa_wp
M2 P002 A VDD VDD P_18_G2 l=0.18u w=csa_wp
M3 SUM _A P001 VDD P_18_G2 l=0.18u w=csa_wp
M4 SUM _B P002 VDD P_18_G2 l=0.18u w=csa_wp
M5 SUM _A P003 GND N_18_G2 l=0.18u w=csa_wn
M6 SUM A P004 GND N_18_G2 l=0.18u w=csa_wn
M7 P003 _B GND GND N_18_G2 l=0.18u w=csa_wn
M8 P004 B GND GND N_18_G2 l=0.18u w=csa_wn
M9 N001 A VDD VDD P_18_G2 l=0.18u w=csa_wp
M10 N001 B VDD VDD P_18_G2 l=0.18u w=csa_wp
M11 N001 A P005 GND N_18_G2 l=0.18u w=csa_wn
M12 P005 B GND GND N_18_G2 l=0.18u w=csa_wn
M13 COUT N001 VDD VDD P_18_G2 l=0.18u w=csa_wp
M14 COUT N001 GND GND N_18_G2 l=0.18u w=csa_wn
M15 _A A GND GND N_18_G2 l=0.18u w=csa_wn
M16 _A A VDD VDD P_18_G2 l=0.18u w=csa_wp
M17 _B B GND GND N_18_G2 l=0.18u w=csa_wn
M18 _B B VDD VDD P_18_G2 l=0.18u w=csa_wp
.ends


.subckt INV IN OUT
mp OUT IN VDD VDD P_18_G2 l=0.18u w=csa_wp
mn OUT IN GND GND N_18_G2 l=0.18u w=csa_wn
.ends

.subckt XOR A B OUT
M1 N002 B A GND N_18_G2 l=0.18u w=0.44u
M2 N002 A B GND N_18_G2 l=0.18u w=0.44u
M3 OUT N002 GND GND N_18_G2 l=0.18u w=0.44u
M4 OUT N002 VDD VDD P_18_G2 l=0.18u w=0.88u
M5 N002 B N001 VDD P_18_G2 l=0.18u w=0.44u
M6 N001 A VDD VDD P_18_G2 l=0.18u w=0.44u
.ends

* .subckt XOR A B OUT 
* X_inv0 A _A INV
* X_inv1 B _B INV
* M1 P001 B VDD VDD P_18_G2 l=0.18u w=csa_wp
* M2 P002 A VDD VDD P_18_G2 l=0.18u w=csa_wp
* M3 OUT _A P001 VDD P_18_G2 l=0.18u w=csa_wp
* M4 OUT _B P002 VDD P_18_G2 l=0.18u w=csa_wp
* M5 OUT _A P003 GND N_18_G2 l=0.18u w=csa_wn
* M6 OUT A P004 GND N_18_G2 l=0.18u w=csa_wn
* M7 P003 _B GND GND N_18_G2 l=0.18u w=csa_wn
* M8 P004 B GND GND N_18_G2 l=0.18u w=csa_wn
* .ends
.end


