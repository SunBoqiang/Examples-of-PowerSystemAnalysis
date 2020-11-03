x=0:.05:4.5;
g=-1/9*x.^3+6/9*x.^2+4/9;
k=1;
dz=10;
z=2;
r(k)=z;
s(k)=z;
while dz >.001
k=k+2;
r(k-1)=z;
p=-1/9*z^3+6/9*z^2+4/9;
s(k-1)=p;
dz=abs(z-p);
z=z+1.25*(p-z);
r(k)=z; s(k)=p;
end
plot(x,g,'-',x,x,'-', r,s,'-'),grid
xlabel('x')
text(0.7, 4.1,'g(x) = -1/9x^3+6/9x^2+4/9')
text(3.2, 3.0,'x')
clear x g r s