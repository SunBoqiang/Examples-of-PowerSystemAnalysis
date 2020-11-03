t0= 0;   tfinal =15;              % time interval
x0 = [0.5, 0];                    % initial conditions
% [t,x] = ode23('electsys', t0, tfinal, x0);    % use with MATLAB 4
tspan = [t0, tfinal];                           % use with MATLAB 5
[t,x] = ode23('electsys', tspan, x0);           % use with MATLAB 5
subplot(2,1,1),plot(t,x)
title('Time response of an RLC series circuit')
xlabel('t, sec')
text(8,1.15,'Capacitor voltage')
text(8, 0.1,'Current')
vc= x(:,1);   i = x(:,2);
subplot(2,1,2),plot(vc, i)
title('Current versus capacitor voltage ')
xlabel('Capacitor voltage')
subplot(111)
