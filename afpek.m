% State variable representation of the multimachine system
% after fault. (for use with trstab)
%
% Copyright (C) 1998 H. Saadat

function xdot = afpek(t,x)
global Pm f H E  Y th ngg

Pe=zeros(1, ngg);
for ii = 1:ngg
for jj = 1:ngg
Pe(ii) = Pe(ii) + E(ii)*E(jj)*Y(ii, jj)*cos(th(ii, jj)-x(ii)+x(jj));
end, end
for k=1:ngg
xdot(k)=x(k+ngg);
xdot(k+ngg)=(pi*f)/H(k)*(Pm(k)-Pe(k));
end
xdot=xdot';        % use with MATLAB 5 (remove for MATLAB 4)
