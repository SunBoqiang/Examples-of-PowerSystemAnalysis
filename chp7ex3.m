%Graphical Demonstration of Example 7.3

wt=0:.01:2*pi;
z =8+j*6+ 5*(cos(wt) + j*sin(wt));
x=0:.01:12; y=6/8*x;
y2=12-2*x;
plot(real(z),imag(z), x, y, x, y2), grid
xlabel('x'), ylabel('y')
axis([0 , 14, 0, 14]), axis('square')


a =[1 2 .36];
Lambda = roots(a)
X=(4*Lambda+4.8)./(1+Lambda)
Y=(4*Lambda+2.4)./(1+Lambda)
F=sqrt(X.^2+Y.^2)
Mindist=min(F)
