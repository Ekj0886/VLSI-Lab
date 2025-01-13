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

***** you can modify clock cycle here, remember synchronize with clock cycle in FA4.vec ****
.param period = 0.52n

***** Define your sub-circuit and self-defined parameter here , and only need to submmit this part ****

***---------------------***
***        Width        ***
***---------------------***
.param w1  = 0.44u
.param w2  = 0.88u

***---------------------***
***        Sub-ckt      ***
***---------------------***

.subckt FA4 CLK A[3] A[2] A[1] A[0] 
+ B[3] B[2] B[1] B[0] CIN 
+ SUM[3] SUM[2] SUM[1] SUM[0] COUT


XFA0 A[0] B[0] CIN S0 C1 FA1
XFA1 A[1] B[1] C1 S1 C2 FA1
XFA2 A[2] B[2] C2 S2 C3 FA2

XCLA A[0] A[1] A[2] B[0] B[1] B[2] Cin Cin3 CLA

XFA3 A[3] B[3] Cin3 S3 C4 FA2

***---------------------***

XDFF10 S0  CLK SUM[0] DFF
XDFF11 S1  CLK SUM[1] DFF
XDFF12 S2  CLK SUM[2] DFF
XDFF13 S3  CLK SUM[3] DFF
XDFF14 C4  CLK COUT   DFF

.ends
*----------------------

.subckt FA1 A B CIN _SUM COUT
M1 _COUT B N004 GND N l=0.18u w=w2
M2 N004 A GND GND N l=0.18u w=w2
M3 N002 A GND GND N l=0.18u w=w2
M4 N002 B GND GND N l=0.18u w=w2
M5 _COUT CIN N002 GND N l=0.18u w=w2
M6 _SUM _COUT N003 GND N l=0.18u w=w2
M7 N003 A GND GND N l=0.18u w=w2
M8 N003 B GND GND N l=0.18u w=w2
M9 N003 CIN GND GND N l=0.18u w=w2
M10 _SUM CIN N001 GND N l=0.18u w=w2
M11 N001 B N005 GND N l=0.18u w=w2
M12 N005 A GND GND N l=0.18u w=w2
M14 COUT _COUT GND GND N l=0.18u w=w1
M16 COUT _COUT VDD VDD P l=0.18u w=w2
M17 _SUM GND VDD VDD P l=0.18u w=w1
M18 _COUT GND VDD VDD P l=0.18u w=w1
.ends

.subckt FA2 A B CIN _SUM _COUT
M1 _COUT B N004 GND N l=0.18u w=w2
M2 N004 A GND GND N l=0.18u w=w2
M3 N002 A GND GND N l=0.18u w=w2
M4 N002 B GND GND N l=0.18u w=w2
M5 _COUT CIN N002 GND N l=0.18u w=w2
M6 _SUM _COUT N003 GND N l=0.18u w=w2
M7 N003 A GND GND N l=0.18u w=w2
M8 N003 B GND GND N l=0.18u w=w2
M9 N003 CIN GND GND N l=0.18u w=w2
M10 _SUM CIN N001 GND N l=0.18u w=w2
M11 N001 B N005 GND N l=0.18u w=w2
M12 N005 A GND GND N l=0.18u w=w2
M15 _SUM GND VDD VDD P l=0.18u w=w1
M16 _COUT GND VDD VDD P l=0.18u w=w1
.ends

.subckt CLA A[0] A[1] A[2] B[0] B[1] B[2] Cin Cin3
M1 N001 B[2] N005 GND N l=0.18u w=w2
M2 N005 A[2] GND GND N l=0.18u w=w2
M3 N001 B[2] N002 GND N l=0.18u w=w2
M4 N002 B[1] N006 GND N l=0.18u w=w2
M5 N006 A[1] GND GND N l=0.18u w=w2
M6 N002 B[1] N003 GND N l=0.18u w=w2
M7 N003 B[0] N007 GND N l=0.18u w=w2
M8 N007 A[0] GND GND N l=0.18u w=w2
M9 N004 B[0] GND GND N l=0.18u w=w2
M10 N001 A[2] N002 GND N l=0.18u w=w2
M11 N002 A[1] N003 GND N l=0.18u w=w2
M12 N003 Cin N004 GND N l=0.18u w=w2
M13 N004 A[0] GND GND N l=0.18u w=w2
M14 Cin3 N001 GND GND N l=0.18u w=w1
M15 N001 GND VDD VDD P l=0.18u w=w1
M28 Cin3 N001 VDD VDD P l=0.18u w=w2
.ends


.subckt DFF D CLK Q
M1 N003 D GND GND N l=0.18u w=w1
M3 N001 N003 GND GND N l=0.18u w=w1
M4 N002 CLK N003 GND N l=0.18u w=w1
M11 Q N001 GND GND N l=0.18u w=w1
M7 N002 D VDD VDD P l=0.18u w=w2
M10 Q N001 VDD VDD P l=0.18u w=w2
M2 N001 N002 VDD VDD P l=0.18u w=w2
.ends

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

.meas tran trcin3 trig v(cin3) val='supply*0.1' rise=1
+targ v(cin3) val='supply*0.9' rise=1

.meas tran tfcin3 trig v(cin3) val='supply*0.9' fall=1
+targ v(cin3) val='supply*0.1' fall=1

.end
