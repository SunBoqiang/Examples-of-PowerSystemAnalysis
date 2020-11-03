function [numopen, denopen, denclsd]=tachfdbk(num,den,s1)

% Hadi Saadat,  1998

discr=[
'                                                                       '
'  The function tachfdbk(num, den, s1) is used for the design of the    '
'  minor-loop rate-feedback or tachometer-feedback control.  num and den'
'  are row vectors of polynomial coefficients of the uncompensated open-'
'  loop plant transfer function and s1=a+j*w is a desired pole of the   '
'  loop transfer function.  The function returns the open-loop and the  '
'  closed-loop numerator and denominators of the compensated system     '
'  transfer function.                                                   '];
%disp(discr);
clc
beta=atan2(imag(s1),real(s1));
sm=abs(s1);
[mag,phase]=ghs(num,den,s1);   % Returns the mag. and phase of G(s1)H(s1)
  if imag(s1)==0
  disp('The specified closed-loop pole s1 must be a complex pole')
  return
  else
Kp=-sin(beta+phase)/(mag*sin(beta));
KD=sin(phase)/(sm*mag*sin(beta));
  end
Z0=Kp/KD;
fprintf('     Ka = %g',Kp),fprintf(' , Kt = %g',KD),
fprintf('s \n\n')
% the following statements will form the characteristic Equation
% of the compensated system.
m=length(num); n=length(den);
if n > m
o=zeros(1,n-m); mk=[o,1]; num1=conv(num,mk);
else, num1=num, end
numgc=[KD,Kp]; numopen=conv(numgc, num1);
dengc=[0, 1];  denopen=conv(dengc, den);
denclsd=denopen+numopen;
numopen=conv(Kp,num1);
%fprintf('Row vectors of polynomial coefficients of the compensated system:\n\n')
%fprintf('Open-loop num. '),disp(numopen)
%fprintf('Open-loop den. '),disp(denopen)
%fprintf('Closed-loop den'),disp(denclsd)
fprintf('Compensated open-loop ')
GH = tf(numopen, denopen)
fprintf('Compensated closed-loop ')
T = tf(numopen, denclsd)

discr2=[
'Roots of the compensated characteristic equation:       '
'                                                        '];
disp(discr2)
r=roots(denclsd);
disp(r)
rreal=real(r);
  for l=1:n-1
  if rreal(l) >=0
  fprintf('   Root on the RHP, system is unstable. Change s1 & repeat.\n\n')
  else,end
  end
