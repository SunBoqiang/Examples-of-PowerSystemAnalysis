Zc=290.43; betal=0.3777;
VSLL=500;
VS=500/sqrt(3);
disp('(a)')
VRnl = VS/cos(betal);
VRnlLL=sqrt(3)*VRnl
disp('(b)')
XLsh=sin(betal)/(1-cos(betal))*Zc
QXL = VSLL^2/XLsh
