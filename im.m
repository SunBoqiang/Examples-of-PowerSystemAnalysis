%              ANALYSIS OF THE EQUIVALENT CIRCUIT
%               OF A THREE-PHASE INDUCTION MOTOR
%
%    The equivalent circuit can be used to determine the operating
%    characteristics an induction motor. Among the important aspects
%    in the steady-state are the variation of current, power, losses
%    and torque associated with various operating conditions.  Upon
%    entering the parameters of the equivalent circuit, performance
%    characteristics are obtained for the specified slip and the torque
%    slip curve is plotted on the screen.
%
% Copyright (C) 1998 by H. Saadat

j = sqrt(-1);
Vm = input(' Enter stator L-L Voltage in Volts, V = ');
f =  input(' Enter stator frequency  in Hz, f = ');
P =  input(' Enter number of poles, P = ');
R1 = input(' Enter stator resistance/phase in ohms, R1 = ');
X1 = input(' Enter stator reactance/phase in ohms,  X1 = ');
R2 = input(' Enter rotor resistance/phase in ohms, R2'' = ');
X2 = input(' Enter standstill rotor reactance/phase in ohms,  X2'' = ');
Z1 = R1 + j*abs(X1);
Z2s= R2 +j*abs(X2);
Rc = input(' Enter shunt resistance/phase in ohms (if neglected enter inf), RC = ');
Xm = input(' Enter shunt reactance/phase in ohms  (if neglected enter inf). Xm = ');
Xm=j*abs(Xm);
S=999;
while S  > 1 | S  <= 0
 S = input(' Enter the value of slip in per unit, s = ');
   if S > 1 | S <= 0
   fprintf('  S must be equal or less than 1 but greater than 0 '), else, end
end
if S ~= 1
Prot = input(' Enter rotational and stray load losses in Watts, Prot = ');
else,   Prot = 0; end
imsol
imchar

res = 'y';
while  res == 'Y' | res == 'y'
fprintf('\n  Would you like performance characteristics for another slip?')
res = input(' Enter ''Y '' or ''n'' within quotes --> ');
    if res == 'Y' | res == 'y'
       S = 999;
       while S  > 1 | S  <= 0
       S = input(' Enter the value of slip in per unit, s = ');
       if S > 1 | S <= 0
       fprintf('  s must be equal or less than 1 but greater than 0 '), else, end
       imsol
       imchar
       end
    else, end
end
