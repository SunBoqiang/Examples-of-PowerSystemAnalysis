ZL = 0.95 + j*1.2667;
V4=10.45/11
Sm = 66.5/100*(0.8 - j*.6)
Im = conj(Sm)/conj(V4)
IL = V4/ZL
I = Im + IL
X11 = 0.45*0.9/(0.45+0.9);
V1 = V4+j*X11*I; V1M=abs(V1), V1ang=angle(V1)*180/pi
Eg = V1 + j*0.2*I;  EgM=abs(Eg), Egang=angle(Eg)*180/pi
Em = V4 - j*0.25*Im; EmM=abs(Em), Emang=angle(Em)*180/pi
