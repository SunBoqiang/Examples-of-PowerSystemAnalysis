Xd = 1.0; Xd1d = 0.25; Xd2d = 0.12; Xt = 0.2;
SB = 100; VL1 = 13.8; VL2 = 220;
IB1 = SB*1000/(sqrt(3)*VL1);
IB2 = VL1/VL2*IB1;
Id2d = 1.0/(Xd2d+Xt)
Id1d = 1.0/(Xd1d+Xt)
Id   = 1.0/(Xd+Xt)
Iasy = sqrt(3)*Id2d
t=0:.02:6;
it = sqrt(2)*( (Id2d-Id1d)*exp(-t/0.4) + (Id1d-Id)*exp(-t/1.1)+Id ).*sin(377*t+pi/2)+...
     sqrt(2)*Id2d*exp(-t/0.25);
plot(t, it), grid
xlabel('t, sec'), ylabel('i, A')
title('Short circuit current including dc component')
