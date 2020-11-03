% Cartezian plot of Bessel function J0(sqrt(x^2+y^2))

[x,y]=meshgrid(-12:.7:12, -12:.7:12);
                           % meshgrid transforms the specified domain
                           % into array x and y for evaluating z
r=sqrt(x.^2+y.^2);z= bessel(0,r);
m=[-45 60];
mesh(z,m)                    % 3-D mesh plot
