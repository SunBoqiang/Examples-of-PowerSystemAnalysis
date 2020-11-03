function [G, Ae] = observer(A,B,C,Pe)

%  H. Saadat,  1998
clc
% discr=[
%' This function is used for the computation of the estimator gain     '
%' gain vector G based on the Ackermann`s formula.  A is the system    '
%' matrix, B is the input column vector & C is the output row vector.  '
%' Pe is the row vector containing the desired estimator closed-loop   '
%' poles. The function displays the gain vector G and the open-loop    '
%' plant transfer function. The gain G and the estimator system matrix '
%' A - G*C are returned.                                               '
%'                                                                    '];

%disp(discr)

n=length(A);
  for i=1:n;
  V(n+1-i,:) = C*A^(n-i);
  end
  if rank(V)~=n
  error('System is not state observable')
  else
W=inv(V);
   end
qe=zeros(n,1); qe(n)=1;
He=W*qe;
pe=poly(Pe);
AL=zeros(n);
for i=1:n+1
AL=AL+pe(n+2-i)*A^(i-1);
end
G=AL*He;        % Requlator constants
Ae=A-G*C;      % Closed-loop system matrix


fprintf('Estimator gain vector G  \n'),
for i=1:n, fprintf('  %g\n',G(i)),end,fprintf('\n')

D=0;
[num, den]=ss2tf(A,B,C,D,1);
  for i=1:length(num)
  if abs(num(i)) <= 1e-08 num(i)=0; else,end,end

%fprintf('Open-loop Plant transfer function: \n'),
%fprintf('Numerator   ')
%for i=1:length(num), fprintf('  %g',num(i)),fprintf('  '),end,fprintf('\n')
%fprintf('Denominator ')
%for i=1:length(den), fprintf('  %g',den(i)),fprintf('  '),end,fprintf('\n\n')
fprintf('Open-loop Plant ')
GH = tf(num, den)
fprintf('Error matrix A - G*C \n')
disp(Ae)
