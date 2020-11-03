PL = 0.2;
KI = 7;
numc = [0.1  0.7  1 0];
denc = [1   7.08  10.56  20.8 KI];
t = 0:.02:12;
c=-PL*step(numc, denc, t);
plot(t, c), grid
xlabel('t, sec'), ylabel('pu')
title('Frequency deviation step response')
