****  Lab03: 4-bit FA  ***

*************************************************************
*************************************************************
***************Don't touch settings below********************
*************************************************************
*************************************************************
.lib "umc018.l" L18U18V_TT 
.vec 'FA4.vec'

.temp 25
.op
.options brief post

***************** parameter ****************************
.global  VDD  GND
.param supply = 1.8v
.param load = 10f
.param tr = 0.2n

***************** voltage source ****************************
Vclk CLK GND pulse(0 supply 0 0.1ns 0.1ns "1*period/2-tr" "period*1")
Vd1 VDD GND supply


***************** top-circuit ****************************
XFA CLK A[3] A[2] A[1] A[0] 
+ B[3] B[2] B[1] B[0] CIN 
+ SUM[3] SUM[2] SUM[1] SUM[0] COUT FA4

C0 SUM[0] GND load
C1 SUM[1] GND load
C2 SUM[2] GND load
C3 SUM[3] GND load
C4 COUT   GND load

***************** Average Power ****************************
.meas tran Iavg avg I(Vd1) from=0ns to='50*period'
.meas Pavg param='abs(Iavg)*supply'

.tran 0.1n '50*period' 


*************************************************************
*************************************************************
***************Don't touch settings above********************
*************************************************************
*************************************************************

*.tran 0.02n '50*period' sweep mx 1 2 0.25

***** you can modify clock cycle here, remember synchronize with clock cycle in FA4.vec ****
.param period = 0.88n

***** Define your sub-circuit and self-defined parameter here , and only need to submmit this part ****

***---------------------***
***        Width        ***
***---------------------***
.param w1  = 0.44u
.param w2  = 0.88u
.param w3  = 1.32u
.param w5  = 2.02u
.param w10 = 4.04u
.param w15 = 6.06u
.param mx=1
***---------------------***
***        Sub-ckt      ***
***---------------------***

* XNor A[0] B[0] Y Pseudo
* XCLAtest A[0] A[1] B[0] B[1] Cin Cin2 CLA
*XFA_pseudo A[0] B[0] CIN S_p C_p FA_ps1
* XFA_ccmos A[0] B[0] CIN S_c C_c FA

*carry look ahead
.subckt FA4 CLK A[3] A[2] A[1] A[0] 
+ B[3] B[2] B[1] B[0] CIN 
+ SUM[3] SUM[2] SUM[1] SUM[0] COUT


XFA0 A[0] B[0] CIN S0 C1 FA_ps1
XFA1 A[1] B[1] C1 S1 C2 FA_ps1

XCLA2 A[0] A[1] B[0] B[1] Cin Cin2 CLA

XFA2 A[2] B[2] Cin2 S2 C3 FA_ps1
XFA3 A[3] B[3] C3 S3 C4 FA_ps1

***---------------------***

XDFF10 S0  CLK SUM[0] DFF
XDFF11 S1  CLK SUM[1] DFF
XDFF12 S2  CLK SUM[2] DFF
XDFF13 S3  CLK SUM[3] DFF
XDFF14 C4  CLK COUT   DFF

.ends
*----------------------

.subckt FA_ps1 A B CIN SUM COUT
M1 _COUT B N005 0 N_18_G2 l=0.18u w=w2
M2 N005 A 0 0 N_18_G2 l=0.18u w=w2
M3 N003 A 0 0 N_18_G2 l=0.18u w=w2
M4 N003 B 0 0 N_18_G2 l=0.18u w=w2
M5 _COUT CIN N003 0 N_18_G2 l=0.18u w=w2

M6 N001 _COUT N004 0 N_18_G2 l=0.18u w=w2
M7 N004 A 0 0 N_18_G2 l=0.18u w=w2
M8 N004 B 0 0 N_18_G2 l=0.18u w=w2
M9 N004 CIN 0 0 N_18_G2 l=0.18u w=w2

M10 N001 CIN N002 0 N_18_G2 l=0.18u w=w2
M11 N002 B N006 0 N_18_G2 l=0.18u w=w2
M12 N006 A 0 0 N_18_G2 l=0.18u w=w2

M13 SUM N001 0 0 N_18_G2 l=0.18u w=w1
M14 COUT _COUT 0 0 N_18_G2 l=0.18u w=w1
M27 SUM N001 VDD VDD P_18_G2 l=0.18u w=w2
M28 COUT _COUT VDD VDD P_18_G2 l=0.18u w=w2

M16 _COUT 0 VDD VDD P_18_G2 l=0.18u w=w1
M15 N001 0 VDD VDD P_18_G2 l=0.18u w=w1
.ends

.subckt FA_ps2 A B CIN SUM 
M1 N002 B N006 0 N_18_G2 l=0.18u w=w2
M2 N006 A 0 0 N_18_G2 l=0.18u w=w2
M3 N004 A 0 0 N_18_G2 l=0.18u w=w2
M4 N004 B 0 0 N_18_G2 l=0.18u w=w2
M5 N002 CIN N004 0 N_18_G2 l=0.18u w=w2
M6 N001 N002 N005 0 N_18_G2 l=0.18u w=w2
M7 N005 A 0 0 N_18_G2 l=0.18u w=w2
M8 N005 B 0 0 N_18_G2 l=0.18u w=w2
M9 N005 CIN 0 0 N_18_G2 l=0.18u w=w2

M10 N001 CIN N003 0 N_18_G2 l=0.18u w=w2
M11 N003 B N007 0 N_18_G2 l=0.18u w=w2
M12 N007 A 0 0 N_18_G2 l=0.18u w=w2

M13 SUM N001 0 0 N_18_G2 l=0.18u w=w1
M15 SUM N001 VDD VDD P_18_G2 l=0.18u w=w2

M17 N001 0 VDD VDD P_18_G2 l=0.18u w=w1
M18 N002 0 VDD VDD P_18_G2 l=0.18u w=w1
.ends

.subckt CLA A[0] A[1] B[0] B[1] Cin Cin2
M1 N001 B[1] N004 GND N_18_G2 l=0.18u w=w2
M2 N004 A[1] GND GND N_18_G2 l=0.18u w=w2
M3 N001 B[1] N002 GND N_18_G2 l=0.18u w=w2
M4 N002 B[0] N005 GND N_18_G2 l=0.18u w=w2
M5 N005 A[0] GND GND N_18_G2 l=0.18u w=w2
M6 N001 A[1] N002 GND N_18_G2 l=0.18u w=w2
M7 N002 Cin N003 GND N_18_G2 l=0.18u w=w2
M8 N003 A[0] GND GND N_18_G2 l=0.18u w=w2
M9 N003 B[0] GND GND N_18_G2 l=0.18u w=w2

M19 Cin2 N001 GND GND N_18_G2 l=0.18u w=w1
M20 Cin2 N001 VDD VDD P_18_G2 l=0.18u w=w2

M10 N001 GND VDD VDD P_18_G2 l=0.18u w=w1
.ends

.subckt DFF D CLK Q
M1 N004 D GND GND N_18_G2 l=0.18u w=w1
M2 N005 CLK GND GND N_18_G2 l=0.18u w=w1
M3 N001 N004 N005 GND N_18_G2 l=0.18u w=w1
M4 N006 N001 GND GND N_18_G2 l=0.18u w=w1
M5 N002 CLK N006 GND N_18_G2 l=0.18u w=w1
M6 N004 CLK N003 VDD P_18_G2 l=0.18u w=w2
M7 N003 D VDD VDD P_18_G2 l=0.18u w=w2
M8 N001 CLK VDD VDD P_18_G2 l=0.18u w=w2
M9 N002 N001 VDD VDD P_18_G2 l=0.18u w=w2
M10 Q N002 VDD VDD P_18_G2 l=0.18u w=w2
M11 Q N002 GND GND N_18_G2 l=0.18u w=w1
.ends

* .subckt FA A B CIN SUM COUT
* M1 _COUT B N010 GND N_18_G2 l=0.18u w=w1
* M2 N010 A GND GND N_18_G2 l=0.18u w=w1

* M3 N008 A GND GND N_18_G2 l=0.18u w=w5
* M4 N008 B GND GND N_18_G2 l=0.18u w=w5
* M5 _COUT CIN N008 GND N_18_G2 l=0.18u w=w5

* M6 N006 _COUT N009 GND N_18_G2 l=0.18u w=w1
* M7 N009 A GND GND N_18_G2 l=0.18u w=w1
* M8 N009 B GND GND N_18_G2 l=0.18u w=w1
* M9 N009 CIN GND GND N_18_G2 l=0.18u w=w1

* M10 N006 CIN N007 GND N_18_G2 l=0.18u w=w1
* M11 N007 B N011 GND N_18_G2 l=0.18u w=w1
* M12 N011 A GND GND N_18_G2 l=0.18u w=w1

* M13 SUM N006 GND GND N_18_G2 l=0.18u w=w1
* M14 COUT _COUT GND GND N_18_G2 l=0.18u w=w1

* M15 _COUT B N004 VDD P_18_G2 l=0.18u w=w1
* M16 N004 A VDD VDD P_18_G2 l=0.18u w=w1

* M17 _COUT CIN N002 VDD P_18_G2 l=0.18u w=w10
* M18 N002 B VDD VDD P_18_G2 l=0.18u w=w10
* M19 N002 A VDD VDD P_18_G2 l=0.18u w=w10

* M20 N006 _COUT N003 VDD P_18_G2 l=0.18u w=w1
* M21 N003 A VDD VDD P_18_G2 l=0.18u w=w1
* M22 N003 B VDD VDD P_18_G2 l=0.18u w=w1
* M23 N003 CIN VDD VDD P_18_G2 l=0.18u w=w1

* M24 N006 CIN N005 VDD P_18_G2 l=0.18u w=w1
* M25 N005 B N001 VDD P_18_G2 l=0.18u w=w1
* M26 N001 A VDD VDD P_18_G2 l=0.18u w=w1

* M27 SUM N006 VDD VDD P_18_G2 l=0.18u w=w2
* M28 COUT _COUT VDD VDD P_18_G2 l=0.18u w=w2
* .ends


* .subckt SUM A B CIN SUM 
* M3 N010 _B GND GND N_18_G2 l=0.18u w=w3
* M5 N011 B GND GND N_18_G2 l=0.18u w=w3
* M8 N012 B GND GND N_18_G2 l=0.18u w=w3
* M10 N013 _B GND GND N_18_G2 l=0.18u w=w3
* M21 SUM N007 VDD VDD P_18_G2 l=0.18u w=w15
* M22 SUM N007 GND GND N_18_G2 l=0.18u w=w3
* M2 N007 _CIN N005 VDD P_18_G2 l=0.18u w=w15
* M4 N005 _B N001 VDD P_18_G2 l=0.18u w=w15
* M7 N001 A VDD VDD P_18_G2 l=0.18u w=w15
* M9 N002 _A VDD VDD P_18_G2 l=0.18u w=w15
* M11 N005 B N002 VDD P_18_G2 l=0.18u w=w15
* M12 N006 _B N004 VDD P_18_G2 l=0.18u w=w15
* M13 N004 _A VDD VDD P_18_G2 l=0.18u w=w15
* M14 N006 B N003 VDD P_18_G2 l=0.18u w=w15
* M15 N003 A VDD VDD P_18_G2 l=0.18u w=w15
* M16 N007 CIN N006 VDD P_18_G2 l=0.18u w=w15
* M1 N007 _CIN N008 GND N_18_G2 l=0.18u w=w3
* M6 N007 CIN N009 GND N_18_G2 l=0.18u w=w3
* M17 N009 A N012 GND N_18_G2 l=0.18u w=w3
* M18 N008 A N010 GND N_18_G2 l=0.18u w=w3
* M19 N008 _A N011 GND N_18_G2 l=0.18u w=w3
* M20 N009 _A N013 GND N_18_G2 l=0.18u w=w3
* .ends


* .subckt CLA3 A[0] A[1] A[2] B[0] B[1] B[2] Cin Cin3
* M1 N001 B[2] N011 GND N_18_G2 l=0.18u w=w2
* M2 N011 A[2] GND GND N_18_G2 l=0.18u w=w2
* M3 N001 B[2] N008 GND N_18_G2 l=0.18u w=w2
* M4 N008 B[1] N012 GND N_18_G2 l=0.18u w=w2
* M5 N012 A[1] GND GND N_18_G2 l=0.18u w=w2
* M6 N008 B[1] N009 GND N_18_G2 l=0.18u w=w2
* M7 N009 B[0] N013 GND N_18_G2 l=0.18u w=w2
* M8 N013 A[0] GND GND N_18_G2 l=0.18u w=w2
* M9 N010 B[0] GND GND N_18_G2 l=0.18u w=w2
* M10 N001 A[2] N008 GND N_18_G2 l=0.18u w=w2
* M11 N008 A[1] N009 GND N_18_G2 l=0.18u w=w2
* M12 N009 Cin N010 GND N_18_G2 l=0.18u w=w2
* M13 N010 A[0] GND GND N_18_G2 l=0.18u w=w2
* M14 Cin3 N001 GND GND N_18_G2 l=0.18u w=w3
* M15 N001 B[2] N007 VDD P_18_G2 l=0.18u w=w10
* M16 N007 A[2] VDD VDD P_18_G2 l=0.18u w=w10
* M17 N001 B[2] N006 VDD P_18_G2 l=0.18u w=w10
* M18 N006 B[1] N005 VDD P_18_G2 l=0.18u w=w10
* M19 N005 A[1] VDD VDD P_18_G2 l=0.18u w=w10
* M20 N006 B[1] N004 VDD P_18_G2 l=0.18u w=w10
* M21 N004 B[0] N003 VDD P_18_G2 l=0.18u w=w10
* M22 N003 A[0] VDD VDD P_18_G2 l=0.18u w=w10
* M23 N002 B[0] VDD VDD P_18_G2 l=0.18u w=w10
* M24 N001 A[2] N006 VDD P_18_G2 l=0.18u w=w10
* M25 N006 A[1] N004 VDD P_18_G2 l=0.18u w=w10
* M26 N004 Cin N002 VDD P_18_G2 l=0.18u w=w10
* M27 N002 A[0] VDD VDD P_18_G2 l=0.18u w=w10
* M28 Cin3 N001 VDD VDD P_18_G2 l=0.18u w=w15
* .ends

************other subckt test

* .subckt Pseudo A[0] B[0] Y
* M1 Y A[0] 0 0 N_18_G2 l=0.18u w=w5
* M2 Y B[0] 0 0 N_18_G2 l=0.18u w=w5
* M3 Y 0 VDD VDD P_18_G2 l=0.18u w=w2
* .ends 
***-----------------------***
***      measurements     ***
***-----------------------***
.meas tran trise0 trig v(sum[0]) val='supply*0.1' rise=1
+targ v(sum[0]) val='supply*0.9' rise=1

.meas tran tfall0 trig v(sum[0]) val='supply*0.9' fall=1
+targ v(sum[0]) val='supply*0.1' fall=1

.meas tran trise1 trig v(sum[1]) val='supply*0.1' rise=1
+targ v(sum[1]) val='supply*0.9' rise=1

.meas tran tfall1 trig v(sum[1]) val='supply*0.9' fall=1
+targ v(sum[1]) val='supply*0.1' fall=1

.meas tran trise2 trig v(sum[2]) val='supply*0.1' rise=1
+targ v(sum[2]) val='supply*0.9' rise=1

.meas tran tfall2 trig v(sum[2]) val='supply*0.9' fall=1
+targ v(sum[2]) val='supply*0.1' fall=1

.meas tran trise3 trig v(sum[3]) val='supply*0.1' rise=1
+targ v(sum[3]) val='supply*0.9' rise=1

.meas tran tfall3 trig v(sum[3]) val='supply*0.9' fall=1
+targ v(sum[3]) val='supply*0.1' fall=1

.meas tran trisec trig v(cout) val='supply*0.1' rise=1
+targ v(cout) val='supply*0.9' rise=1

.meas tran tfallc trig v(cout) val='supply*0.9' fall=1
+targ v(cout) val='supply*0.1' fall=1


* .meas tran try trig v(y) val='supply*0.1' rise=1
* +targ v(y) val='supply*0.9' rise=1

* .meas tran tfy trig v(y) val='supply*0.9' fall=1
* +targ v(y) val='supply*0.1' fall=1

* .meas tran trcin2 trig v(cin2) val='supply*0.1' rise=1
* +targ v(cin2) val='supply*0.9' rise=1

* .meas tran tfcin2 trig v(cin2) val='supply*0.9' fall=1
* +targ v(cin2) val='supply*0.1' fall=1

.meas tran trs_p trig v(S_p) val='supply*0.1' rise=1
+targ v(S_p) val='supply*0.9' rise=1

.meas tran tfs_p trig v(S_p) val='supply*0.9' fall=1
+targ v(S_p) val='supply*0.1' fall=1

.meas tran trc_p trig v(C_p) val='supply*0.1' rise=1
+targ v(C_p) val='supply*0.9' rise=1

.meas tran tfc_p trig v(C_p) val='supply*0.9' fall=1
+targ v(C_p) val='supply*0.1' fall=1
.end
