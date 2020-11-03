Xd1d = 0.25; Xt = 0.2;
SL = 0.8 + j*.6; V = 1.0;
ZL = V^2/conj(SL);
IL = V/ZL;
E1d = V + j*(Xd1d+Xt)*IL;
E1dM = abs(E1d), E1ang = angle(E1d)*180/pi
Ig1d = E1d/(j*Xd1d+j*Xt);
Ig1dM = abs(Ig1d), Idang = angle(Ig1d)*180/pi
