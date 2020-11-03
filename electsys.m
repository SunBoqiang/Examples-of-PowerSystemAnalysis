function xdot = electsys(t,x);   % returns the state derivatives
V = 1;                          % Step input
R =1.4; L = 2; C = 0.32;
xdot = [x(2)/C ; 1/L*( V - x(1) - R*x(2) ) ];
