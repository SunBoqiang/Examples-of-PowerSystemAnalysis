P = 40;                                           % real power, MW
V = 30/sqrt(3)+ j*0;                           % phase voltage, kV
Zs = j*9;                                  % synchronous impedance
ang = acos(0.4);
theta=ang:-0.01:-ang;   % Angle from 0.4 leading to 0.4 lagging pf
P= P*ones(1,length(theta));       % generates P array of same size
Iam = P./(3*abs(V)*cos(theta));             % current magnitude kA
Ia = Iam.*(cos(theta) + j*sin(theta));            % current phasor
E = V + Zs.*Ia;                        % excitation voltage phasor
Em = abs(E);                    % excitation voltage magnitude, kV
If = Em*1000/2000;                              % field current, A
plot(If, Iam), grid
xlabel('If, A'), ylabel('Ia, kA')
text(3.4, 1, 'Leading pf'), text(13, 1, 'Lagging pf')
text(9, .71, 'Upf')
