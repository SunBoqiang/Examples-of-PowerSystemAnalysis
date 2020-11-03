Vm = 100; thetav = 0;         % Voltage amplitude and phase angle
Z = 1.25;  gama = 60;       % Impedance magnitude and phase angle
thetai = thetav - gama;           % Current phase angle in degree
theta = (thetav - thetai)*pi/180;              % Degree to radian
Im = Vm/Z;                                    % Current amplitude
wt=0:.05:2*pi;                                % wt from 0 to 2*pi
v=Vm*cos(wt);                             % Instantaneous voltage
i=Im*cos(wt + thetai*pi/180);             % Instantaneous current
p=v.*i;                                     % Instantaneous power
V=Vm/sqrt(2); I=Im/sqrt(2);             % rms voltage and current
P = V*I*cos(theta);                               % Average power
Q = V*I*sin(theta);                              % Reactive power
S = P + j*Q                                       % Complex power
pr = P*(1 + cos(2*(wt + thetav)));                    % Eq. (2.6)
px = Q*sin(2*(wt + thetav));                          % Eq. (2.8)
PP=P*ones(1, length(wt));  % Average power with length w for plot
xline = zeros(1, length(wt));           % generates a zero vector
wt=180/pi*wt;                       % converting radian to degree
subplot(2,2,1), plot(wt, v, wt, i,wt, xline), grid
title(['v(t)=Vm coswt, i(t)=Im cos(wt +', num2str(thetai), ')'])
xlabel('wt, degree')
subplot(2,2,2), plot(wt, p, wt, xline), grid
title('p(t)=v(t) i(t)'), xlabel('wt, degree')
subplot(2,2,3), plot(wt, pr, wt, PP, wt,xline), grid
title('pr(t)   Eq. 2.6'), xlabel('wt, degree')
subplot(2,2,4), plot(wt, px, wt, xline), grid
title('px(t)  Eq. 2.8'), xlabel('wt, degree')
subplot(111)
