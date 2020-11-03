% This program solves the coordination equation for economic scheduling
% of generation.  The program requires the total load demand (Pdt), the
% cost function matrix (cost) and the gen. mwlimits.  If mwlimits is not
% defined the scheduling is obtained with no generation limits. If the
% basemva and any of the loss coefficients B, B0 and B00 are specified
% optimum dispatch is obtained including the system losses.
%
% copyright (c) 1998 by H. Saadat

clear Pgg
if exist('Pdt')~=1
Pdt = input('Enter total demand Pdt = ');
else, end
if exist('cost')~=1
cost = input('Enter the cost matrix, cost = ');
else, end
ngg = length(cost(:,1));
if exist('mwlimits')~=1
mwlimits= [zeros(ngg, 1), inf*ones(ngg,1)];
else, end
if exist('B')~=1
B = zeros(ngg, ngg);
else, end
if exist('B0')~=1
B0=zeros(1, ngg);
else, end
if exist('B00')~=1
B00=0;
else, end
if exist('basemva')~=1
basemva=100;
else, end
clear Pgg
Bu=B/basemva; B00u=basemva*B00;
alpha=cost(:,1); beta=cost(:,2); gama = cost(:,3);
Pmin=mwlimits(:,1); Pmax=mwlimits(:,2);
wgt=ones(1, ngg);
if Pdt > sum(Pmax)
Error1 = ['Total demand is greater than the total sum of maximum generation.'
          'No feasible solution.  Reduce demand or correct generator limits.'];
disp(Error1), return
elseif Pdt < sum(Pmin)
Error2 = ['Total demand is less than the total sum of minimum generation.    '
          'No feasible solution. Increase demand or correct generator limits.'];
disp(Error2), return
else, end
iterp = 0;                                  % Iteration counter
DelP = 10;              % Error in DelP is set to a high value

E=Bu;
if exist('lambda')~=1
lambda=max(beta);
end
while abs(DelP)  >= 0.0001  & iterp < 200     % Test for convergence
iterp = iterp + 1;                           % No. of iterations
for k=1:ngg
    if wgt(k) == 1
       E(k,k) = gama(k)/lambda + Bu(k,k);
       Dx(k) = 1/2*(1 - B0(k)- beta(k)/lambda);
       else, E(k,k)=1;  Dx(k) = 0;
            for m=1:ngg
               if m~=k
               E(k,m)=0;
               else,end
             end
       end
end
PP=E\Dx';
for k=1:ngg
if wgt(k)==1
   Pgg(k) = PP(k);
   else,end
end
Pgtt = sum(Pgg);
PL=Pgg*Bu*Pgg'+B0*Pgg'+B00u;
DelP =Pdt+PL -Pgtt ;                                  %Residual
for k = 1:ngg
   if Pgg(k) > Pmax(k) & abs(DelP) <=0.001,
   Pgg(k) = Pmax(k); wgt(k) = 0;
   elseif Pgg(k) < Pmin(k) & abs(DelP) <= 0.001
   Pgg(k) = Pmin(k); wgt(k) = 0;
   else, end
end
PL=Pgg*Bu*Pgg'+B0*Pgg'+B00u;
DelP =Pdt +PL - sum(Pgg);                              %Residual
  for k=1:ngg
  BP = 0;
     for m=1:ngg
         if m~=k
            BP = BP + Bu(k,m)*Pgg(m);
            else, end
     end
  grad(k)=(gama(k)*(1-B0(k))+Bu(k,k)*beta(k)-2*gama(k)*BP)/(2*(gama(k)+lambda*Bu(k,k))^2);
  end
sumgrad=wgt*grad';
Delambda = DelP/sumgrad;                 % Change in variable
lambda = lambda + Delambda;              % Successive solution
end
fprintf('Incremental cost of delivered power (system lambda) = %9.6f $/MWh \n', lambda);
fprintf('Optimal Dispatch of Generation:\n\n')
disp(Pgg')
%fprintf('Total system loss = %g MW \n\n', PL)
ng=length(Pgg);
n=0;
if exist('nbus')==1 | exist('busdata')==1
  for k=1:nbus
     if kb(k)~=0
        n=n+1;
        if n <= ng
        busdata(k,7)=Pgg(n); else, end
     else , end
  end
  if n == ng
     for k=1:nbus
         if kb(k)==1
         dpslack = abs(Pg(k)-busdata(k,7))/basemva;
         fprintf('Absolute value of the slack bus real power mismatch, dpslack = %8.4f pu \n', dpslack)
         else, end
     end
   else, end 
 else, end
clear BP Dx DelP Delambda E PP grad sumgrad wgt Bu B00u B B0 B00
