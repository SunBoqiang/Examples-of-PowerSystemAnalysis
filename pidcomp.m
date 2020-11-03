function [numopen, denopen, denclsd]=pidcomp(num,den,s1,KI)

% Hadi Saadat, 1998

discr=[
'                                                                      '
'  The function pidcomp(num, den, s1) is used for the design of a PID  '
'  controller.  num & den are row vectors of polynomial coefficients   '
'  of the uncompensated open-loop plant transfer function and s1=å+j*w '
'  is a desired pole of the closed-loop transfer function. The user is '
'  prompted to enter the gain KI to achieve a desired steady-state     '
'  response. Also, for the case that s1 is real you will be prompted to'
'  enter the gain Kp.  The function returns the open-loop & the closed '
'  numerator & denominators of the compensated system transfer function'
'                                                                      '];
%disp(discr);

KI=input('Enter the integrator gain KI -> ');
clc
beta=atan2(imag(s1),real(s1));
sm=abs(s1);
[mag,phase]=ghs(num,den,s1);   % Returns the mag. and phase of G(s1)H(s1)
  if imag(s1)==0
  Kp=input('  Enter the gain Kp of the PID compensator -> ');
  fprintf('\n\n')
  ghr=mag*cos(phase);
  KD=-1/(s1*ghr)-Kp/s1-KI/(s1*s1);
  else
Kp=-sin(beta+phase)/(mag*sin(beta))-(2*KI*cos(beta))/sm;
KD=sin(phase)/(sm*mag*sin(beta))+KI/(sm*sm);
  end
Z0=Kp/KD;
fprintf('     Gc = %g',Kp),fprintf(' + %g',KI),fprintf('/s + '),
fprintf('%g',KD),fprintf('s \n\n')
% the following statements will form the characteristic Equation
% of the compensated system.
m=length(num); n=length(den);
if n > m
o=zeros(1,n-m); mk=[o,1]; num1=conv(num,mk);
else, num1=num, end
numgc=[KD,Kp,KI]; numopen=conv(numgc,num1);
dengc=[0, 1, 0];  denopen=conv(dengc, den);
denclsd=denopen+numopen;
numopen=numopen(n-m+1:length(numopen));   % new 11/24/96
denopen =denopen(2:length(denopen));      % new
denclsd=denclsd(2:length(denclsd));       % new
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
