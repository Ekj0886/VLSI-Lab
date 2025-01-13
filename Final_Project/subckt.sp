* Encoder-v1
* .subckt ENCODER A B C S D
* M1 N003 B N008 GND N_18_G2 l=0.18u w=wn
* M2 N008 _C GND GND N_18_G2 l=0.18u w=wn
* M3 N003 _B N009 GND N_18_G2 l=0.18u w=wn
* M4 N009 C GND GND N_18_G2 l=0.18u w=wn
* M5 n1 _A N004 GND N_18_G2 l=0.18u w=wn
* M6 N004 B N006 GND N_18_G2 l=0.18u w=wn
* M7 N006 C GND GND N_18_G2 l=0.18u w=wn
* M8 n2 _C N005 GND N_18_G2 l=0.18u w=wn
* M9 N005 _B N007 GND N_18_G2 l=0.18u w=wn
* M10 N007 A GND GND N_18_G2 l=0.18u w=wn
* M11 D n1 N011 GND N_18_G2 l=0.18u w=wn
* M12 N011 n2 GND GND N_18_G2 l=0.18u w=wn
* M13 _A A GND GND N_18_G2 l=0.18u w=wn
* M14 _B B GND GND N_18_G2 l=0.18u w=wn
* M15 _C C GND GND N_18_G2 l=0.18u w=wn
* M16 N003 B N001 VDD P_18_G2 l=0.18u w=wp
* M17 N001 C VDD VDD P_18_G2 l=0.18u w=wp
* M18 N003 _B N002 VDD P_18_G2 l=0.18u w=wp
* M19 N002 _C VDD VDD P_18_G2 l=0.18u w=wp
* M20 n1 _A VDD VDD P_18_G2 l=0.18u w=wp
* M21 n1 B VDD VDD P_18_G2 l=0.18u w=wp
* M22 n1 C VDD VDD P_18_G2 l=0.18u w=wp
* M23 n2 A VDD VDD P_18_G2 l=0.18u w=wp
* M24 n2 _B VDD VDD P_18_G2 l=0.18u w=wp
* M25 n2 _C VDD VDD P_18_G2 l=0.18u w=wp
* M26 D n1 VDD VDD P_18_G2 l=0.18u w=wp
* M27 D n2 VDD VDD P_18_G2 l=0.18u w=wp
* M28 _A A VDD VDD P_18_G2 l=0.18u w=wp
* M29 _B B VDD VDD P_18_G2 l=0.18u w=wp
* M30 _C C VDD VDD P_18_G2 l=0.18u w=wp
* M31 S N003 GND GND N_18_G2 l=0.18u w=wn
* M32 S N003 VDD VDD P_18_G2 l=0.18u w=wp  
* .ends

*Encoder-v2
* .subckt ENCODER A B C S D
* M1 N005 B N008 GND N_18_G2 l=0.18u w=wn
* M2 N008 _C GND GND N_18_G2 l=0.18u w=wn
* M3 N005 _B N009 GND N_18_G2 l=0.18u w=wn
* M4 N009 C GND GND N_18_G2 l=0.18u w=wn
* M5 N002 _A N006 GND N_18_G2 l=0.18u w=wn
* M6 N006 B N010 GND N_18_G2 l=0.18u w=wn
* M7 N010 C GND GND N_18_G2 l=0.18u w=wn
* M8 N002 _C N007 GND N_18_G2 l=0.18u w=wn
* M9 N007 _B N011 GND N_18_G2 l=0.18u w=wn
* M10 N011 A GND GND N_18_G2 l=0.18u w=wn
* M11 _A A GND GND N_18_G2 l=0.18u w=wn
* M12 _B B GND GND N_18_G2 l=0.18u w=wn
* M13 _C C GND GND N_18_G2 l=0.18u w=wn
* M14 N005 B N003 VDD P_18_G2 l=0.18u w=wp
* M15 N003 C VDD VDD P_18_G2 l=0.18u w=wp
* M16 N005 _B N004 VDD P_18_G2 l=0.18u w=wp
* M17 N004 _C VDD VDD P_18_G2 l=0.18u w=wp
* M18 N001 _A VDD VDD P_18_G2 l=0.18u w=wp
* M19 N001 B VDD VDD P_18_G2 l=0.18u w=wp
* M20 N001 C VDD VDD P_18_G2 l=0.18u w=wp
* M21 N002 A N001 VDD P_18_G2 l=0.18u w=wp
* M22 N002 _B N001 VDD P_18_G2 l=0.18u w=wp
* M23 N002 _C N001 VDD P_18_G2 l=0.18u w=wp
* M24 _A A VDD VDD P_18_G2 l=0.18u w=wp
* M25 _B B VDD VDD P_18_G2 l=0.18u w=wp
* M26 _C C VDD VDD P_18_G2 l=0.18u w=wp

* M27 S N005 GND GND N_18_G2 l=0.18u w=wn
* M28 S N005 VDD VDD P_18_G2 l=0.18u w=0.88u
* M29 D N002 GND GND N_18_G2 l=0.18u w=wn
* M30 D N002 VDD VDD P_18_G2 l=0.18u w=0.88u
* .ends

*8T XOR
* .subckt XOR A B OUT
* M1 OUT B N003 GND N_18_G2 l=0.18u w=wn
* M2 N003 _A GND GND N_18_G2 l=0.18u w=wn
* M3 OUT _B N004 GND N_18_G2 l=0.18u w=wn
* M4 N004 A GND GND N_18_G2 l=0.18u w=wn
* M5 OUT B N001 VDD P_18_G2 l=0.18u w=wp
* M6 N001 A VDD VDD P_18_G2 l=0.18u w=wp
* M7 OUT _B N002 VDD P_18_G2 l=0.18u w=wp
* M8 N002 _A VDD VDD P_18_G2 l=0.18u w=wp
* M11 _A A GND GND N_18_G2 l=0.18u w=wn
* M12 _B B GND GND N_18_G2 l=0.18u w=wn
* M13 _A A VDD VDD P_18_G2 l=0.18u w=wp
* M14 _B B VDD VDD P_18_G2 l=0.18u w=wp
* .ends


*10T XOR
* .subckt XOR A B OUT
* M1 N003 B N004 GND N_18_G2 l=0.18u w=w1
* M2 N004 A GND GND N_18_G2 l=0.18u w=w1
* M3 N003 _B N005 GND N_18_G2 l=0.18u w=w1
* M4 N005 _A GND GND N_18_G2 l=0.18u w=w1
* M5 N003 B N001 VDD P_18_G2 l=0.18u w=w2
* M6 N001 _A VDD VDD P_18_G2 l=0.18u w=w2
* M7 N003 _B N002 VDD P_18_G2 l=0.18u w=w2
* M8 N002 A VDD VDD P_18_G2 l=0.18u w=w2
* M9 OUT N003 GND GND N_18_G2 l=0.18u w=w1
* M10 OUT N003 VDD VDD P_18_G2 l=0.18u w=w2
* M11 _A A GND GND N_18_G2 l=0.18u w=w1
* M12 _B B GND GND N_18_G2 l=0.18u w=w1
* M13 _A A VDD VDD P_18_G2 l=0.18u w=w2
* M14 _B B VDD VDD P_18_G2 l=0.18u w=w2
* .ends