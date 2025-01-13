***------------------------------------***
***          VLSI 2022 Lab1            ***
***            Full Adder              ***
***            student ID:             ***
***------------------------------------***  
.title vlsi Lab1_FA

***-----------------------***
***        setting        ***
***-----------------------***
.lib "umc018.l" L18U18V_TT 
.options post
.options brief
.Temp    25

***-----------------------***
***      parameters       ***
***-----------------------***
.global VDD GND
.param supply = 1.8V
.param load = 10f

.param wp = 0.48u
.param wn = 0.24u

***-----------------------***
***       simulation      ***
***-----------------------***
.tran 0.1n 22n

***-----------------------***
***      measurements     ***
***-----------------------***
.meas tran avg_power avg power from 0.1n to 18n

.meas tran tprop trig v(a) val='supply/2' rise=2
+targ v(dcout) val='supply/2' rise=1

.meas tran tr trig v(dcout) val='supply*0.1' rise=1
+targ v(dcout) val='supply*0.9' rise=1

.meas tran tf trig v(dcout) val='supply*0.9' fall=1
+targ v(dcout) val='supply*0.1' fall=1

***-----------------------***
***      power/input      ***
***-----------------------***
Vd1 VDD GND supply 
VCLK CLK GND pulse(0 supply 2ns 0.1ns 0.1ns 0.9ns 2ns )
Vda A   GND pwl(0n 0v, 3n 0v, 3.1n supply, 5n supply, 5.1n 0v, 7n 0v, 7.1n supply, 9n supply, 9.1n 0v, 11n 0v, 11.1n supply, 13n supply, 13.1n 0v, 15n 0v, 15.1n supply, 17n supply, 17.1n 0v, 18n 0v)
Vdb B   GND pwl(0n 0v, 5n 0v, 5.1n supply, 9n supply, 9.1n 0v, 13n 0v, 13.1n supply, 17n supply, 17.1n 0v, 18n 0v)
Vdc CIN GND pwl(0n 0v, 9n 0v, 9.1n supply, 17n supply, 17.1n 0v, 18n 0v)

***-----------------------***
***        circuit        ***
***-----------------------***
XFA       A    B   CIN   SUM COUT FA
XDFFsum   SUM  CLK DSUM  DFF
XDFFcout  COUT CLK DCOUT DFF
Ccout     DCOUT GND load
Csum      DSUM  GND load

***-----------------------***
***      sub-circuit      ***
***-----------------------***
.subckt FA A B CIN SUM COUT
M1 _COUT A N008 N008 N_18_G2 l=0.18u w=wn
M2 N008 B GND GND N_18_G2 l=0.18u w=wn
M3 _COUT CIN N006 N006 N_18_G2 l=0.18u w=wn
M4 N006 A GND GND N_18_G2 l=0.18u w=wn
M5 N006 B GND GND N_18_G2 l=0.18u w=wn
M6 _COUT A N003 N003 P_18_G2 l=0.18u w=wp
M7 N003 B VDD VDD P_18_G2 l=0.18u w=wp
M8 _COUT CIN N001 N001 P_18_G2 l=0.18u w=wp
M9 N001 A VDD VDD P_18_G2 l=0.18u w=wp
M10 N001 B VDD VDD P_18_G2 l=0.18u w=wp
M11 N004 _COUT N002 N002 P_18_G2 l=0.18u w=wp
M12 N004 _COUT N007 N007 N_18_G2 l=0.18u w=wn
M13 N007 A GND GND N_18_G2 l=0.18u w=wn
M14 N007 B GND GND N_18_G2 l=0.18u w=wn
M15 N007 CIN GND GND N_18_G2 l=0.18u w=wn
M16 N002 B VDD VDD P_18_G2 l=0.18u w=wp
M17 N002 CIN VDD VDD P_18_G2 l=0.18u w=wp
M18 N002 A VDD VDD P_18_G2 l=0.18u w=wp
M19 N004 A N005 N005 N_18_G2 l=0.18u w=wn
M20 N005 B N009 N009 N_18_G2 l=0.18u w=wn
M21 N009 CIN GND GND N_18_G2 l=0.18u w=wn
M22 N004 CIN P001 P001 P_18_G2 l=0.18u w=wp
M23 P001 B P002 P002 P_18_G2 l=0.18u w=wp
M24 P002 A VDD VDD P_18_G2 l=0.18u w=wp
M25 SUM N004 VDD VDD P_18_G2 l=0.18u w=wp
M26 SUM N004 GND GND N_18_G2 l=0.18u w=wn
M27 COUT _COUT VDD VDD P_18_G2 l=0.18u w=wp
M28 COUT _COUT GND GND N_18_G2 l=0.18u w=wn
.ends

.subckt DFF D CLK Q
M1 N004 D GND GND N_18_G2 l=0.18u w=wn
M2 N004 _CLK N002 N002 N_18_G2 l=0.18u w=wn
M11 N004 D VDD VDD P_18_G2 l=0.18u w=wp
M12 N002 CLK N004 N004 P_18_G2 l=0.18u w=wp
M19 N005 N002 GND GND N_18_G2 l=0.18u w=wn
M20 N005 N002 VDD VDD P_18_G2 l=0.18u w=wp
M21 N002 CLK P001 P001 N_18_G2 l=0.18u w=wn
M22 P001 N005 GND GND N_18_G2 l=0.18u w=wn
M23 N002 _CLK P002 P002 P_18_G2 l=0.18u w=wp
M24 P002 N005 VDD VDD P_18_G2 l=0.18u w=wp
M25 N005 CLK N001 N001 N_18_G2 l=0.18u w=wn
M26 N001 _CLK N005 N005 P_18_G2 l=0.18u w=wp
M27 _Q N001 GND GND N_18_G2 l=0.18u w=wn
M28 _Q N001 VDD VDD P_18_G2 l=0.18u w=wp
M3 N003 N001 GND GND N_18_G2 l=0.18u w=wn
M6 N003 N001 VDD VDD P_18_G2 l=0.18u w=wp
M7 N001 _CLK P003 P003 N_18_G2 l=0.18u w=wn
M8 P003 N003 GND GND N_18_G2 l=0.18u w=wn
M9 N001 CLK P004 P004 P_18_G2 l=0.18u w=wp
M10 P004 N003 VDD VDD P_18_G2 l=0.18u w=wp
M15 Q N003 GND GND N_18_G2 l=0.18u w=wn
M16 Q N003 VDD VDD P_18_G2 l=0.18u w=wp
M4 _CLK CLK GND GND N_18_G2 l=0.18u w=wn
M5 _CLK CLK VDD VDD P_18_G2 l=0.18u w=wp
.ends

.alter 1
.param wp   = 0.24u
.param wn   = 0.12u
.param load = 10f

.alter 2
.param wp   = 0.36u
.param wn   = 0.18u
.param load = 10f

.alter 3
.param wp   = 0.48u
.param wn   = 0.24u
.param load = 10f

.end

