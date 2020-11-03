% State variable representation of the swing equation of
% the one-machine system during fault.
function xdot = pfpower(t,x)
global Pm E V X1 X2 X3 H f
xdot = [x(2); pi*f/H*(Pm-E*V/X2*sin(x(1)))];
