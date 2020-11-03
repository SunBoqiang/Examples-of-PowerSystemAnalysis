% This program solves the coordination equation for economic scheduling
% of generation.  The program requires the total load demand (Qdt), the
% cost function matrix (cost) and the gen. mwlimits.  If mwlimits is not
% defined the scheduling is obtained with no generation limits. If the
% basemva and any of the loss coefficients B, B0 and B00 are specified
% optimum dispatch is obtained including the system losses.
%
% copyright (c) 1998 by H. Saadat

clear Qgg
if exist('Qdt')~=1
Qdt = input('Enter total reactive power demand Qdt = ');
else, end
if exist('cost')~=1
cost = input('Enter the cost matrix, cost = ');
else, end
ngg = length(cost(:,1));
if exist('vrlimits')~=1
vrlimits= [-inf*ones(ngg, 1), inf*ones(ngg,1)];
else, end
if exist('basemva')~=1
basemva=100;
else, end
clear Qgg
Du=D/basemva; D00u=basemva*D00;
Gu=G/basemva; G00u=basemva*D00;

Qmin=vrlimits(:,1); Qmax=vrlimits(:,2);
wgt=ones(1, ngg);
if Qdt > sum(Qmax)
Error1 = ['Total demand is greater than the total sum of maximum reactive generation.'
          'No feasible solution.  Reduce demand or correct generator limits.         '];
disp(Error1), return
elseif Qdt < sum(Qmin)
Error2 = ['Total demand is less than the total sum of minimum reactive generation.   '
          'No feasible solution. Increase demand or correct generator limits.        '];
disp(Error2), return
else, end
iter = 0;                                  % Iteration counter
DelQ = 10;              % Error in DelQ is set to a high value
clc
E=Du;
if exist('kapa')~=1
kapa=max(beta);
end
while abs(DelQ)  >= 0.0001              % Test for convergence
iter = iter + 1;                           % No. of iterations
for k=1:ngg
    if wgt(k) == 1
       E(k,k) = Gu(k)+ kapa*Du(k,k);
       d(k) = 1/2*(kapa*(1 - D0(k)- G0(k));
       else, E(k,k)=1;  d(k) = 0;
            for m=1:ngg
               if m~=k
               E(k,m)=0;
               else,end
             end
       end
end
QQ=E\d';
for k=1:ngg
if wgt(k)==1
   Qgg(k) = QQ(k);
   else,end
end
Qgt = sum(Qgg);
QL=Qgg*Du*Qgg'+D0*Qgg'+D00u;
DelQ =Qdt+QL -Qgt;                                   %Residual
for k = 1:ngg
   if Qgg(k) > Qmax(k) & abs(DelQ) <=0.001,
   Qgg(k) = Qmax(k); wgt(k) = 0;
   elseif Qgg(k) < Qmin(k) & abs(DelQ) <= 0.001
   Qgg(k) = Qmin(k); wgt(k) = 0;
   else, end
end
QL=Qgg*Du*Qgg'+D0*Qgg'+D00u;
DelQ =Qdt +QL - sum(Qgg);                              %Residual
  for k=1:ngg
  BQ = 0;
     for m=1:ngg
         if m~=k
            BQ = BQ + Du(k,m)*Qgg(m);
            else, end
     end
  grad(k)=(gama(k)*(1-D0(k))+Du(k,k)*beta(k)-2*gama(k)*BQ)/(2*(gama(k)+kapa*Du(k,k))^2);
  end
sumgrad=wgt*grad';
Dekapa = DelQ/sumgrad;                 % Change in variable
kapa = kapa + Dekapa;              % Successive solution
end
fprintf('Incremental cost of delivered power (system kapa) = %9.6f \n', kapa)
fprintf('Optimal scheduking of reactive Generation:\n\n')
disp(Qgg')
%fprintf('Total system reactive power loss = %g MW \n\n', QL)
n=0;
if exist('nbus')==1 | exist('busdata')==1
  for k=1:nbus
     if kb(k)~=0
        n=n+1;
        busdata(k,8)=Qgg(n);
     else , end
  end
  for k=1:nbus
      if kb(k)==1
      dqslack = abs(Qg(k)-busdata(k,8))/basemva;
      fprintf('Absolute value of the slack bus reactive power mismatch, dpslack = %8.4f p.u. \n', dqslack)
      else, end
  end
else, end
clear BQ d DelQ Dekapa E QQ grad sumgrad wgt Du D00u D D0 D00
