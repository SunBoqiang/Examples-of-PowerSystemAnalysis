% This function  Simulates the swing equation of a one-machine system
% and returns the critical clearing time for stability.
%
% Copyrigth (C) 1998 H. Saadat
%
function  cctime(Pm, E, V, X1, X2, X3, H, f)
Pe1max = E*V/X1; Pe2max=E*V/X2; Pe3max=E*V/X3;
d0 =asin(Pm/Pe1max);
dmax = pi-asin(Pm/Pe3max);
cosdc = (Pm*(dmax-d0)+Pe3max*cos(dmax)-Pe2max*cos(d0))/(Pe3max-Pe2max);
  if abs(cosdc) > 1
  fprintf('No critical clearing angle could be found.\n')
  fprintf('System can remain stable during this disturbance.\n\n')
  return
  else, end
dc = acos(cosdc);
  if dc > dmax
  fprintf('No critical clearing angle could be found.\n')
  fprintf('System can remain stable during this disturbance.\n\n')
  return
  else, end
tf = 0.4;
x0 = [d0; 0];
%[t1,xf] =ode23('pfpower', 0, tf, x0, 0.00001);   % use with MATLAB 4
tspan = [0, tf];                                  % use with MATLAB 5
options = odeset('RelTol', 0.00001);              % use with MATLAB 5
[t1,xf] =ode23('pfpower', tspan, x0, options);    % use with MATLAB 5
kk=find(xf(:,1) <= dc); k=max(kk);
tt=t1(k);
while tf <= tt & tf <= 3.6
tf=tf+.4;
   fprintf('\nSearching with a final time of %3.2f Sec. \n', tf)
   tol=0.00001+tf*2.5e-5;
   %[t1,xf] =ode23('pfpower', 0, tf, x0, tol);     % use with MATLAB 4
   tspan = [0, tf];                                % use with MATLAB 5
   options = odeset('RelTol', tol);                % use with MATLAB 5
   [t1,xf] =ode23('pfpower', tspan, x0, options);  % use with MATLAB 5
   kk=find(xf(:,1) <= dc); k=max(kk);
      tt= t1(k);
end
%end
tmargin = t1(k);
if tf >= 3.6
  fprintf('\nA clearing time could not be found up to 4 sec. \n\n')
  return
  else, end
fprintf('\nCritical clearing time =  %4.2f seconds \n', tmargin)
fprintf('Critical clearing angle = %6.2f degrees \n\n', dc*180/pi)
