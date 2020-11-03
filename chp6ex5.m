iter = 0;                                % Iteration counter
x=input('Enter initial estimates, col. vector [x1; x2] -> ');
Dx = [1; 1];
C=[4; 1];
disp('Iter   DC       Jacobian matrix       Dx        x');
                                       % Heading for results
while max(abs(Dx)) >= .0001  & iter < 10   %Convergence test
iter=iter+1;                             % Iteration counter
f = [x(1)^2+x(2)^2;  exp(x(1))+x(2)];            % Functions
DC = C - f;                                      % Residuals
J = [2*x(1)     2*x(2)                     % Jacobian matrix
     exp(x(1))       1];
Dx=J\DC;                               % Change in variables
x=x+Dx;                               % Successive solutions
fprintf('%g', iter), disp([DC, J, Dx, x])          % Results
end
chp6fig6                 % Graphical display for Example 6.5
