Ra=0; Xs = 9; Zs = Ra + j*Xs;
 V = 30/sqrt(3); P = 40;
E1M = 0.792*23.558;
delta1 = asin(P*Xs/(3*abs(E1M)*V)); delta1d = delta1*180/pi
E1 = E1M*(cos(delta1) +j*sin(delta1));
Ia1 = (E1 - V)*1000/Zs; Ia1M = abs(Ia1), Ia1ang=angle(Ia1)*180/pi
PF = 1
disp('(b)')
E2M = 0.5925*23.558;
delta2 = asin(P*Xs/(3*E2M*V)); delta2d = delta2*180/pi
E2 = E2M*(cos(delta2) +j*sin(delta2));
Ia2 = (E2 - V)*1000/Zs; Ia2M = abs(Ia2), Ia2ang=angle(Ia2)*180/pi
PF = cos(angle(Ia2))
disp('(c)')
E3M = P *Xs/(3*V*1)
E3=E3M*(cos(pi/2)+j*sin(pi/2));
Ia3 = (E3 -V)*1000/Zs;
Ia3M = abs(Ia3), Ia3ang=angle(Ia3)*180/pi
PF = cos(angle(Ia3))
