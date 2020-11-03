% State variable representation of the swing equation of
% the one-machine system after fault clearance.

function xdot = afpower(t,x)
global Pm f H E  V X1 X2 X3
xdot = [x(2); pi*f/H*(Pm-E*V/X3*sin(x(1)))];
