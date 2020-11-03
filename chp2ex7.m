V1 = 207.85/sqrt(3);
Zl = 2 + j*4; Z1 = 30 + j*40;
Z2 = (60-j*45)/3;
Z = Zl + Z1*Z2/(Z1+Z2);
I=V1/Z, S=3*V1*conj(I)
V2 = V1- Zl*I
V2ab =sqrt(3)*(cos(pi/6)+j*sin(pi/6))*V2
I1=V2/Z1, I2=V2/Z2
Iab=I2/(sqrt(3)*(cos(pi/6)-j*sin(pi/6)))
S1=3*V2*conj(I1), S2=3*V2*conj(I2)
SL = 3*Zl*abs(I)^2
