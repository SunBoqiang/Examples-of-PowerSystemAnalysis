% This program called by im produces the torque/speed curve
% for an induction motor.
%
% Copyright (C) 1998 by H. Saadat

slip1 = Smax:-.005:.0001;
if Smax > 1, Smax =1;else,end
slip2 = 1:-.005:Smax;
slip=[slip2, slip1];
np1 = length(slip1);
np2 = length(slip2);
R2d1 = R2./slip1;
R2d2 = R2./slip2;
Z2d1=R2d1+ j*X2*ones(1,np1);
Z2d2=R2d2+ j*X2*ones(1,np2);
I2d1 = Vth./(Zth*ones(1,np1)+Z2d1);
I2d2 = Vth./(Zth*ones(1,np2)+Z2d2);
Pgd1 = 3*R2d1.*abs(I2d1).^2;
Pgd2 = 3*R2d2.*abs(I2d2).^2;
Tdev1 = Pgd1/Ws;
Tdev2 = Pgd2/Ws;
nr1 = Ns*(ones(1,np1)-slip1);
nr2 = Ns*(ones(1,np2)-slip2);
if length(nr2) > 4
   x1= 1.7*nr2(4);
   else x1 = 1.7*nr1(2); end
y1 = 0.86*Tst;
x2 = 0.96*(1- Smax)*Ns; y2 = 0.89*Tmax;
x3 = 0.95*Nr;  y3 =0.93*Td;
fy = 0:Td/20:Td; nf=length(fy);
fx = ones(1,nf)*Nr;
figure
plot(nr1, Tdev1, '-g', nr2, Tdev2, 'r', fx, fy,'b'),grid
xlabel('Rotor speed - rpm')
ylabel('Developed Torque  Nm')
title('Motor torque-speed curve')
text(x1, y1, 'Ts')
text(x2, y2, 'Tmax')
if Nr ~= 0
  text(x3, y3, 'Td')
else, end
