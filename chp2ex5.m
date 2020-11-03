R = 1; X = 7; Z = R +j*X;
V1 = 120*(cos(-5*pi/180) + j*sin(-5*pi/180));
V2 = 100+j*0;
I12 = (V1 - V2)/Z, I21 = -I12;
S12 = V1*conj(I12), S21 = V2*conj(I21)
SL = S12 + S21
PL = R*abs(I12)^2, QL = X*abs(I12)^2
