function xdot = mechsys(t,x);   % returns the state derivatives
F = 25;                          % Step input
M =1; B = 5; K = 25;
xdot = [x(2) ; 1/M*( F - B*x(2) - K*x(1) ) ];
