L=0.97; C=0.0115; lngth=300; SR=800+j*600; VRLL = 500;
w=2*pi*60;
beta=w*sqrt(L*C*1e-9)
Zc = sqrt(L/C*1e3)
vel=1/sqrt(L*C*1e-9)
lambda=vel/60
betal=beta*lngth;
VR=VRLL/sqrt(3);
IR=conj(SR)/(3*conj(VR));
VS=cos(betal)*VR+j*Zc*sin(betal)*IR;
VSLL=sqrt(3)*abs(VS)
IS = j/Zc*sin(betal)*VR+cos(betal)*IR;
ISM=abs(IS)*1000
SS=3*VS*conj(IS)
A=abs(cos(betal));
REG=(VSLL/A - VRLL)/VRLL*100
