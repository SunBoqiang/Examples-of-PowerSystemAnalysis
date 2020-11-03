Xd1d = 0.25; Xt = 0.2;
V = 1.0;
SL= 0.8 + j*0.6;
ZL = V^2/conj(SL);
IL = V/ZL;
Vth = 1.0;
Zth = j*(Xd1d + Xt);
I1df = Vth/Zth
Ig1d = I1df + IL
Ig1dM = abs(Ig1d), Idang = angle(Ig1d)*180/pi
