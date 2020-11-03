% This program solves the swing equation of a one-machine system
% when subjected to a three-phase fault with subsequent clearance
% of the fault. Modified Euler method
%
% Copyright (c) 1998 H. Saadat
%
function swingmeu(Pm, E, V, X1, X2, X3, H, f, tc, tf, Dt)
%global  Pm f H E V X1 X2 X3
clear t
if exist('Pm')~=1
Pm = input('Generator output power in p.u. Pm = '); else, end
if exist('E')~=1
E = input('Generator e.m.f. in p.u. E = '); else, end
if exist('V')~=1
V = input('Infinite bus-bar voltage in p.u. V = '); else, end
if exist('X1')~=1
X1 = input('Reactance before Fault in p.u. X1 = '); else, end
if exist('X2')~=1
X2 = input('Reactance during Fault X2 = '); else, end
if exist('X3')~=1
X3 = input('Reactance after Fault X3 = '); else, end
if exist('H')~=1
H  = input('Generator Inertia constant in sec. H = '); else, end
if exist('f')~=1
f  = input('System frequency in Hz f = '); else, end
if exist('Dt')~=1
Dt = input('Time interval  Dt = '); else, end
if exist('tc')~=1
tc = input('Clearing time of fault in sec tc = '); else, end
if exist('tf')~=1
tf = input('Final time for swing equation in sec tf = '); else, end
Pe1max = E*V/X1; Pe2max=E*V/X2; Pe3max=E*V/X3;
clear t x1 x2  delta
d0 =asin(Pm/Pe1max);
t(1) = 0;
x1(1)= d0;
x2(1)=0;
np=tf /Dt;
Pemax=Pe2max;
ck=pi*f/H;
for k = 1:np
    if t(k) >= tc
    Pemax=Pe3max;
    else, end
t(k+1)=t(k)+Dt;

Dx1b=x2(k);
Dx2b=ck*(Pm-Pemax*sin(x1(k)));
x1(k+1)=x1(k)+Dx1b*Dt;
x2(k+1)=x2(k)+Dx2b*Dt;
Dx1e=x2(k+1);
Dx2e=ck*(Pm-Pemax*sin(x1(k+1)));
Dx1=(Dx1b+Dx1e)/2;
Dx2=(Dx2b+Dx2e)/2;
x1(k+1)=x1(k)+Dx1*Dt;
x2(k+1)=x2(k)+Dx2*Dt;
end
delta=180*x1/pi;

clc
fprintf('\nFault is cleared at %4.3f Sec. \n', tc)
head=['                              '
      '     time     delta      Dw   '
      '      s       degrees    rad/s'
      '                              '];
disp(head)
disp([t', delta' x2'])
h=figure; figure(h)
plot(t, delta), grid
title(['One-machine system swing curve. Fault cleared at ', num2str(tc),'s'])
xlabel('t, sec'), ylabel('Delta, degree')
cctime(Pm, E, V, X1, X2, X3, H, f)    % Obtains the critical clearing time
