function [numopen, denopen, denclsd]=dephlead(num,den,s1)

% Hadi Saadat, 1998

discr=[
'                                                                         '
'  The function phlead(num, den, s1) is used for the design of a phase-   '
'  lead compensator.  num & den are row vectors of polynomial coefficients'
'  of the uncompensated open-loop plant transfer function and s1 = å + j*w'
'  is a desired pole of the closed-loop transfer function.  The user is   '
'  prompted to enter the compensator DC gain Gc(0) = Kc*z0/P0.            '
'  The function can also be used for the phase-lag compensator. For phase-';
'  lag the desired pole location must be selected slightly to the right of'
'  the uncompensated pole.                                                '
'                                                                         '];
%disp(discr);
a0=input('Enter the compensator DC Gain -> ');
clc
     fprintf('\n\n')
beta=atan2(imag(s1),real(s1));
sm=abs(s1);
[mag,phase]=ghs(num,den,s1);   % Returns the mag. and phase of G(s1)H(s1)
   if abs(phase)-pi ==0.0
  z0=input('  Specify the magnitude of the comensator zero -> ');
     fprintf('\n\n')
     a1=a0/z0;
     b1=a1*mag-1/(sm*cos(beta))+a0*mag/sm*cos(beta);
   else
       if abs(phase) ==0
  z0=input('Specify the magnitude of the comensator zero -> ');
     fprintf('\n\n')
       a1=a0/z0;
       b1=-a1*mag-1/(sm*cos(beta))-a0*mag/sm*cos(beta);
     else
  a1 = ( sin(beta)+a0*mag*sin(beta-phase) )/( sm*mag*sin(phase));
  b1 = ( sin(beta+phase)+a0*mag*sin(beta) )/( -sm*sin(phase));
     end
   end
KKc=a1/b1; Z0=a0/a1; P0=1/b1;
fprintf('   Gc(0) = %g',a0),fprintf(',     Gc = %g',KKc),fprintf('(s + %g',Z0),
fprintf(')/(s + %g',P0), fprintf(')\n\n')
% the following statements will form the characteristic Equation
% of the compensated system.
m=length(num); n=length(den);
if n > m
o=zeros(1,n-m); mk=[o,1]; num1=conv(num,mk);
else, num1=num, end
numgc=[KKc,KKc*Z0]; numopen=conv(numgc,num1);
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
  fprintf('   Root on the RHP, system is unstable.\n')
  fprintf('   Change Comp. DC Gain or desired root location & repeat.\n\n')
  else,end
  end
