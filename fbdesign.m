function [numopen, denopen, denclsd]=fbdesign(num,den,s1)

% Hadi Saadat  1998
clc
discr=[
'                                                                         '
'  The function fbdesign(num, den, s1) is used for the minor-loop feedback'
'  design of a linear control system.  num & den are row vectors of       '
'  polynomial coefficients of the uncompensated open-loop plant transfer  '
'  function and s1 = å+j*w is a desired pole of the closed-loop transfer  '
'  function.                                                              '
'                                                                         '];
%disp(discr)
discr2=[
'            Compensator type                           Enter             '
'            ----------------                           -----             '
'            Rate feedback                                1               '
'            Minor-loop design with passive network       2               '
'            To quit                                      0               '];


disp(discr2)
t = input(' Enter your choice  -> ');
if t ==1; [numopen, denopen, denclsd]=tachfdbk(num,den,s1);
elseif t ==2; [numopen, denopen, denclsd]=pnetfdbk(num,den,s1);
elseif t ==0; ,exit, end
