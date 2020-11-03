% This function transforms a three-phase unbalanced phasor into its
% symmetrical components.
% The Three phasors can be expressed in a one column array in rectangular
% complex form or in a two column array in polar form, with 1st column
% magnitude and 2nd column phase angle in degree.
% The function returns the symmetrical components in rectangular form.
% The function plots the original unbalanced phasors and the
% symmetrical components.
%
%  Copyright (C) 1998 by H. Saadat

function [symcomp] = abc2sc(fabc)
rankfabc=length(fabc(1,:));
if rankfabc == 2
mag= fabc(:,1); ang=pi/180*fabc(:,2);
fabcr=mag.*(cos(ang)+j*sin(ang));
elseif rankfabc ==1
fabcr=fabc;
else
fprintf('\n  Three phasors must be expressed in a one column array in rectangular complex form \n')
fprintf('  or in a two column array in polar form, with 1st column magnitude & 2nd column \n')
fprintf('  phase angle in degree. \n')
return, end
a=cos(2*pi/3)+j*sin(2*pi/3);
A = [1   1   1; 1 a^2  a; 1 a  a^2];
fa012=inv(A)*fabcr;
symcomp= fa012;
%scpolar = [abs(fa012)  180/pi*angle(fa012)];
%fprintf(' \n Symmetrical components \n')
%fprintf(' Magnitude  Angle Deg.\n')
%disp(scpolar)
fabc0=fa012(1)*[1; 1; 1];
fabc1=fa012(2)*[1;  a^2;  a];
fabc2=fa012(3)*[1;  a;  a^2];
figure
subplot(221);
[Px, Py, Vscale]= phasor3(fabcr);
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
