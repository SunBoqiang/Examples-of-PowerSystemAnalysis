% This function returns the ABCD constants when the pi model parameters
% are specified.
% Copyright (C) 1998 by H. Saadat.

function [Z, Y, ABCD] = pi2abcd(Z, Y);
global resp model par1 par2 linelngt freq
par1=3;
if exist('Z')~=1
Z = input('Enter total series impedance R + j*R in ohms, Z = '); else end
if exist('Y')~=1
Y = input('Enter total shunt admittance G + j*B in siemens, Y = '); else end
model = -1;
if imag(Y)==0, Zc= 0; model =1, else, Zc = sqrt(Z/Y); Gamal=sqrt(Z*Y); ,end

while model ~= 1 & model ~=2
   model=input(' Enter 1 for medium line or 2 for long line -> ');
   if model ~=1 & model ~=2
   disp(' Enter 1 or 2 '), else, end
end
if model == 2
Z = Z*sinh(Gamal)/Gamal; Y = Y*tanh(Gamal/2)/(Gamal/2);
else, end
fprintf(' \n'), disp(' pi to ABCD')
disp(' ----------')
fprintf('\n'), fprintf(' Z = %g + j ',real(Z)), fprintf('%g ohms\n',imag(Z)),
fprintf(' Y = %g + j ',real(Y)), fprintf('%g Siemens\n',imag(Y))

A = 1 + Z*Y/2;  B = Z;
C = Y*(1 + Z*Y/4);  D = A;
ABCD = [A B; C D] ;
 disp(' ')
 fprintf('         %-11.5g + j', real(A)), fprintf(' %-11.5g', imag(A))
 fprintf('   %-11.5g + j', real(B)), fprintf(' %-11.5g  \n', imag(B))
 fprintf(' ABCD =                                                             \n')
 fprintf('         %-11.5g + j', real(C)), fprintf(' %-11.5g', imag(C))
 fprintf('   %-11.5g + j', real(D)), fprintf(' %-11.5g   \n', imag(D))
