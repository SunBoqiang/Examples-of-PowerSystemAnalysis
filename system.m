function [A,B,Q,R,t0,tf,x0]=system(A,B,Q,R,t0,tf,x0)
A=[0 1 0; 0 0 1;0 -4 -5]; B=[0;0; 1];
Q=[4 0 0; 0 3 0;0 0 2];R=.5;
t0=0;tf=15;
x0=[2 0 -2];
