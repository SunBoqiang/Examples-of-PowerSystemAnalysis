function sctm = sctm
global sctm
a =cos(2*pi/3)+j*sin(2*pi/3);
sctm = [1   1   1; 1 a^2  a; 1 a  a^2];
