V2 = 3810.5/sqrt(3);
Zl = 0.4 +j*2.7;
S1 = 560.1*(cos(pi/4) + j*sin(pi/4)); S2 = 132;
SR = S1+ S2
I = conj(SR)*1000/(3*conj(V2))
V1 = V2 + Zl*I
V1L = sqrt(3)*abs(V1)
SL = 3*Zl*abs(I)^2/1000
SS = 3 *V1*conj(I)/1000
SS = SR + SL
