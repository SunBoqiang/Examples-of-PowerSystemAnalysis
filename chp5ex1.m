VRLL=220; VR = VRLL/sqrt(3);
Z = (0.15+j*2*pi*60*1.3263e-3)*40;
disp('(a)')
SR=304.8+j*228.6;
IR = conj(SR)/(3*conj(VR)); IS = IR;
VS = VR + Z*IR;
VSLL = sqrt(3)*abs(VS)
SS = 3*VS*conj(IS)
REG = (VSLL - VRLL)/VRLL*100
Eff = real(SR)/real(SS)*100
disp('(b)')
SR=304.8-j*228.6;
IR = conj(SR)/(3*conj(VR)); IS = IR;
VS = VR + Z*IR;
VSLL = sqrt(3)*abs(VS)
SS = 3*VS*conj(IS)
REG = (VSLL - VRLL)/VRLL*100
Eff = real(SR)/real(SS)*100
