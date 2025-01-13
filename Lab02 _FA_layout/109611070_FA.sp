.title vlsi_Lab02_FA_Pre_sim
***-----------------------***
***        setting        ***
***-----------------------***
.lib "umc018.l" L18U18V_TT
.options post
.options brief

.global VDD GND
.param supply = 1.8v
.param load = 10f
*---------------------------

.param wpx1 = 1.17u
.param wnx1 = 0.46u

.param wpx2 = 0.94u
.param wnx2 = 0.44u

.param wpxi2 = 1.46u
.param wnxi2 = 0.71u

**nand
.param wpn = 0.44u
.param wnn = 0.44u

.param wp = 0.44u
.param wn = 0.44u

.param wpb = 1.55u
.param wnb = 0.44u
***-----------------------***
***       simulation      ***
***-----------------------***
.tran 0.1n 40n

***-----------------------***
***      power/input      ***
***-----------------------***
Vd VDD  GND supply

Vda A   GND pulse(0v, supply, 3n, 0.1n, 0.1n, 1.9n, 4n)
Vdb B   GND pulse(0v, supply, 5n, 0.1n, 0.1n, 3.9n, 8n)
Vdc CIN GND pulse(0v, supply, 9n, 0.1n, 0.1n, 7.9n, 16n)

***-----------------------***
***      measurements     ***
***-----------------------***
*power
.meas tran avg_power avg power from 0n to 30n

*-----------------------------------------------------------------------------*
*Pro AS
.meas tran SUM_td1 trig v(a) val='supply/2' rise=1
+targ v(sum) val='supply/2' rise=1

.meas tran SUM_td2 trig v(a) val='supply/2' rise=2
+targ v(sum) val='supply/2' fall=1

.meas tran SUM_td3 trig v(a) val='supply/2' fall=2
+targ v(sum) val='supply/2' rise=2

.meas tran SUM_td4 trig v(a) val='supply/2' rise=3
+targ v(sum) val='supply/2' fall=2

.meas tran SUM_td5 trig v(a) val='supply/2' rise=4
+targ v(sum) val='supply/2' rise=3

.meas tran SUM_td6 trig v(a) val='supply/2' fall=4
+targ v(sum) val='supply/2' fall=3

*Pro AC
.meas tran COUT_td1 trig v(a) val='supply/2' rise=2
+targ v(cout) val='supply/2' rise=1

.meas tran COUT_td2 trig v(a) val='supply/2' fall=2
+targ v(cout) val='supply/2' fall=1

.meas tran COUT_td3 trig v(a) val='supply/2' rise=3
+targ v(cout) val='supply/2' rise=2

.meas tran COUT_td4 trig v(a) val='supply/2' fall=4
+targ v(cout) val='supply/2' fall=2

*-----------------------------------------------------------------------------*
*Trs
.meas tran SUM_tr1 trig v(sum) val='supply*0.1' rise=1
+targ v(sum) val='supply*0.9' rise=1

.meas tran SUM_tr2 trig v(sum) val='supply*0.1' rise=2
+targ v(sum) val='supply*0.9' rise=2

.meas tran SUM_tr3 trig v(sum) val='supply*0.1' rise=3
+targ v(sum) val='supply*0.9' rise=3

*-----------------------------------------------------------------------------*
*Trf
.meas tran SUM_tf1 trig v(sum) val='supply*0.9' fall=1
+targ v(sum) val='supply*0.1' fall=1

.meas tran SUM_tf2 trig v(sum) val='supply*0.9' fall=2
+targ v(sum) val='supply*0.1' fall=2

.meas tran SUM_tf3 trig v(sum) val='supply*0.9' fall=3
+targ v(sum) val='supply*0.1' fall=3
*-----------------------------------------------------------------------------*
*Trc
.meas tran COUT_tr1 trig v(cout) val='supply*0.1' rise=1
+targ v(cout) val='supply*0.9' rise=1

.meas tran COUT_tr2 trig v(cout) val='supply*0.1' rise=2
+targ v(cout) val='supply*0.9' rise=2

*-----------------------------------------------------------------------------*
*Tfc
.meas tran COUT_tf1 trig v(cout) val='supply*0.9' fall=1
+targ v(cout) val='supply*0.1' fall=1

.meas tran COUT_tf2 trig v(cout) val='supply*0.9' fall=2
+targ v(cout) val='supply*0.1' fall=2

***-----------------------***
***        circuit        ***
***-----------------------***
Xfa A B CIN SUM COUT FA
Csum  SUM  GND load
Ccout COUT GND load

***-----------------------***
***      sub-circuit      ***
***-----------------------***
.subckt FA A B CIN SUM COUT
Xxor1  A   B   AxB  XOR1
Xxor2  CIN AxB SUM  XOR2
Xnand1 A   B   C1   NAND
Xnand2 CIN AxB C2   NAND
Xnand3 C1  C2  C3   NAND
Xbuff  c3 COUT BUFFER
.ends
*********************************************************
.subckt XOR1 A B OUT
M1 _a a GND GND N_18_G2 l=0.18u w=wnx1
M2 _a a VDD VDD P_18_G2 l=0.18u w=wpx1
M3 _b b GND GND N_18_G2 l=0.18u w=wnx1
M4 _b b VDD VDD P_18_G2 l=0.18u w=wpx1
M5 N003 b GND GND N_18_G2 l=0.18u w=wnx1
M6 OUT a N003 GND N_18_G2 l=0.18u w=wnx1
M7 OUT _a N004 GND N_18_G2 l=0.18u w=wnx1
M8 N004 _b GND GND N_18_G2 l=0.18u w=wnx1
M9 OUT _b N001 VDD P_18_G2 l=0.18u w=wpx1
M10 N001 a VDD VDD P_18_G2 l=0.18u w=wpx1
M11 N002 b VDD VDD P_18_G2 l=0.18u w=wpx1
M12 OUT _a N002 VDD P_18_G2 l=0.18u w=wpx1
.ends


*********************************************************
.subckt XOR2 A B OUT
M1 _a a GND GND N_18_G2 l=0.18u w=wnx2
M2 _a a VDD VDD P_18_G2 l=0.18u w=wpx2
M3 _b b GND GND N_18_G2 l=0.18u w=wnx2
M4 _b b VDD VDD P_18_G2 l=0.18u w=wpx2
M6 N004 a GND GND N_18_G2 l=0.18u w=wnx2
M8 N005 b GND GND N_18_G2 l=0.18u w=wnx2
M10 N001 a VDD VDD P_18_G2 l=0.18u w=wpx2
M12 N002 _a VDD VDD P_18_G2 l=0.18u w=wpx2
M5 N003 _b N004 GND N_18_G2 l=0.18u w=wnx2
M7 N003 _a N005 GND N_18_G2 l=0.18u w=wnx2
M9 N003 b N001 VDD P_18_G2 l=0.18u w=wpx2
M11 N003 _b N002 VDD P_18_G2 l=0.18u w=wpx2

M13 OUT N003 GND GND N_18_G2 l=0.18u w=wnxi2
M14 OUT N003 VDD VDD P_18_G2 l=0.18u w=wpxi2
.ends

********************************************************
.subckt BUFFER in OUT
M1 N001 in GND GND N_18_G2 l=0.18u w=wn
M2 N001 in VDD VDD P_18_G2 l=0.18u w=wp
M3 OUT N001 GND GND N_18_G2 l=0.18u w=wnb
M4 OUT N001 VDD VDD P_18_G2 l=0.18u w=wpb
.ends

.subckt NAND A B OUT
M3 out a VDD VDD P_18_G2 l=0.18u w=wpn
M4 out b VDD VDD P_18_G2 l=0.18u w=wpn
M2 out a N001 GND N_18_G2 l=0.18u w=wnn
M5 N001 b GND GND N_18_G2 l=0.18u w=wnn
.ends

.end