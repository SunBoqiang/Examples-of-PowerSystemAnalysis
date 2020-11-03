function xdot = state(t,x);   % returns the state derivatives
A = [0  1  0; 0  0  1; -6  -11  -6];
B=[1; 1; 1];
xdot = A*x'+ B*sin(2*pi*t);
%xdot = A*x';
