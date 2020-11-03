function [K,Af]= placepol(A,B,C,P)

%  H. Saadat, 1998
clc
% discr=[
%' This function is used for the pole placement design based on the    '
%' Ackermann`s formula.  A is the system matrix, B is the input column '
%' vector & C is the output row vector.   P is a row vector containing '
%' the desired closed-loop poles.  The function displays the feedback  '
%' vector K, the open-loop plant transfer function and the controlled  '
%' closed-loop transfer function. The gain K and the closed-loop system'
%' matrix Af are returned.                                             '
%'                                                                    '];
%disp(discr)

n=length(A);
  for i=1:n;
  S(:,n+1-i) = A^(n-i)*B;
  end
  if rank(S)~=n
  error('System is not state controllable')
  else
T=inv(S);
   end
q=zeros(1,n); q(n)=1;
H=q*T;
p=poly(P);
AL=zeros(n);
for i=1:n+1
AL=AL+p(n+2-i)*A^(i-1);
end
K=H*AL;        % Requlator constants
Af=A-B*K;      % Closed-loop system matrix

fprintf('Feedback gain vector K  \n'),
for i=1:n, fprintf('  %g',K(i)),fprintf(' '),end,fprintf('\n\n')
D=0;
if length(C(:,1)) > 1 return
else
[num, den]=ss2tf(A,B,C,D,1);
for i=1:length(num)
if abs(num(i)) <=1e-08 num(i)=0;else end,end
[numclsd, denclsd]=ss2tf(Af,B,C,D,1);
for i=1:length(numclsd)
if abs(numclsd(i)) <=1e-08 numclsd(i)=0;else end,end
%fprintf('Uncompensated Plant transfer function: \n'),
%fprintf('Numerator   ')
%for i=1:length(num), fprintf('  %g',num(i)),fprintf('  '),end,fprintf('\n')
%fprintf('Denominator ')
%for i=1:length(den), fprintf('  %g',den(i)),fprintf('  '),end,fprintf('\n\n')
fprintf('Uncompensated Plant')
GH = tf(num, den)

%fprintf('Compensated system closed-loop transfer function: \n')
%fprintf('Numerator   ')
%for i=1:length(numclsd), fprintf('  %g',numclsd(i)),fprintf('  '),end,fprintf('\n')
%fprintf('Denominator ')
%for i=1:length(denclsd), fprintf('  %g',denclsd(i)),fprintf('  '),end,fprintf('\n\n')
fprintf('Compensated system closed-loop')
T = tf(numclsd, denclsd)

fprintf('Compensated system matrix A - B*K \n')
disp(Af)
end
