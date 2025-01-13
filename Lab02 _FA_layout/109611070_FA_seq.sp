.title vlsi_Lab02_FA_seq
***-----------------------***
***        setting        ***
***-----------------------***
.lib "umc018.l" L18U18V_TT
.options post
.options brief

.global VDD GND
.param supply = 1.8v
.param load = 10f

*-------------------------------
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
*---------------------------------
.param wpd = 0.94u
.param wnd = 0.44u
***-----------------------***
***       simulation      ***
***-----------------------***
.tran 0.1n 40n

***-----------------------***
***      power/input      ***
***-----------------------***
Vd VDD  GND supply

Vda  A   GND pulse(0v, supply, 3n, 0.1n, 0.1n, 1.9n, 4n)
Vdb  B   GND pulse(0v, supply, 5n, 0.1n, 0.1n, 3.9n, 8n)
Vdc  CIN GND pulse(0v, supply, 9n, 0.1n, 0.1n, 7.9n, 16n)
Vclk CLK GND pulse(0v, supply, 2n, 0.1n, 0.1n, 0.9n, 2n)


***-----------------------***
***        circuit        ***
***-----------------------***
Xfaq A B CIN CLK DSUM DCOUT FA_seq
Csum  DSUM  GND load
Ccout DCOUT GND load

***-----------------------***
***      sub-circuit      ***
***-----------------------***
.subckt FA_seq A B CIN CLK DSUM DCOUT 
Xxor1  A   B   AxB  XOR1
Xxor2  CIN AxB SUM  XOR2
Xnand1 A   B   C1   NAND
Xnand2 CIN AxB C2   NAND
Xnand3 C1  C2  C3 NAND
Xbuff  c3 COUT BUFFER
Xds SUM  CLK DSUM  DFF
Xdc COUT CLK DCOUT DFF
.ends

*-----------------------------------------------------------------------------*
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


*-----------------------------------------------------------------------------*
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


*-----------------------------------------------------------------------------*
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
*-----------------------------------------------------------------------------*
.subckt DFF D CLK Q
M1 N004 D GND GND N_18_G2 l=0.18u w=wnd
M2 N005 CLK GND GND N_18_G2 l=0.18u w=wnd
M3 N001 N004 N005 GND N_18_G2 l=0.18u w=wnd
M4 N006 N001 GND GND N_18_G2 l=0.18u w=wnd
M5 N002 CLK N006 GND N_18_G2 l=0.18u w=wnd
M6 N004 CLK N003 VDD P_18_G2 l=0.18u w=wpd
M7 N003 D VDD VDD P_18_G2 l=0.18u w=wpd
M8 N001 CLK VDD VDD P_18_G2 l=0.18u w=wpd
M9 N002 N001 VDD VDD P_18_G2 l=0.18u w=wpd
M10 Q N002 VDD VDD P_18_G2 l=0.18u w=wpd
M11 Q N002 GND GND N_18_G2 l=0.18u w=wnd
.ends

.end