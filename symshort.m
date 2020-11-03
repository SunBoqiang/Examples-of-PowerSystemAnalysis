% The function iprime = symshort(t, i) defines the differential
% equations of the synchronous machine in Example 8.2 during a
% balanced three-phase fault. The function returns the state
% derivatives of the current.
% Copyright (c) 1998 H. Saadat

function iprime =symfault(t,i)
f=60.;  w=2.*pi*f;
d=0.;   d=d*pi/180.;  theta=w*t+d +pi/2;

%  Parameters of a 160 MVA, 15 kV Synchronous Machine
LF = 2.500;   LD = 0.0068;   LQ = 0.0016;  Ld = 0.0072;   Lq = 0.0070;
MF = 0.100;   MD = 0.0054;   MQ = 0.0026;  MR = 0.1250;
ra = 0.002;   rF = 0.4000;   rD  = 0.015;  rQ = 0.0150;

VF = 400;                % DC field voltage
V = [0; -VF; 0; 0; 0];   % Voltage column vector
k=sqrt(1.5);

R= [ra        0        0  w*Lq   w*k*MQ
    0        rF        0     0        0
    0         0       rD     0        0
   -w*Ld -w*k*MF -w*k*MD    ra        0
    0          0       0     0       rQ];

 L =[Ld   k*MF   k*MD    0      0
     k*MF   LF     MR    0      0
     k*MD   MR     LD    0      0
        0    0      0   Lq    k*MQ
        0    0      0  k*MQ     LQ];

Li=inv(L);
iprime=- Li*V - Li*R*i;
