function [pdot] = riccasim(t,p)

% Hadi Saadat, 1998

% This function obtains the numerical solution of the time-domain Riccati
% equation with the boundary condition specified at final time.
global A B Q R t0 tf x0
[A,B,Q,R,t0,tf,x0]=system(A,B,Q,R,t0,tf,x0);
n=length(A); nsq=n*n;
s=reshape(p,n,n)';
r=inv(R);
sdot=[s*A+A'*s+Q-s*B*r*B'*s];
pdot=reshape(sdot',1,nsq);
pdot=pdot';