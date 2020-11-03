%Example 10.5
Z133 = j*0.22; Z033 = j*0.35; Zf = j*0.1;
disp('(a) Balanced three-phase fault at bus 3')
Ia3F = 1.0/(Z133+Zf)
disp('(b) Single line-to-ground fault at bus 3')
I03 = 1.0/(Z033 + 3*Zf + Z133 + Z133);
I012=[I03; I03; I03]
%sctm;
Iabc3 = sctm*I012
disp('(c) Line-to-line fault at bus 3')
I13 = 1.0/(Z133 + Z133 + Zf);
I012 = [0; I13; -I13]
Iabc3 = sctm*I012
disp('(b) Double line-to-ground fault at bus 3')
I13 = 1/(Z133 + Z133*(Z033+3*Zf)/(Z133+Z033+3*Zf));
I23 = -(1.0 - Z133*I13)/Z133;
I03 = -(1.0 - Z133*I13)/(Z033+3*Zf);
I012 = [I03; I13; I23]
Iabc3 = sctm*I012;
Iabc3p = rec2pol(Iabc3)
