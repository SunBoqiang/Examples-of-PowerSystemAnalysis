% This function Obtains the symmetrical components of a 3x3 impedance matrix

% Copyright  (c) 1998 H. Saadat

function [Z012] = zabc2sc(Zabc)
a =cos(2*pi/3)+j*sin(2*pi/3);
A = [1   1   1; 1 a^2  a; 1 a  a^2];
Z012=inv(A)*Zabc*A;
