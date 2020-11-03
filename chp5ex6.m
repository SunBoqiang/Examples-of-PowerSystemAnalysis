VS=1.0; VR=0.9; lambda=5000; Zc=320; delta=36.87*pi/180; P=700; lngth=315;
betal=2*pi/lambda*lngth
SIL=P*sin(betal)/(VS*VR*sin(delta))
KVL = sqrt(Zc*SIL)
disp('(b)')
Xd=Zc*sin(betal)
Pmax=KVL*0.9*KVL/Xd
