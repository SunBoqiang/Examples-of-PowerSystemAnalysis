t0= 0;   tfinal = 3;              % time interval
x0 = [0, 0];                      % initial conditions
% [t,x] = ode23('mechsys', t0, tfinal, x0); % use with MATLAB 4
tspan = [t0, tfinal];                       % use with MATLAB 5
[t,x] = ode23('mechsys', tspan, x0);        % use with MATLAB 5
subplot(2,1,1),plot(t,x)
title('Time response of mechanical translational system')
xlabel('t,  sec')
text(2,1.2,'Displacement')
text(2,.2,'Velocity')
d= x(:,1);   v = x(:,2);
subplot(2,1,2), plot(d, v)
title('Velocity versus displacement ')
xlabel('Displacement')
subplot(111)
