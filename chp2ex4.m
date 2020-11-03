V = 1400;
S1= 35000 + j*120000; S2 = 10000 - j*40000; S3 = 15000;
S = S1 + S2 + S3, P = real(S); Q = imag(S);
PF = cos(angle(S))
I = conj(S)/conj(V)
thd = acos(0.8), Qd = P*tan(thd)
Sc = -j*(Q - Qd)
Zc = V^2/conj(Sc), C = 1/(2*pi*60*abs(Zc))
Sd = P + j*Qd;
Id=conj(Sd)/conj(V)
