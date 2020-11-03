x=0:.05:6;
f = x.^3-6*x.^2+9*x-4;
k=1;
dz=10;
z=6;
r(k)=z;
while abs(dz) >.1
Df= z^3-6*z^2+9*z -4;
s(k)=Df;
r(k)=z;
J = 3*z^2-12*z+9;
dz=-Df/J;
z=z+dz;
k=k+2;
r(k-1)=z;
s(k-1)=0;
r(k)=z;
s(k)=Df;
end
h=zeros(1,length(x));
plot(x,f,'-', x,h,'-', r,s,'-'),grid
xlabel('x')
text(3.0, 30,'f(x) = x^3-6x^2+9x-4')
