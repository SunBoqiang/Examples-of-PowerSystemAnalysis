numc=250*[1 45 500];
denc=[1  58.5  13645  270962.5  274875 137500];
t=0:.05:10;
c=step(numc, denc, t);
figure(2), plot(t, c), grid
xlabel('t, sec'), title('Terminal voltage step response')
timespec(numc, denc)
disp('(b) Open sim12ex7.mdl in SIMULINK WINDOW and click on simulation')
