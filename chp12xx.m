PL = 0.2;
A = [-5  0  -100; 2  -2  0; 0  0.1  -0.08];
B = [0;  0;  -0.1]; BPL = B*PL;
C = [0  0  1];  D = 0;
disp('(a)')
t=0:0.02:10;
[y, x] = step(A, BPL, C, D, 1, t);
figure(1), plot(t, y), grid
xlabel('t, sec'), ylabel('pu')
r =eig(A)
disp('(b) Open sim12xxb.mdl in SIMULINK WINDOW and click on simulation')
disp(' ')
disp('(c) Pole-placement design')
P=[-2.0+j*6   -2.0-j*6   -3];
[K, Af] = placepol(A, B, C, P);
t=0:0.02:4;
[y, x] = step(Af, BPL, C, D, 1, t);
figure(2), plot(t, y), grid
xlabel('t, sec'), ylabel('pu')
disp('(d) Open sim12xxd.mdl in SIMULINK WINDOW and click on simulation')
