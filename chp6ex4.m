dx=1;                   % Change in variable is set to a high value
x=input('Enter the initial estimate -> ');       % Initial estimate
iter = 0;                                       % Iteration counter
disp('iter   Dc        J         dx         x')% Heading for result
while abs(dx) >= 0.001 & iter < 100          % Test for convergence
iter = iter + 1;                                % No. of iterations
Dc=4 - (x^3-6*x^2+9*x);                                  % Residual
J = 3*x^2-12*x+9;                                      % Derivative
dx= Dc/J;                                       %Change in variable
x=x+dx;                                       % Successive solution
fprintf('%g', iter), disp([Dc, J, dx, x])
end
chp6fig5                        % Graphical display for Example 6.4
