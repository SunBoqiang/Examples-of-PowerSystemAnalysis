fprintf('\n Wait simulation is in process. \n')
VF = 400; rF = 0.4; iF0 = VF/rF;
f = 60;    w = 2.*pi*f;
d = 0;     d = d*pi/180;
t0 = 0 ; tfinal = 0.80;
i0 = [0; iF0; 0; 0;];           % Initial currents
%[t,i] = ode45('lgshort', t0, tfinal, i0);         % use for MATLAB 4
tspan = [t0, tfinal];                              % use for MATLAB 5
[t,i] = ode45('lgshort', tspan, i0);               % use for MATLAB 5
ia=i(:,1);  iF=i(:,2);    % ib = Armature current  iF=Field current
figure(1), plot(t,ia), xlabel('t, sec'), ylabel('ia, A'), grid
title(['Line-ground short circuit  ia,  ','delta = ', num2str(d)])
figure(2), plot(t,iF), xlabel('t, sec'), ylabel('iF, A'), grid
title(['Line-ground short circuit  iF,  ','delta = ',num2str(d)])
