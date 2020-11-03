theta=0:.02:2*pi;
r = 2*ones(1, length(theta));
x=-3:.02:1.5;
y=1- exp(x);
plot(x,y,'-'),grid
axis([-3 3 -3  3]);
axis('square');
xlabel('x')
text(1,1.8,' x^2+y^2=4')
text(1.2,-2.3,' e^x+y=1')
hold;
polar(theta, r)
hold off
