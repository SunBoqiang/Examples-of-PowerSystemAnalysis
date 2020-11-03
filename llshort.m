% The function iprime = llshort(t, i) defines the differential
% equations of the synchronous machine in Example 8.3 during a
% phase-phase fault. The function returns the state derivatives
% of the current.
% Copyright  (c) 1998 H. Saadat

function iprime =llshort(t,i)
f=60.;  w=2.*pi*f;
d=0.;   d=d*pi/180.;  theta=w*t+d +pi/2;

%  Parameters of a 500 MVA, 30 kV Synchronous Machine
LF = 2.500;   LD = 0.0068;   LQ = 0.0016;  Ld = 0.0072;   Lq = 0.0070;
MF = 0.100;   MD = 0.0054;   MQ = 0.0026;  MR = 0.1250;
ra = 0.002;   rF = 0.4000;   rD  = 0.015;  rQ = 0.0150;

VF = 400;                % dc field voltage
V = [-VF; 0; 0; 0];   % Voltage column vector
K=sqrt(1.5);  RT2=sqrt(2.0);

R=[RT2*K*w*MF*cos(theta)        rF          0               0
   RT2*K*w*MD*cos(theta)        0           rD              0
   RT2*K*w*MQ*sin(theta)        0           0              rQ
   RT2*(ra+w*(Ld-Lq)*sin(2*theta))   K*w*MF*cos(theta)  K*w*MD*cos(theta) ...
   K*w*MQ*sin(theta)];

L=[RT2*K*MF*sin(theta)          LF         MR         0
   RT2*K*MD*sin(theta)          MR         LD         0
  -RT2*K*MQ*cos(theta)           0          0        LQ
   RT2*(Ld*sin(theta)^2+Lq*cos(theta)^2)  K*MF*sin(theta)  K*MD*sin(theta) ...
  -K*MQ*cos(theta)];

Li=inv(L);
iprime=-Li*V - Li*R*i;
