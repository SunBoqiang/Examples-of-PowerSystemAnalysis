function [tt,s,k, t,x]=riccati

% Hadi Saadat,  1998

% This function returns the optimal feedback control K(t) and the solution
% of the state equation.   First a function called [A,B Q,R,t0,tf,x0]=
% system(A,B Q,R,t0,tf,x0) containing system parameters and the matrices
% Q and R must be defined in a file named `system.m'.  The program calls
% upon two functions. The function [pot]=riccasim(t,p) solves the matrix
% Riccati equation defined by p(t). The second function [wdot]= statesim(t,w)
% solves the state equation in conjunction with the optimum control equation.
global A B Q R t0 tf x0
[A,B,Q,R,t0,tf,x0]=system(A,B,Q,R,t0,tf,x0)
n=length(A);nsq=n^2;
p0=zeros(1,nsq);
tol=0.0005; trace=0;
tspan=[t0, tf];
[t,p]=ode23('riccasim',tspan, p0);
tt=tf-t;
r=inv(R);
m=length(p);
for i=1:m
ss =reshape(p(i,:),n,n)';
s(n*(i-1)+1:n*i,1:n) =ss;
k(i,:)=r*B'*ss;
end
w0=[p(m,:),x0];
[t,w]=ode23('statesim',t0,tf,w0,tol,trace);
x(:,1:n)=w(:,nsq+1:nsq+n);
