% The function iprime = llshort(t, i) defines the differential
% equations of the synchronous machine in Example 8.4 during a
% phase-ground fault. The function returns the state derivatives
% of the current.

% Copyright (c) 1998 H. Saadat

function iprime =lgshort(t,i)
f=60.;  w=2.*pi*f;
d=0.;   d=d*pi/180.;  theta=w*t+d +pi/2;

%  Parameters of a 500 MVA, 30 KV Synchronous Machine
LF = 2.500;   LD = 0.0068;   LQ = 0.0016;  Ld = 0.0072;   Lq = 0.0070;
MF = 0.100;   MD = 0.0054;   MQ = 0.0026;  MR = 0.1250;   L0 =0.002;
ra = 0.002;   rF = 0.4000;   rD  = 0.015;  rQ = 0.0150;

VF = 400;                % DC field voltage
V = [0; -VF; 0; 0];      % Voltage column vector
K=sqrt(1.5);

Ls=(L0+Ld+Lq)/3;  Lm=(Ld-Lq)/3;
R=[ra-2*w*Lm*sin(2*theta) -w*MF*sin(theta)   -w*MD*sin(theta)  w*MQ*cos(theta)
        -w*MF*sin(theta)             rF                   0               0
        -w*MD*sin(theta)              0                  rD               0
         w*MQ*cos(theta)              0                   0              rQ];

L=[Ls+Lm*cos(2*theta)  MF*cos(theta)   MD*cos(theta)  MQ*sin(theta)
      MF*cos(theta)                      LF                MR              0
      MD*cos(theta)                      MR                LD              0
      MQ*sin(theta)                       0                 0             LQ];

Li=inv(L);
iprime= -Li*V - Li*R*i;
