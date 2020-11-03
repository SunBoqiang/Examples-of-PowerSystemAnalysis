function [numopen, denopen, denclsd]=rldesign(num,den,s1)

% Hadi Saadat, 1998
clc
discr=[
'                                                                         '
'  The function rldesign(num, den, s1) is used for the root-locus design  '
'  of a linear control system.  num & den are row vectors of polynomial   '
'  coefficients of the uncompensated open-loop plant transfer function    '
'  and s1 = å+j*w is a desired pole of the closed-loop transfer function. '
'  For gain compensation and the approximate phase-lag controller instead '
'  of s1 damping ratio zeta is required.                                  '
'                                                                         '];
%disp(discr)
discr2=[
'             Compensator type                      Enter                 '
'             ----------------                      -----                 '
'             Gain compensation                        1                  '
'             Phase-lead (or phase-lag )               2                  '
'             Phase-lag  (Approximate Kc = K0/K)       3                  '
'             PD  Controller                           4                  '
'             PI  Controller                           5                  '
'             PID Controller                           6                  '
'             To quit                                  0                  '];


disp(discr2)
t = input(' Enter your choice  -> ');
if t ==1; [numopen, denopen, denclsd]=pcomp(num,den,s1);
elseif t ==2; [numopen, denopen, denclsd]=phlead(num,den,s1);
elseif t ==3; [numopen, denopen, denclsd]=phlag(num,den,s1);
elseif t ==4; [numopen, denopen, denclsd]=pdcomp(num,den,s1);
elseif t ==5; [numopen, denopen, denclsd]=picomp(num,den,s1);
elseif t ==6; [numopen, denopen, denclsd]=pidcomp(num,den,s1);
elseif t ==0; exit, end
