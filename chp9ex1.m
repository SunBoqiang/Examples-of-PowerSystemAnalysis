z12 = j*.8; z13 = j*.4; z23 = j*.4;

Z33 = j*.34;
Zf = j*.16;
V0=[1; 1; 1];
I3F = V0(1)/(Z33+Zf)
IG1 = 0.6/(0.4+0.6)*I3F
IG2 = 0.4/(0.4+0.6)*I3F
DV1 = 0 - j*0.2*IG1;
DV2 = 0 - j*0.4*IG2;
DV3 = j*0.16*I3F - V0(3);
VF1 = V0(1) + DV1
VF2 = V0(2) + DV2
VF3 = V0(3) + DV3
I12 = (VF1 - VF2)/z12
I13 = (VF1 - VF3)/z13
I23 = (VF2 - VF3)/z23