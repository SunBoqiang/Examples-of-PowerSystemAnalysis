% Iterative solution Using Newton method
iter = 0;                                  % Iteration counter
Df = 10;                  % Error in Df is set to a high value
Lambda = input('Enter estimated value of Lambda = ');
fprintf('\n ')
disp(['     Iter      Df         J       DLambda   Lambda'  ...
'      x         y'])
while abs(Df)  >= 0.0001                % Test for convergence
iter = iter + 1;                           % No. of iterations
x = 8*Lambda/(Lambda + 1);
y = 6*Lambda/(Lambda + 1);
Df = (x- 8)^2 + (y - 6)^2 - 25;                     % Residual
J = -200/(Lambda + 1)^3;                          % Derivative
Delambda =-Df/J;                          % Change in variable
disp([iter, Df, J, Delambda, Lambda, x, y])
Lambda = Lambda + Delambda;              % Successive solution
end
%Graphical Demonstration of Example 7.2
wt=0:.01:2*pi;
z =8+j*6+ 5*(cos(wt) + j*sin(wt));
x=0:.01:12; y=6/8*x;

plot(real(z),imag(z), x, y), grid
xlabel('x'), ylabel('y')
axis([0 , 14, 0, 14]), axis('square')
