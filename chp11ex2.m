     E = 1.35, V= 1.0; H= 9.94; X=0.65; Pm=0.6; D=0.138; f0 = 60;
     Pmax = E*V/X, d0 = asin(Pm/Pmax)                 % Max. power
     Ps = Pmax*cos(d0)           % Synchronizing power coefficient
     wn = sqrt(pi*60/H*Ps)     % Undamped frequency of oscillation
     z = D/2*sqrt(pi*60/(H*Ps))                    % Damping ratio
     wd = wn*sqrt(1-z^2), fd = wd/(2*pi) %Damped frequency oscill.
     tau = 1/(z*wn)                                % Time constant
     th = acos(z)                              % Phase angle theta
     Dd0 = 10*pi/180;                    % Initial angle in radian
     t = 0:.01:3;
     Dd = Dd0/sqrt(1-z^2)*exp(-z*wn*t).*sin(wd*t + th);
     d = (d0+Dd)*180/pi;                    % Load angle in degree
     Dw = -wn*Dd0/sqrt(1-z^2)*exp(-z*wn*t).*sin(wd*t);
     f = f0 + Dw/(2*pi);                         % Frequency in Hz
     figure(1), subplot(2,1,1), plot(t, d), grid
     xlabel('t,  sec'), ylabel('Delta, degree')
     subplot(2,1,2), plot(t,f), grid
     xlabel('t, sec'), ylabel('f, Hz')

                            % Example 11.2 using initial function

     A = [0  1; -wn^2  -2*z*wn]; % wn, z and t are defined earlier
     B = [0; 0];                             % Column B zero-input
     C = [1 0; 0 1]; % Unity matrix defining output y as x1 and x2
     D = [0; 0];
     Dx0 = [Dd0; 0];  % Zero initial cond., Dd0 is defined earlier
     [y,x]= initial(A, B, C, D, Dx0, t);
     Dd = x(:, 1); Dw = x(:, 2);       % State variables x1 and x2
     d = (d0 + Dd)*180/pi;                  % Load angle in degree
     f = f0 + Dw/(2*pi);                         % Frequency in Hz
     figure(2), subplot(2,1,1), plot(t, d), grid
     xlabel('t, sec'), ylabel('Delta, degree')
     subplot(2,1,2), plot(t, f), grid
     xlabel('t, sec'), ylabel('f, Hz'), subplot(111)



















































































