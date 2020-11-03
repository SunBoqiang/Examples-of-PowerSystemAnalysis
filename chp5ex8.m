PR=800; QR=600; SR=PR+j*QR; VRLL=500;
Zc=290.43; betal=0.3777;
disp('(a)')
Xd=Zc*sin(betal);
delta=asin((PR*Xd)/(VRLL^2))
QR2=VRLL^2/Xd*cos(delta)-VRLL^2/Xd*cos(betal)
Sc=j*QR2-j*QR
Xc=VRLL^2/conj(Sc)
C=1/(2*pi*60*abs(Xc))
disp('(b)')
Xser = .4*Xd;
Zd = j*(Xd-Xser); B = Zd 
Yd = j*2/Zc*tan(betal/2); A = 1+Zd*Yd/2 
VR = VRLL/sqrt(3);
IR = conj(SR)/(3*VR)
VS = A*VR + B*IR
VSLL = sqrt(3)*abs(VS)
Reg = (VSLL/abs(A) - VRLL)/VRLL*100