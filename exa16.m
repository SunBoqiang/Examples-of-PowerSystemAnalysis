wt = 0: 0.05: 3*pi;
v=120*sin(wt);                       % Sinusoidal voltage
i=100*sin(wt-pi/4);                  % Sinusoidal current
p=v.*i;                              % Instantaneous power

subplot(2, 2, 1),plot(wt,v, wt,i);       % Plot of v & i versus wt
title('Voltage & current')
xlabel('wt,  radians ');

subplot(2, 2, 2),plot(wt,p);          % Instantaneous power vs. wt
title('Power')
xlabel(' wt,  radians ');

Fm=3.0;
fa = Fm*sin(wt);                    % Three-phase mmf's fa, fb, fc
fb = Fm*sin(wt-2*pi/3);
fc = Fm*sin(wt-4*pi/3);
subplot(2, 2, 3),plot(wt,fa, wt,fb, wt,fc )
title('3-phase mmf');
xlabel(' wt,  radians ');
fR = 3/2*Fm;
subplot(2, 2, 4),plot(-fR*cos(wt),fR*sin(wt))
title('Rotating mmf')
subplot(111)
