global  Pm f H E V X1 X2 X3
Pm = 0.80;  E = 1.17;  V = 1.0;
X1 = 0.65; X2 = 1.80; X3 = 0.8;
H = 5.0; f = 60; tf = 1; Dt = 0.01;
% (a)  Fault is cleared in 0.3 sec.
tc = 0.3;
swingmeu(Pm, E, V, X1, X2, X3, H, f, tc, tf, Dt)
% (b) Fault is cleared in 0.4 sec. and 0.5 sec.
tc = .5;
swingmeu(Pm, E, V, X1, X2, X3, H, f, tc, tf, Dt)
tc = .4;
swingmeu(Pm, E, V, X1, X2, X3, H, f, tc, tf, Dt)

disp('Parts (a) & (b) are repeated using swingrk4')
disp('Press Enter to continue')
pause
tc = 0.3;
swingrk4(Pm, E, V, X1, X2, X3, H, f, tc, tf)

tc = .5;
swingrk4(Pm, E, V, X1, X2, X3, H, f, tc, tf)
tc = .4;
swingrk4(Pm, E, V, X1, X2, X3, H, f, tc, tf)
