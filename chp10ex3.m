% (a) Solution by mesh analysis
Zs=j*12; Zm=j*4; VL=100*sqrt(3);
Z= [(Zs-Zm)  -(Zs-Zm)      0
       0      (Zs-Zm)  -(Zs-Zm)
       1         1         1   ];
V=[VL*cos(pi/6)+j*VL*sin(pi/6)
   VL*cos(-pi/2)+j*VL*sin(-pi/2)
             0                  ];
Y=inv(Z)
Iabc=Y*V;                           % Line currents (Rectangular form)
Iabcp=[abs(Iabc), angle(Iabc)*180/pi]     % Line currents (Polar form)

% (b) Solution by symmetrical component method
disp('Solution by Symmetrical component method' )
Z012=[Zs+2*Zm   0     0                % Symmetrical components matrix
        0     Zs-Zm   0
        0       0   Zs-Zm];
V012=[0; VL/sqrt(3); 0];    % Symmetrical components of phase voltages
I012=inv(Z012)*V012;         % Symmetrical components of line currents
a=cos(2*pi/3)+j*sin(2*pi/3);
A=[ 1  1  1; 1 a^2  a; 1 a a^2];               % Transformation matrix
Iabc=A*I012;                        % Line currents (Rectangular form)
Iabcp=[abs(Iabc), angle(Iabc)*180/pi]     % Line currents (Polar form)
