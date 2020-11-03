% This program solves the swing equation of a one-machine system
% when subjected to a three-phase fault with subsequent clearance
% of the fault.
%
% Copyright  (c) 1998  H. Saadat
%
function swingrk4(Pm, E, V, X1, X2, X3, H, f, tc, tf, Dt)
%global  Pm f H E V X1 X2 X3
if exist('Pm') ~= 1
Pm = input('Generator output power in p.u. Pm = '); else, end
if exist('E') ~= 1
E = input('Generator e.m.f. in p.u. E = '); else, end
if exist('V') ~= 1
V = input('Infinite bus-bar voltage in p.u. V = '); else, end
if exist('X1') ~= 1
X1 = input('Reactance before Fault in p.u. X1 = '); else, end
if exist('X2') ~= 1
X2 = input('Reactance during Fault X2 = '); else, end
if exist('X3') ~= 1
X3 = input('Reactance after Fault X3 = '); else, end
if exist('H') ~= 1
H  = input('Generator Inertia constant in sec. H = '); else, end
if exist('f') ~= 1
f  = input('System frequency in Hz f = '); else, end
if exist('tc') ~= 1
tc = input('Clearing time of fault in sec tc = '); else, end
if exist('tf') ~= 1
tf = input('Final time for swing equation in sec tf = '); else, end

Pe1max = E*V/X1; Pe2max=E*V/X2; Pe3max=E*V/X3;
clear t  x  delta
d0 =asin(Pm/Pe1max);
t0 = 0;
x0 = [d0;  0];
tol=0.001;
%[t1,xf]=ode45('pfpower', t0, tc, x0, tol); % During fault solution (use with MATLAB 4)
tspan = [t0; tc];                            % use with MATLAB 5
[t1,xf]=ode45('pfpower', tspan, x0); % During fault solution (use with MATLAB 5)

x0c =xf(length(xf), :);
%[t2,xc] =ode45('afpower', tc, tf, x0c, tol); % After fault solution (use with MATLAB 4)
tspan = [tc, tf];                            % use with MATLAB 5
[t2,xc] =ode45('afpower', tspan, x0c); % After fault solution (use with MATLAB 5)
t =[t1; t2]; x = [xf; xc];
delta = 180/pi*x(:,1);
clc
fprintf('\nFault is cleared at %4.3f Sec. \n', tc)
head=['                              '
      '     time     delta      Dw   '
      '      s       degrees    rad/s'
      '                              '];
disp(head)
disp([t, delta, x(:, 2)])
h=figure; figure(h)
plot(t, delta), grid
title(['One-machine system swing curve. Fault cleared at ', num2str(tc),'s'])
xlabel('t, sec'), ylabel('Delta, degree')
cctime(Pm, E, V, X1, X2, X3, H, f)    % Obtains the critical clearing time
