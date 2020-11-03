function [numopen, denopen,denclsd]=picomp(num,den,s1)

% Hadi Saadat,  1998

discr=[
'                                                                      '
'  The function picomp(num, den, s1) is used for the design of a PI    '
'  controller.  num & den are row vectors of polynomial coefficients   '
'  of the uncompensated open-loop plant transfer function and s1=å+j*w '
'  is a desired pole of the closed-loop transfer function. For the case'
'  that s1 is real the user is prompted to enter the magnitude of the  '
'  compensator zero, ³Z0³.  The function returns the open-loop and the '
'  closed-loop numerators and denominators of the compensated system   '
'  transfer function.                                                  '
'                                                                      '];
%disp(discr);
clc
beta=atan2(imag(s1),real(s1));
sm=abs(s1);
[mag,phase]=ghs(num,den,s1);   % Returns the mag. and phase of G(s1)H(s1)
  if imag(s1)==0
  Z0=input('  Enter the magnitude of the compensator zero -> ');
  fprintf('\n\n')
  ghr=mag*cos(phase);
  KP=-s1/((s1+Z0)*ghr);
  KI=Z0*KP;
  else
KI=-(sm*sin(phase))/(mag*sin(beta));
KP=-sin(beta+phase)/(mag*sin(beta))-(2*KI*cos(beta))/sm;
Z0=KI/KP;
   end
P0=0;
fprintf('        Gc = %g',KP),fprintf(' + %g',KI),
fprintf('/s \n\n')
% the following statements will form the characteristic Equation
% of the compensated system.
m=length(num); n=length(den);
if n > m
o=zeros(1,n-m); mk=[o,1]; num1=conv(num,mk);
else, num1=num, end
numgc=[KP,KI]; numopen=conv(numgc,num1);
dengc=[1,P0];       denopen=conv(dengc,den);
denclsd=denopen+numopen;
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
  for l=1:n
  if rreal(l) >=0
  fprintf('   Root on the RHP, system is unstable. Change s1 & repeat.\n\n')
  else,end
  end
