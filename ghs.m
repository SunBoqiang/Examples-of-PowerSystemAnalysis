function  [mag,phase]=ghs(num,den,s)
%  Hadi Saadat, 1998
%  This function returns the magnitude and phase angle in radian of
%  the open-loop transfer function G(s)H(s) for the specified complex
%  variable s = å + jw. Num and den are the row vectors containing
%  the polynomial coefficients.
m=length(num); n=length(den);
for j= 1:m
  sm(j)=s^(m-j);
end
for i=1:n
 sn(i)=s^(n-i);
end
nums=sm*num';
dens=sn*den';
GH=nums/dens;
mag=abs(GH);
phase=atan2(imag(GH),real(GH));
[mag,phase];
