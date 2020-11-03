%    From  To   R    X
z = [ 0    1    0   1.0
      0    2    0   0.8
      1    2    0   0.4
      1    3    0   0.2
      2    3    0   0.2
      3    4    0   0.08];
 [Ybus] = ybus(z)                         % bus admittance matrix
Ibus = [-j*1.1; -j*1.25; 0; 0]; % vector of injected bus currents
Zbus = inv(Ybus)                           % bus impedance matrix
Vbus = Zbus*Ibus
%Vbus = Ybus\Ibus
