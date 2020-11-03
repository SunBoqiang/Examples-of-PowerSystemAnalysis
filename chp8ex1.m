gamma=88.1*pi/180;
alpha1=88.1*pi/180;
alpha2=1.9*pi/180;
t=0:.001:.3;
i1=40*sin(377*t+alpha1 -gamma)-40*exp(-t/.08).*sin(alpha1-gamma);
i2=40*sin(377*t+alpha2 -gamma)-40*exp(-t/.08).*sin(alpha2-gamma);
subplot(2,1,1), plot(t, i1), grid
xlabel('t, sec'), ylabel('i(t)')
subplot(2,1,2), plot(t, i2), grid
xlabel('t, sec'), ylabel('i(t)')
subplot(111);
