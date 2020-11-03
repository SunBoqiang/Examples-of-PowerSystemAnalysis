% This function obtains the pi model of a transmission line
% from the ABCD constants of the line.
%
% Copyright (C)  1998 by H. Saadat

function [Z, Y, ABCD] = abcd2pi(A, B, C)
global resp model par1 par2 linelngt freq
par1=4;
if exist('A')~=1
A = input('Enter the complex line constant A = '); else end
if exist('B')~=1
B = input('Enter the complex line constant B = '); else end
if exist('C')~=1
C = input('Enter the complex line constant C = '); else end
D = A;
Z = B; Y = 2*C/(A+1); if imag(Y) ~= 0, Zc = sqrt(Z/Y);else, end
ABCD = [A  B; C  D];
disp(' '),  disp(' Two port model, ABCD constants'),
disp(' ----------------------------')
disp(' ')
fprintf('         %-11.5g + j', real(A)), fprintf(' %-11.5g', imag(A))
fprintf('   %-11.5g + j', real(B)), fprintf(' %-11.5g  \n', imag(B))
fprintf(' ABCD =                                                             \n')
fprintf('         %-11.5g + j', real(C)), fprintf(' %-11.5g', imag(C))
fprintf('   %-11.5g + j', real(D)), fprintf(' %-11.5g   \n', imag(D))
fprintf(' \n Z = %g + j' ,real(Z)), fprintf(' %g ohms \n', imag(Z))
fprintf(' Y = %g + j' ,real(Y)), fprintf(' %g siemens \n', imag(Y))
