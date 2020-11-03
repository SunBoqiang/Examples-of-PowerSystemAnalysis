% This function returns the real parts Px, and the imaginary
% parts Px of a phasor with arrow head and Vscale (axis scale)
% for phasors V. V is a a column vector expressed as a complex
% variable in rectangular form.
%
% Copyright (c) 1998 H. Saadat

function [Px, Py, Vscale]= phasor3(V)

Vr=real(V);
Vi=imag(V);

Vscale=1.1*max([abs(Vr); abs(Vi)]);
Z=1.1547005*abs(V)/10;
th=angle(V);
x1= Vr-(Z.*sin(pi/3-th));
y1= Vi-(Z.*cos(pi/3-th));
x2= Vr-(Z.*cos(th-pi/6));
y2= Vi-(Z.*sin(th-pi/6));
or=zeros(length(V),1);
Vx=[or  Vr]; Vy=[or  Vi];
Ar1x=[x1  Vr]; Ar1y=[y1  Vi];
Ar2x=[x2  Vr]; Ar2y=[y2  Vi];
Arx=[Ar1x;Ar2x]; Ary=[Ar1y; Ar2y];
Px=[Vx; Arx]; Py=[Vy; Ary];
