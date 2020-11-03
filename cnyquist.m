function  [re,im]=cnyquist(num,den,s)
%  Hadi Saadat  1998
%  [re, im] = cnyquist(num, den, s) calculate the nyquist response
%  by mapping the nyquist path via the transfer function GH(s) into
%  complex plane.  num and den contain the polynomial coefficients
%  in descending power.  s is the complex row vector defined by the
%  Nyquist path.

m=length(num); n=length(den);  ls=length(s);
for k=1:ls
for j= 1:m
  sm(j)=s(k)^(m-j);
end
for i=1:n
 sn(i)=s(k)^(n-i);
end
nums=sm*num';
dens=sn*den';
ghs(k) =nums/dens;
end
re=real(ghs); im=imag(ghs); [re im];
