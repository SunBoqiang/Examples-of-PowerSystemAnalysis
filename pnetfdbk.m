function [numopen, denopen, denclsd]=pnetfdbk(num,den,s1)

% Hadi Saadat,  1998

discr=[
'                                                                         '
'  The function pntfdbkp(num, den, s1) is used for the design of a        '
'  passive network compensator placed in a minor feedback path.  num and  '
'  den are row vectors of polynomial coefficients of the uncompensated    '
'  open-loop plant transfer function and s1 = å + j*w  is a desired pole  '
'  of the closed-loop transfer function.                                  '
'                                                                         '];
%disp(discr);
clc
a0=0;
     fprintf('\n\n')
  if imag(s1)==0
  disp(' The specified closed-loop pole must be a complex pole')
  return
  else, end
m=length(num); n=length(den);
o=zeros(1,n-m); mk=[o,1]; num1=conv(num,mk);
numeq=-(num1+den);
[alpha,gama]=ghs(numeq,den,s1);

beta=atan2(imag(s1),real(s1));
sm=abs(s1);
[mag,phase]=ghs(num,den,s1);   % Returns the mag. and phase of G(s1)H(s1)
M=mag/alpha; theta=gama-phase;
  a1 =  sin(beta)/( sm*M*sin(theta));
  b1 =  sin(theta-beta) /( -sm*sin(theta));
KKc=a1/b1; ; P0=1/b1;
fprintf('      Gc = %g',KKc),fprintf(' s'),
fprintf('/(s + %g',P0), fprintf(')\n\n')
% the following statements will form the characteristic Equation
% of the compensated system.
if n > m
o=zeros(1,n-m); mk=[o,1]; num1=conv(num,mk);
else, num1=num, end
numgc=[KKc,0 ]; dengc=[1,P0];
numopen=conv(num1,dengc);
denopen=conv(den,dengc)+conv(num1,numgc);

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
  fprintf('   Root on the RHP, system is unstable.\n')
  fprintf('   Change Comp. DC Gain or desired root location & repeat.\n\n')
  else,end
  end
