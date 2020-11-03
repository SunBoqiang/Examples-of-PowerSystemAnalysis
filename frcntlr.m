function  [a1,b1]=frcntlr(num, den, w1, a0,pm)
[M, si]=bode(num,den,w1);
th=-180+pm-si; thpi=th*pi/180;
a1=(1-a0*M*cos(thpi))/(w1*M*sin(thpi));
b1=(cos(thpi)-a0*M)/(w1*sin(thpi));
[a1, b1];
