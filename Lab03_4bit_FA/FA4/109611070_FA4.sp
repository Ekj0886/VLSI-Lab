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
M1 _COUT B N004 0 N_18_G2 l=0.18u w=w2
M2 N004 A 0 0 N_18_G2 l=0.18u w=w2
M3 N002 A 0 0 N_18_G2 l=0.18u w=w2
M4 N002 B 0 0 N_18_G2 l=0.18u w=w2
M5 _COUT CIN N002 0 N_18_G2 l=0.18u w=w2
M6 _SUM _COUT N003 0 N_18_G2 l=0.18u w=w2
M7 N003 A 0 0 N_18_G2 l=0.18u w=w2
M8 N003 B 0 0 N_18_G2 l=0.18u w=w2
M9 N003 CIN 0 0 N_18_G2 l=0.18u w=w2
M10 _SUM CIN N001 0 N_18_G2 l=0.18u w=w2
M11 N001 B N005 0 N_18_G2 l=0.18u w=w2
M12 N005 A 0 0 N_18_G2 l=0.18u w=w2
M14 COUT _COUT 0 0 N_18_G2 l=0.18u w=w1
M16 COUT _COUT VDD VDD P_18_G2 l=0.18u w=w2
M17 _SUM 0 VDD VDD P_18_G2 l=0.18u w=w1
M18 _COUT 0 VDD VDD P_18_G2 l=0.18u w=w1
.ends

.subckt FA2 A B CIN _SUM _COUT
M1 _COUT B N004 0 N_18_G2 l=0.18u w=w2
M2 N004 A 0 0 N_18_G2 l=0.18u w=w2
M3 N002 A 0 0 N_18_G2 l=0.18u w=w2
M4 N002 B 0 0 N_18_G2 l=0.18u w=w2
M5 _COUT CIN N002 0 N_18_G2 l=0.18u w=w2
M6 _SUM _COUT N003 0 N_18_G2 l=0.18u w=w2
M7 N003 A 0 0 N_18_G2 l=0.18u w=w2
M8 N003 B 0 0 N_18_G2 l=0.18u w=w2
M9 N003 CIN 0 0 N_18_G2 l=0.18u w=w2
M10 _SUM CIN N001 0 N_18_G2 l=0.18u w=w2
M11 N001 B N005 0 N_18_G2 l=0.18u w=w2
M12 N005 A 0 0 N_18_G2 l=0.18u w=w2
M15 _SUM 0 VDD VDD P_18_G2 l=0.18u w=w1
M16 _COUT 0 VDD VDD P_18_G2 l=0.18u w=w1
.ends

.subckt CLA A[0] A[1] A[2] B[0] B[1] B[2] Cin Cin3
M1 N001 B[2] N005 0 N_18_G2 l=0.18u w=w2
M2 N005 A[2] 0 0 N_18_G2 l=0.18u w=w2
M3 N001 B[2] N002 0 N_18_G2 l=0.18u w=w2
M4 N002 B[1] N006 0 N_18_G2 l=0.18u w=w2
M5 N006 A[1] 0 0 N_18_G2 l=0.18u w=w2
M6 N002 B[1] N003 0 N_18_G2 l=0.18u w=w2
M7 N003 B[0] N007 0 N_18_G2 l=0.18u w=w2
M8 N007 A[0] 0 0 N_18_G2 l=0.18u w=w2
M9 N004 B[0] 0 0 N_18_G2 l=0.18u w=w2
M10 N001 A[2] N002 0 N_18_G2 l=0.18u w=w2
M11 N002 A[1] N003 0 N_18_G2 l=0.18u w=w2
M12 N003 Cin N004 0 N_18_G2 l=0.18u w=w2
M13 N004 A[0] 0 0 N_18_G2 l=0.18u w=w2
M14 Cin3 N001 0 0 N_18_G2 l=0.18u w=w1
M15 N001 0 VDD VDD P_18_G2 l=0.18u w=w1
M28 Cin3 N001 VDD VDD P_18_G2 l=0.18u w=w2
.ends


.subckt DFF D CLK Q
M1 N003 D 0 0 N_18_G2 l=0.18u w=w1
M3 N001 N003 0 0 N_18_G2 l=0.18u w=w1
M4 N002 CLK N003 0 N_18_G2 l=0.18u w=w1
M11 Q N001 0 0 N_18_G2 l=0.18u w=w1
M7 N002 D VDD VDD P_18_G2 l=0.18u w=w2
M10 Q N001 VDD VDD P_18_G2 l=0.18u w=w2
M2 N001 N002 VDD VDD P_18_G2 l=0.18u w=w2
.ends

.end
