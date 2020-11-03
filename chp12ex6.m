num=500;
den=[1  33.5  307.5  775  500];
figure(1), rlocus(num, den);

kA= 10;
numc=kA*[25  500];
denc=[1  33.5  307.5  775  500+ 500*kA];
t=0:.05:20;
c=step(numc, denc, t);
figure(2), plot(t, c), xlabel('t, sec'), grid
timespec(numc, denc)
disp('(d) Open sim12ex6.mdl in SIMULINK WINDOW and click on simulation')
