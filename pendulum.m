function xdot = pendulum(t,x);   % returns the state derivatives
W =2; L = .6; B = 0.02; g = 9.81;  m =W/g;
xdot = [x(2) ; -B/m*x(2)-W/(m*L)*sin(x(1)) ];
