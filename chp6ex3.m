chp6fig4                        % Graphical display for Example 6.3
dx=1;                   % Change in variable is set to a high value
x=2;                                             % Initial estimate
iter = 0;                                       % Iteration counter
disp('Iter    g         dx        x')         % Heading for results
while abs(dx) >= 0.001 & iter < 100          % Test for convergence
iter = iter + 1;                                % No. of iterations
g = -1/9*x^3+6/9*x^2+4/9;
dx = g-x;                                      % Change in variable
x = x + 1.25*dx; % Successive approximation with 1.25 accel. factor
fprintf('%g', iter), disp([g, dx, x])
end
