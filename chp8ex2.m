fprintf('\n Wait simulation is in process. \n')
VF = 400; rF = 0.4; iF0 = VF/rF;
f = 60;  w=2.*pi*f;
d = 0;   d=d*pi/180;
t0 = 0 ; tfinal = 0.80;
i0 = [0; iF0; 0; 0; 0 ];        % Initial currents
%[t,i] = ode45('symshort',t0,tfinal,i0);          % use for MATLAB 4
tspan = [t0, tfinal];                             % use for MATLAB 5
[t, i] = ode45('symshort', tspan, i0);            % use for MATLAB 5
theta = w*t+d +pi/2;
ia = sqrt(2/3)*(cos(theta).*i(:,1)+sin(theta).*i(:,4));
ib = sqrt(2/3)*(cos(theta-2*pi/3).*i(:,1)+sin(theta-2*pi/3).*i(:,4));
ic = sqrt(2/3)*(cos(theta+2*pi/3).*i(:,1)+sin(theta+2*pi/3).*i(:,4));
iF = i(:,2);    % ia = Armature current  iF=Field current
figure(1), plot(t,ia), xlabel('t, sec'), ylabel('ia, A'), grid
title(['Three-phase short circuit  ia,  ','delta = ', num2str(d)])
figure(2), plot(t,ib), xlabel('t, sec'), ylabel('ib, A'), grid
title(['Three-phase short circuit  ib,  ','delta = ', num2str(d)])
figure(3), plot(t,ic), xlabel('t, sec'), ylabel('i c, A'), grid
title(['Three-phase short circuit  ic,  ','delta = ', num2str(d)])
figure(4), plot(t,iF), xlabel('t, sec'), ylabel('iF, A'), grid
title(['Three-phase short circuit iF, ','delta = ',num2str(d)])
