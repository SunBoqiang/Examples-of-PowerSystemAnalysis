disp('Example 12.1 (b)  Root-locus')
num = 1;
den = [1  7.08  10.56 .8];
figure (1), rlocus(num, den)
disp('Example 12.1 (c)  Frequency deviation step response')
PL = 0.2;
numc = [0.1  0.7  1];
denc = [1   7.08  10.56  20.8];
t = 0:.02:10;
c = -PL*step(numc, denc, t);
figure(2), plot(t, c), grid
xlabel('t, sec'), ylabel('pu')
title('Frequency deviation step response')
timespec(numc, denc)
