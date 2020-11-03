Ra=0; Xs = 9; Zs = Ra + j*Xs;
S = 40 + j*30; V = 30/sqrt(3);
Ia1 = conj(S)*1000/(3*conj(V));
Ia1M = abs(Ia1), Ia1ang=angle(Ia1)*180/pi
E1 = V + Zs*Ia1*0.001;
E1M = abs(E1), delta1 = angle(E1)*180/pi
disp('(b)')
P = 25;
delta2 = asin(P*Xs/(3*abs(E1)*V)); delta2d = delta2*180/pi
E2 = E1M*(cos(delta2) +j*sin(delta2));
Ia2 = (E2 - V)*1000/Zs; Ia2M = abs(Ia2), Ia2ang=angle(Ia2)*180/pi
PF = cos(angle(Ia2))
disp('(c)')
Pmax = 3 *E1M*V/Xs
E3 = E1M*(cos(pi/2) +j*sin(pi/2));
Ia3 = (E3 -V)*1000/Zs;
Ia3M = abs(Ia3), Ia3ang=angle(Ia3)*180/pi
PF = cos(angle(Ia3))
