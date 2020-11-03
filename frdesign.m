function [numopen, denopen, denclsd]= frdesign(num, den)

% Hadi Saadat, 1998
clc
discr=[
'                                                                          '
'  The function [numopen, denopen, denclsd] = frdesign(num, den) is used   '
'  for the frequency response design of a linear control system. num & den '
'  are row vectors of polynomial coefficients of the uncompensated open-   '
'  loop plant transfer function. The controller transfer function and the  '
'  frequency domain specifications before and after compensation are found.'
'  The function returns the open-loop & the closed-loop numerator and      '
'  denominators of the compensated system transfer function.               '
'                                                                          '
'               Compensator type                    Enter                  '
'               ----------------                    -----                  '
'               Gain Compensation                      1                   '
'               Phase-lead                             2                   '
'               Phase-lag                              3                   '
'               PD  Controller                         4                   '
'               PI  Controller                         5                   '
'               PID Controller                         6                   '
'               To quit                                0                   '];


disp(discr)
t = input(' Enter your choice  -> ');
if t ==1; [numopen,denopen, denclsd]= frqp(num, den);
elseif t ==2; [numopen,denopen, denclsd]= frqlead(num, den);
elseif t ==3; [numopen,denopen, denclsd]= frqlag(num, den);
elseif t ==4; [numopen,denopen, denclsd]= frqpd(num, den);
elseif t ==5; [numopen,denopen, denclsd]= frqpi(num, den);
elseif t ==6; [numopen,denopen, denclsd]= frqpid(num, den);
elseif t ==0; exit, end
