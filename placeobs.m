
function [K,G, Af] = placeobs(A,B,C,P,Pe)

%  H. Saadat,  1998
clc
% discr=[
%' This function is used for the combined pole placement and observer  '
%' design based on Ackermann`s formula.  A is the system matrix, B is  '
%' the input column vector and C is the output row vector.             '
%' P is a row vector containing the desired closed-loop poles and Pe is'
%' the desired estimator roots.  The function displays the gain vectors'
%' K and G, open-loop plant transfer function and the controlled system'                                               '
%  closed-loop transfer function. Also, the function returns the gains '
%  K & G, and the combined system matrix.                              '
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
K=H*AL;        % Regulator constants
fprintf('Feedback gain vector K  \n'),
for i=1:n, fprintf('  %g',K(i)),fprintf(' '),end,fprintf('\n\n')

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
G=AL*He;         % estimator constants
fprintf('Estimator gain vector G: \n'),
for i=1:n, fprintf('  %g\n',G(i)), end,fprintf('\n')

Ae=A-G*C-B*K;  Be=G; Ce=-K; De=0;
[numG, denG]=ss2tf(Ae,Be,Ce,De,1);
numG=-numG; D=0;
for i=1:length(numG)
if abs(numG(i)) <= 1e-08 numG(i)=0; else,end,end

[num, den]=ss2tf(A,B,C,D,1);
for i=1:length(num)
if abs(num(i)) <= 1e-08 num(i)=0; else,end,end

z=zeros(n);
Af=[A-B*K B*K; z A-G*C];

numopen=conv(num,numG);
denopen=conv(den,denG);
denclsd=numopen+denopen;

%fprintf('Open-loop Plant transfer function: \n'),
%fprintf('Numerator   ')
%for i=1:length(num), fprintf('  %g',num(i)),fprintf('  '),end,fprintf('\n')
%fprintf('Denominator ')
%for i=1:length(den), fprintf('  %g',den(i)),fprintf('  '),end,fprintf('\n\n')
fprintf('Open-loop Plant')
GH = tf(num,den)

%fprintf('Controller-estimator transfer function: \n'),
%fprintf('Numerator   ')
%for i=1:length(numG), fprintf('  %g',numG(i)),fprintf('  '),end,fprintf('\n')
%fprintf('Denominator ')
%for i=1:length(denG), fprintf('  %g',denG(i)),fprintf('  '),end,fprintf('\n\n')
fprintf('Controller-estimator')
CEG = tf(numG, denG)

%fprintf('Controlled system closed-loop transfer function: \n')
%fprintf('Numerator   ')
%for i=1:length(numopen), fprintf('  %g',numopen(i)),fprintf('  '),end,fprintf('\n')
%fprintf('Denominator ')
%for i=1:length(denclsd), fprintf('  %g',denclsd(i)),fprintf('  '),end,fprintf('\n\n')
fprintf('Controlled system closed-loop')
T = tf(numopen, denclsd)
fprintf('Combined controller observer system matrix \n')
disp(Af)
