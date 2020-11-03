Dx=[10; 10; 10];        % Change in variable is set to a high value
x=[1; 1; 1];                                     % Initial estimate
C=[11; 3; 6];
iter = 0;                                       % Iteration counter
while max(abs(Dx))>=.0001 & iter<10;         % Test for convergence
iter = iter + 1                                 % No. of iterations
F = [x(1)^2-x(2)^2+x(3)^2                               % Functions
     x(1)*x(2)+x(2)^2-3*x(3)
     x(1)-x(1)*x(3)+x(2)*x(3)];
DC =C - F                                               % Residuals
J = [2*x(1)  -2*x(2)      2*x(3)                  % Jacobian matrix
     x(2)    x(1)+2*x(2)  -3
     1-x(3)  x(3)         -x(1)+x(2)]
Dx=J\DC                                         %Change in variable
x=x+Dx                                        % Successive solution
end
