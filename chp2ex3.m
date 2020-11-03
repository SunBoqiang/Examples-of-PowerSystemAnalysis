V = 200; Z1= 100; Z2 = 10 + j*20;
I1 = V/Z1; I2 = V/Z2;
S1= V*conj(I1), S2= V*conj(I2)
I = I1 + I2
S = S1 + S2, P = real(S); Q = imag(S);
PF = cos(angle(S))
thd = acos(0.8), Qd = P*tan(thd)
Sc = -j*(Q - Qd)
Zc = V^2/conj(Sc), C = 1/(2*pi*60*abs(Zc))
Sd = P + j*Qd;
Id=conj(Sd)/conj(V)
