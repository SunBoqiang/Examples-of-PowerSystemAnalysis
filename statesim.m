function [wdot] = statesim(t,w)

% Hadi Saadat, 1998

% Given the solution of the time-varying matrix Riccati equation found
% by the function riccasim, this function solves the state equation in
% conjunction with the optimal control equation.
global A B Q R t0 tf x0

[A,B,Q,R,t0,tf,x0]=system(A,B,Q,R,t0,tf,x0);
n=length(A); nsq=n*n;
s=reshape(w(1:n*n),n,n)';
r=inv(R);
sdot=[s*A+A'*s+Q-s*B*r*B'*s];
wdot=reshape(sdot',1,nsq);
x(1:n)=w(nsq+1:nsq+n);
u=-r*B'*s*x';
xdot=[A*x'+B*u];
wdot(nsq+1:nsq+n)=xdot(1:n);
wdot=wdot';