E0 = 1.0;
Im=[8.7569   6.7363  2.8893  2.8608   1.1785];
 t=[0.0042   0.0208  0.3208  0.3375   5.0000];
I = Im/sqrt(2);                  % The rms value of the above envelope
id=I(5);                       % rms value of the steady short-circuit

Dt2 = [t(3) t(4)];                     % Time for 20th and 21st cycles
Di2 = [I(3)-id I(4)-id];      %Diff. between transient envelope and id
LDi2= log(Di2);                   %Natural log of the above two points
c2=polyfit(Dt2, LDi2, 1);%Finds coefficients of a 1st-order polynomial
                     % i.e. the slope and intercept of a straight line
iddash=(exp(c2(2))+id)            % rms value of the transient current
Xddash=E0/iddash                     % Direct-axis transient reactance
taudash=abs(1/c2(1))%Direct-axis short-circuit transient time constant
Di=(iddash-id)*[exp(-t(1)/taudash)  exp(-t(2)/taudash)];
Di1=[I(1)-Di(1)-id   I(2)-Di(2)-id];           % Subtransient envelope
LDi1=log(Di1);
Dt1 =[t(1)  t(2)];               % Natural log of the first two points
c1=polyfit(Dt1, LDi1, 1);%Finds coefficients of a 1st-order polynomial
                     % i.e. the slope and intercept of a straight line
id2dash=exp(c1(2))+iddash      % rms value of the subtransient current
Xd2dash= E0/id2dash               % Direct-axis subtransient reactance
tau2dash=abs(1/c1(1))
                 %direct-axis short-circuit subtransient time constant
 t=0:.005:.045;
fit2 = polyval(c2, t);         % line C2 evaluated for all values of t
fit1 = polyval(c1, t);         % line C1 evaluated for all values of t
plot(t, fit1, t, fit2),grid         % Logarithmic plot of id'' and id'
ylabel('ln(I)    pu')          % intercepts are ln(Id'') and ln(Id')
xlabel('t, sec.')%slopes are the reciprocal of the time constants
