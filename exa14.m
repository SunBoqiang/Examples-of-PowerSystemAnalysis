x = [ 0  0.5  1.0  1.5  2.0  2.5  3.0  3.5  4.0  4.5  5.0];
y = [10   10  16   24   30   38   52    68   82   96  123];
p = polyfit(x, y, 2)   % finds the coefficients of a polynomial
                       % of degree 2 that fits the data
yc = polyval(p, x);    % polynomial is evaluated at all points in x
plot(x, y,'x', x, yc)  % plots data marked by x and fitted polynomial
xlabel('x'), ylabel('y'), grid
title('Polynomial curve fitting')
legend('Actual data', 'Fitted polynomial')
