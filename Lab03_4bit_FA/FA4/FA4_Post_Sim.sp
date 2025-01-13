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
XFA A[2] B[2] A[1] B[1] A[0] B[0] CIN CLK GND SUM[3] VDD COUT SUM[2]
+ SUM[1] SUM[0] A[3] B[3] FA4

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
.param period = 0.59n

***** Define your sub-circuit and self-defined parameter here , and only need to submmit this part ****


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


* File: FA4_LPE.sp
* Created: Sun Nov 20 03:21:06 2022
* Program "Calibre xRC"
* Version "v2021.1_33.19"
* 
.include "FA4_LPE.sp.pex"
.subckt FA4  A[2] B[2] A[1] B[1] A[0] B[0] CIN CLK GND SUM[3] VDD COUT SUM[2]
+ SUM[1] SUM[0] A[3] B[3]
* 
* B[3]	B[3]
* A[3]	A[3]
* SUM[0]	SUM[0]
* SUM[1]	SUM[1]
* SUM[2]	SUM[2]
* COUT	COUT
* VDD	VDD
* SUM[3]	SUM[3]
* GND	GND
* CLK	CLK
* CIN	CIN
* B[0]	B[0]
* A[0]	A[0]
* B[1]	B[1]
* A[1]	A[1]
* B[2]	B[2]
* A[2]	A[2]
mXCLA/M10 N_XCLA/N001_XCLA/M10_d N_A[2]_XCLA/M10_g N_noxref_87_XCLA/M10_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXCLA/M3 N_XCLA/N001_XCLA/M3_d N_B[2]_XCLA/M3_g N_noxref_87_XCLA/M3_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXCLA/M11 N_noxref_87_XCLA/M11_d N_A[1]_XCLA/M11_g N_noxref_75_XCLA/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXCLA/M6 N_noxref_87_XCLA/M6_d N_B[1]_XCLA/M6_g N_noxref_75_XCLA/M6_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXCLA/M13 N_noxref_82_XCLA/M13_d N_A[0]_XCLA/M13_g N_GND_XCLA/M13_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXCLA/M9 N_noxref_82_XCLA/M9_d N_B[0]_XCLA/M9_g N_GND_XCLA/M9_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=2.376e-13 PD=5.4e-07 PS=5.4e-07
mXCLA/M12 N_noxref_75_XCLA/M12_d N_CIN_XCLA/M12_g N_noxref_82_XCLA/M12_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXCLA/M14 N_CIN3_XCLA/M14_d N_XCLA/N001_XCLA/M14_g N_GND_XCLA/M14_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXCLA/M2 N_XCLA/N005_XCLA/M2_d N_A[2]_XCLA/M2_g N_GND_XCLA/M2_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07 PS=1.86e-06
mXCLA/M1 N_XCLA/N001_XCLA/M1_d N_B[2]_XCLA/M1_g N_XCLA/N005_XCLA/M1_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXCLA/M5 N_noxref_111_XCLA/M5_d N_A[1]_XCLA/M5_g N_GND_XCLA/M5_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXCLA/M4 N_noxref_87_XCLA/M4_d N_B[1]_XCLA/M4_g N_noxref_111_XCLA/M4_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXCLA/M8 N_noxref_112_XCLA/M8_d N_A[0]_XCLA/M8_g N_GND_XCLA/M8_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXCLA/M7 N_noxref_75_XCLA/M7_d N_B[0]_XCLA/M7_g N_noxref_112_XCLA/M7_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF13/M4 N_XDFF13/N002_XDFF13/M4_d N_CLK_XDFF13/M4_g N_XDFF13/N003_XDFF13/M4_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF13/M1 N_XDFF13/N003_XDFF13/M1_d N_S3_XDFF13/M1_g N_GND_XDFF13/M1_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=1.188e-13 AS=1.188e-13 PD=5.4e-07
+ PS=5.4e-07
mXDFF13/M3 N_XDFF13/N001_XDFF13/M3_d N_XDFF13/N003_XDFF13/M3_g N_GND_XDFF13/M3_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF13/M11 N_SUM[3]_XDFF13/M11_d N_XDFF13/N001_XDFF13/M11_g N_GND_XDFF13/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXFA3/M7 N_XFA3/N003_XFA3/M7_d N_A[3]_XFA3/M7_g N_GND_XFA3/M7_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07 PS=1.86e-06
mXFA3/M8 N_XFA3/N003_XFA3/M8_d N_B[3]_XFA3/M8_g N_GND_XFA3/M8_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=2.772e-13 PD=5.4e-07 PS=6.3e-07
mXFA3/M9 N_XFA3/N003_XFA3/M9_d N_CIN3_XFA3/M9_g N_GND_XFA3/M9_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.816e-13 AS=2.772e-13 PD=6.4e-07 PS=6.3e-07
mXFA3/M6 N_S3_XFA3/M6_d N_C4_XFA3/M6_g N_XFA3/N003_XFA3/M6_s N_GND_XCLA/M10_b N_18_G2
+ L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.816e-13 PD=1.86e-06 PS=6.4e-07
mXFA2/M7 N_XFA2/N003_XFA2/M7_d N_A[2]_XFA2/M7_g N_GND_XFA2/M7_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07 PS=1.86e-06
mXFA2/M8 N_XFA2/N003_XFA2/M8_d N_B[2]_XFA2/M8_g N_GND_XFA2/M8_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=2.772e-13 PD=5.4e-07 PS=6.3e-07
mXFA2/M9 N_XFA2/N003_XFA2/M9_d N_C2_XFA2/M9_g N_GND_XFA2/M9_s N_GND_XCLA/M10_b N_18_G2
+ L=1.8e-07 W=8.8e-07 AD=2.816e-13 AS=2.772e-13 PD=6.4e-07 PS=6.3e-07
mXFA2/M6 N_S2_XFA2/M6_d N_C3_XFA2/M6_g N_XFA2/N003_XFA2/M6_s N_GND_XCLA/M10_b N_18_G2
+ L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.816e-13 PD=1.86e-06 PS=6.4e-07
mXFA1/M7 N_XFA1/N003_XFA1/M7_d N_A[1]_XFA1/M7_g N_GND_XFA1/M7_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07 PS=1.86e-06
mXFA1/M8 N_XFA1/N003_XFA1/M8_d N_B[1]_XFA1/M8_g N_GND_XFA1/M8_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=2.772e-13 PD=5.4e-07 PS=6.3e-07
mXFA1/M9 N_XFA1/N003_XFA1/M9_d N_C1_XFA1/M9_g N_GND_XFA1/M9_s N_GND_XCLA/M10_b N_18_G2
+ L=1.8e-07 W=8.8e-07 AD=2.816e-13 AS=2.772e-13 PD=6.4e-07 PS=6.3e-07
mXFA1/M6 N_S1_XFA1/M6_d N_XFA1/_COUT_XFA1/M6_g N_XFA1/N003_XFA1/M6_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.816e-13 PD=1.86e-06
+ PS=6.4e-07
mXFA0/M7 N_XFA0/N003_XFA0/M7_d N_A[0]_XFA0/M7_g N_GND_XFA0/M7_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07 PS=1.86e-06
mXFA0/M8 N_XFA0/N003_XFA0/M8_d N_B[0]_XFA0/M8_g N_GND_XFA0/M8_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=2.772e-13 PD=5.4e-07 PS=6.3e-07
mXFA0/M9 N_XFA0/N003_XFA0/M9_d N_CIN_XFA0/M9_g N_GND_XFA0/M9_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.816e-13 AS=2.772e-13 PD=6.4e-07 PS=6.3e-07
mXFA0/M6 N_S0_XFA0/M6_d N_XFA0/_COUT_XFA0/M6_g N_XFA0/N003_XFA0/M6_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.816e-13 PD=1.86e-06
+ PS=6.4e-07
mXFA3/M12 N_XFA3/N005_XFA3/M12_d N_A[3]_XFA3/M12_g N_GND_XFA3/M12_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXFA3/M11 N_XFA3/N001_XFA3/M11_d N_B[3]_XFA3/M11_g N_XFA3/N005_XFA3/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.772e-13 AS=2.376e-13 PD=6.3e-07
+ PS=5.4e-07
mXFA3/M10 N_S3_XFA3/M10_d N_CIN3_XFA3/M10_g N_XFA3/N001_XFA3/M10_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.772e-13 PD=1.86e-06
+ PS=6.3e-07
mXFA2/M12 N_XFA2/N005_XFA2/M12_d N_A[2]_XFA2/M12_g N_GND_XFA2/M12_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXFA2/M11 N_XFA2/N001_XFA2/M11_d N_B[2]_XFA2/M11_g N_XFA2/N005_XFA2/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.772e-13 AS=2.376e-13 PD=6.3e-07
+ PS=5.4e-07
mXFA2/M10 N_S2_XFA2/M10_d N_C2_XFA2/M10_g N_XFA2/N001_XFA2/M10_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.772e-13 PD=1.86e-06
+ PS=6.3e-07
mXFA1/M12 N_XFA1/N005_XFA1/M12_d N_A[1]_XFA1/M12_g N_GND_XFA1/M12_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXFA1/M11 N_XFA1/N001_XFA1/M11_d N_B[1]_XFA1/M11_g N_XFA1/N005_XFA1/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.772e-13 AS=2.376e-13 PD=6.3e-07
+ PS=5.4e-07
mXFA1/M10 N_S1_XFA1/M10_d N_C1_XFA1/M10_g N_XFA1/N001_XFA1/M10_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.772e-13 PD=1.86e-06
+ PS=6.3e-07
mXFA0/M12 N_XFA0/N005_XFA0/M12_d N_A[0]_XFA0/M12_g N_GND_XFA0/M12_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07
+ PS=1.86e-06
mXFA0/M11 N_XFA0/N001_XFA0/M11_d N_B[0]_XFA0/M11_g N_XFA0/N005_XFA0/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.772e-13 AS=2.376e-13 PD=6.3e-07
+ PS=5.4e-07
mXFA0/M10 N_S0_XFA0/M10_d N_CIN_XFA0/M10_g N_XFA0/N001_XFA0/M10_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.772e-13 PD=1.86e-06
+ PS=6.3e-07
mXFA3/M2 N_XFA3/N004_XFA3/M2_d N_A[3]_XFA3/M2_g N_GND_XFA3/M2_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07 PS=1.86e-06
mXFA3/M1 N_C4_XFA3/M1_d N_B[3]_XFA3/M1_g N_XFA3/N004_XFA3/M1_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06 PS=5.4e-07
mXFA2/M2 N_XFA2/N004_XFA2/M2_d N_A[2]_XFA2/M2_g N_GND_XFA2/M2_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07 PS=1.86e-06
mXFA2/M1 N_C3_XFA2/M1_d N_B[2]_XFA2/M1_g N_XFA2/N004_XFA2/M1_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06 PS=5.4e-07
mXFA1/M2 N_XFA1/N004_XFA1/M2_d N_A[1]_XFA1/M2_g N_GND_XFA1/M2_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07 PS=1.86e-06
mXFA1/M1 N_XFA1/_COUT_XFA1/M1_d N_B[1]_XFA1/M1_g N_XFA1/N004_XFA1/M1_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXFA0/M2 N_XFA0/N004_XFA0/M2_d N_A[0]_XFA0/M2_g N_GND_XFA0/M2_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.376e-13 AS=4.312e-13 PD=5.4e-07 PS=1.86e-06
mXFA0/M1 N_XFA0/_COUT_XFA0/M1_d N_B[0]_XFA0/M1_g N_XFA0/N004_XFA0/M1_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXFA3/M3 N_XFA3/N002_XFA3/M3_d N_A[3]_XFA3/M3_g N_GND_XFA3/M3_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06 PS=5.4e-07
mXFA3/M4 N_XFA3/N002_XFA3/M4_d N_B[3]_XFA3/M4_g N_GND_XFA3/M4_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.772e-13 AS=2.376e-13 PD=6.3e-07 PS=5.4e-07
mXFA3/M5 N_C4_XFA3/M5_d N_CIN3_XFA3/M5_g N_XFA3/N002_XFA3/M5_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.772e-13 PD=1.86e-06 PS=6.3e-07
mXFA2/M3 N_XFA2/N002_XFA2/M3_d N_A[2]_XFA2/M3_g N_GND_XFA2/M3_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06 PS=5.4e-07
mXFA2/M4 N_XFA2/N002_XFA2/M4_d N_B[2]_XFA2/M4_g N_GND_XFA2/M4_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.772e-13 AS=2.376e-13 PD=6.3e-07 PS=5.4e-07
mXFA2/M5 N_C3_XFA2/M5_d N_C2_XFA2/M5_g N_XFA2/N002_XFA2/M5_s N_GND_XCLA/M10_b N_18_G2
+ L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.772e-13 PD=1.86e-06 PS=6.3e-07
mXFA1/M3 N_XFA1/N002_XFA1/M3_d N_A[1]_XFA1/M3_g N_GND_XFA1/M3_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06 PS=5.4e-07
mXFA1/M4 N_XFA1/N002_XFA1/M4_d N_B[1]_XFA1/M4_g N_GND_XFA1/M4_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.772e-13 AS=2.376e-13 PD=6.3e-07 PS=5.4e-07
mXFA1/M5 N_XFA1/_COUT_XFA1/M5_d N_C1_XFA1/M5_g N_XFA1/N002_XFA1/M5_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.772e-13 PD=1.86e-06
+ PS=6.3e-07
mXFA0/M3 N_XFA0/N002_XFA0/M3_d N_A[0]_XFA0/M3_g N_GND_XFA0/M3_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06 PS=5.4e-07
mXFA0/M4 N_XFA0/N002_XFA0/M4_d N_B[0]_XFA0/M4_g N_GND_XFA0/M4_s N_GND_XCLA/M10_b
+ N_18_G2 L=1.8e-07 W=8.8e-07 AD=2.772e-13 AS=2.376e-13 PD=6.3e-07 PS=5.4e-07
mXFA0/M5 N_XFA0/_COUT_XFA0/M5_d N_CIN_XFA0/M5_g N_XFA0/N002_XFA0/M5_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.772e-13 PD=1.86e-06
+ PS=6.3e-07
mXFA1/M14 N_C2_XFA1/M14_d N_XFA1/_COUT_XFA1/M14_g N_GND_XFA1/M14_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXFA0/M14 N_C1_XFA0/M14_d N_XFA0/_COUT_XFA0/M14_g N_GND_XFA0/M14_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXDFF14/M4 N_XDFF14/N002_XDFF14/M4_d N_CLK_XDFF14/M4_g N_XDFF14/N003_XDFF14/M4_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF14/M1 N_XDFF14/N003_XDFF14/M1_d N_C4_XDFF14/M1_g N_GND_XDFF14/M1_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=1.188e-13 AS=1.188e-13 PD=5.4e-07
+ PS=5.4e-07
mXDFF14/M3 N_XDFF14/N001_XDFF14/M3_d N_XDFF14/N003_XDFF14/M3_g N_GND_XDFF14/M3_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF14/M11 N_COUT_XDFF14/M11_d N_XDFF14/N001_XDFF14/M11_g N_GND_XDFF14/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXDFF12/M4 N_XDFF12/N002_XDFF12/M4_d N_CLK_XDFF12/M4_g N_XDFF12/N003_XDFF12/M4_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF12/M1 N_XDFF12/N003_XDFF12/M1_d N_S2_XDFF12/M1_g N_GND_XDFF12/M1_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=1.188e-13 AS=1.188e-13 PD=5.4e-07
+ PS=5.4e-07
mXDFF12/M3 N_XDFF12/N001_XDFF12/M3_d N_XDFF12/N003_XDFF12/M3_g N_GND_XDFF12/M3_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF12/M11 N_SUM[2]_XDFF12/M11_d N_XDFF12/N001_XDFF12/M11_g N_GND_XDFF12/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXDFF11/M4 N_XDFF11/N002_XDFF11/M4_d N_CLK_XDFF11/M4_g N_XDFF11/N003_XDFF11/M4_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF11/M1 N_XDFF11/N003_XDFF11/M1_d N_S1_XDFF11/M1_g N_GND_XDFF11/M1_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=1.188e-13 AS=1.188e-13 PD=5.4e-07
+ PS=5.4e-07
mXDFF11/M3 N_XDFF11/N001_XDFF11/M3_d N_XDFF11/N003_XDFF11/M3_g N_GND_XDFF11/M3_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF11/M11 N_SUM[1]_XDFF11/M11_d N_XDFF11/N001_XDFF11/M11_g N_GND_XDFF11/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXDFF10/M4 N_XDFF10/N002_XDFF10/M4_d N_CLK_XDFF10/M4_g N_XDFF10/N003_XDFF10/M4_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF10/M1 N_XDFF10/N003_XDFF10/M1_d N_S0_XDFF10/M1_g N_GND_XDFF10/M1_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=1.188e-13 AS=1.188e-13 PD=5.4e-07
+ PS=5.4e-07
mXDFF10/M3 N_XDFF10/N001_XDFF10/M3_d N_XDFF10/N003_XDFF10/M3_g N_GND_XDFF10/M3_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06
+ PS=5.4e-07
mXDFF10/M11 N_SUM[0]_XDFF10/M11_d N_XDFF10/N001_XDFF10/M11_g N_GND_XDFF10/M11_s
+ N_GND_XCLA/M10_b N_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXDFF13/M7 N_XDFF13/N002_XDFF13/M7_d N_S3_XDFF13/M7_g N_VDD_XDFF13/M7_s
+ N_VDD_XDFF13/M7_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF13/M2 N_XDFF13/N001_XDFF13/M2_d N_XDFF13/N002_XDFF13/M2_g N_VDD_XDFF13/M2_s
+ N_VDD_XDFF13/M7_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF13/M10 N_SUM[3]_XDFF13/M10_d N_XDFF13/N001_XDFF13/M10_g N_VDD_XDFF13/M10_s
+ N_VDD_XDFF13/M7_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=4.312e-13 PD=1.86e-06
+ PS=1.86e-06
mXCLA/M15 N_XCLA/N001_XCLA/M15_d N_GND_XCLA/M15_g N_VDD_XCLA/M15_s
+ N_VDD_XDFF13/M7_b P_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.61333e-13
+ PD=1.42e-06 PS=5.53333e-07
mXCLA/M28 N_CIN3_XCLA/M28_d N_XCLA/N001_XCLA/M28_g N_VDD_XCLA/M28_s
+ N_VDD_XDFF13/M7_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=3.22667e-13
+ PD=1.86e-06 PS=1.10667e-06
mXFA3/M15 N_S3_XFA3/M15_d N_GND_XFA3/M15_g N_VDD_XFA3/M15_s N_VDD_XFA3/M15_b P_18_G2
+ L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06 PS=5.4e-07
mXFA3/M16 N_C4_XFA3/M16_d N_GND_XFA3/M16_g N_VDD_XFA3/M16_s N_VDD_XFA3/M15_b P_18_G2
+ L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06 PS=5.4e-07
mXFA2/M15 N_S2_XFA2/M15_d N_GND_XFA2/M15_g N_VDD_XFA2/M15_s N_VDD_XFA3/M15_b P_18_G2
+ L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06 PS=5.4e-07
mXFA2/M16 N_C3_XFA2/M16_d N_GND_XFA2/M16_g N_VDD_XFA2/M16_s N_VDD_XFA3/M15_b P_18_G2
+ L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=1.188e-13 PD=1.42e-06 PS=5.4e-07
mXFA1/M17 N_S1_XFA1/M17_d N_GND_XFA1/M17_g N_VDD_XFA1/M17_s N_VDD_XFA3/M15_b P_18_G2
+ L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06 PS=1.42e-06
mXFA1/M18 N_XFA1/_COUT_XFA1/M18_d N_GND_XFA1/M18_g N_VDD_XFA1/M18_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXFA1/M16 N_C2_XFA1/M16_d N_XFA1/_COUT_XFA1/M16_g N_VDD_XFA1/M16_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=4.312e-13 PD=1.86e-06
+ PS=1.86e-06
mXFA0/M17 N_S0_XFA0/M17_d N_GND_XFA0/M17_g N_VDD_XFA0/M17_s N_VDD_XFA3/M15_b P_18_G2
+ L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06 PS=1.42e-06
mXFA0/M18 N_XFA0/_COUT_XFA0/M18_d N_GND_XFA0/M18_g N_VDD_XFA0/M18_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=4.4e-07 AD=2.156e-13 AS=2.156e-13 PD=1.42e-06
+ PS=1.42e-06
mXFA0/M16 N_C1_XFA0/M16_d N_XFA0/_COUT_XFA0/M16_g N_VDD_XFA0/M16_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=4.312e-13 PD=1.86e-06
+ PS=1.86e-06
mXDFF14/M7 N_XDFF14/N002_XDFF14/M7_d N_C4_XDFF14/M7_g N_VDD_XDFF14/M7_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF14/M2 N_XDFF14/N001_XDFF14/M2_d N_XDFF14/N002_XDFF14/M2_g N_VDD_XDFF14/M2_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF14/M10 N_COUT_XDFF14/M10_d N_XDFF14/N001_XDFF14/M10_g N_VDD_XDFF14/M10_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=4.312e-13 PD=1.86e-06
+ PS=1.86e-06
mXDFF12/M7 N_XDFF12/N002_XDFF12/M7_d N_S2_XDFF12/M7_g N_VDD_XDFF12/M7_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF12/M2 N_XDFF12/N001_XDFF12/M2_d N_XDFF12/N002_XDFF12/M2_g N_VDD_XDFF12/M2_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF12/M10 N_SUM[2]_XDFF12/M10_d N_XDFF12/N001_XDFF12/M10_g N_VDD_XDFF12/M10_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=4.312e-13 PD=1.86e-06
+ PS=1.86e-06
mXDFF11/M7 N_XDFF11/N002_XDFF11/M7_d N_S1_XDFF11/M7_g N_VDD_XDFF11/M7_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF11/M2 N_XDFF11/N001_XDFF11/M2_d N_XDFF11/N002_XDFF11/M2_g N_VDD_XDFF11/M2_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF11/M10 N_SUM[1]_XDFF11/M10_d N_XDFF11/N001_XDFF11/M10_g N_VDD_XDFF11/M10_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=4.312e-13 PD=1.86e-06
+ PS=1.86e-06
mXDFF10/M7 N_XDFF10/N002_XDFF10/M7_d N_S0_XDFF10/M7_g N_VDD_XDFF10/M7_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF10/M2 N_XDFF10/N001_XDFF10/M2_d N_XDFF10/N002_XDFF10/M2_g N_VDD_XDFF10/M2_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=2.376e-13 PD=1.86e-06
+ PS=5.4e-07
mXDFF10/M10 N_SUM[0]_XDFF10/M10_d N_XDFF10/N001_XDFF10/M10_g N_VDD_XDFF10/M10_s
+ N_VDD_XFA3/M15_b P_18_G2 L=1.8e-07 W=8.8e-07 AD=4.312e-13 AS=4.312e-13 PD=1.86e-06
+ PS=1.86e-06
*
.include "FA4_LPE.sp.FA4.pxi"
*
.ends
*
*

.end