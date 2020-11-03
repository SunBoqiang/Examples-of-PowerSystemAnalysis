% This function transforms the symmetrical components into its original
% abc phasors.
% The symmetrical components can be expressed in a one column array in
% rectangular complex form or in a two column array in polar form, with
% 1st column magnitude and 2nd column phase angle in degree.
% First, second and third rows are Zero-, positives- and negative-sequence
% components respectively.
% The function  returns the abc phsors in rectangular form.
% The function plots the original symmetrical components and the unbalanced
% phasors.

% Copyright (c) 1998 H. Saadat

function [fabc] = sc2abc(fa012)

rankf012=length(fa012(1,:));
if rankf012 == 2
mag= fa012(:,1); ang=pi/180*fa012(:,2);
fa012r=mag.*(cos(ang)+j*sin(ang));
elseif rankf012 ==1
fa012r=fa012;
else
fprintf('\n  Symmetrical components must be expressed in a one column array in rectangular complex form \n')
fprintf('  or in a two column array in polar form, with 1st column magnitude & 2nd column \n')
fprintf('  phase angle in degree. \n')
return, end
a=cos(2*pi/3)+j*sin(2*pi/3);
A = [1   1   1; 1 a^2  a; 1 a  a^2];
fabc= A*fa012r;
%fabcp= [abs(fabc)  180/pi*angle(fabc)];
%fprintf(' \n Unbalanced phasors \n')
%fprintf(' Magnitude  Angle Deg.\n')
%disp(fabcp)
fabc0=fa012r(1)*[1; 1;  1];
fabc1=fa012r(2)*[1;  a^2;  a];
fabc2=fa012r(3)*[1;  a;  a^2];
figure
subplot(221);
[Px, Py, Vscale]= phasor3(fabc);
[Px0, Py0, Vscale0]= phasor3(fabc0);
[Px1, Py1, Vscale1]= phasor3(fabc1);
[Px2, Py2, Vscale2]= phasor3(fabc2);
Vscle=max([Vscale, Vscale0, Vscale1, Vscale2]);
plot(Px', Py','r')
title('a-b-c set')
axis([-Vscle Vscle -Vscle Vscle]);
axis('square')
subplot(222);
plot(Px0', Py0','g')
title('Zero-sequence set')
axis([-Vscle Vscle -Vscle Vscle]);
axis('square')
subplot(223);
plot(Px1', Py1','m')
title('Positive-sequence set')
axis([-Vscle Vscle -Vscle Vscle]);
axis('square')
subplot(224);
plot(Px2', Py2','b')
title('Negative-sequence set')
axis([-Vscle Vscle -Vscle Vscle]);
axis('square')
subplot(111)
