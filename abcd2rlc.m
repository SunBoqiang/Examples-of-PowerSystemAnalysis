% This function computes the r, L, and C in per unit length from the ABCD
% constants of a transmission line.
%
% Copyright (C) 1998 by H. Saadat

function [r, L, C, f] = abcd2rlc(ABCD)
global resp model par1 par2 linelngt freq
if exist('ABCD')~=1
A = input('Enter the complex line constant A = ');
B = input('Enter the complex line constant B = ');
C = input('Enter the complex line constant C = ');
D = A;
ABCD = [A  B; C  D];else, end
Length = input('Enter line length = '); linelngt= Length;
f = input('Enter line frequency = ');
freq=f;
w= 2*pi*f;
Zc = sqrt(ABCD(1,2)/ABCD(2,1));
Gama = asinh(ABCD(1,2)/Zc)/Length;
z = Zc*Gama;
y = z/Zc^2;
r = real(z);
L = imag(z)/w*1000;
C = imag(y)/w*1000000;
