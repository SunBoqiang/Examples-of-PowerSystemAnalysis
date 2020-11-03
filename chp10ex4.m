Vabc=[200    25
      100  -155
       80   100];
Zabc =[8+j*24     j*4     j*4
          j*4  8+j*24     j*4
         j*4      j*4  8+j*24];
Z012 = zabc2sc(Zabc)          % Symmetrical components of impedance
V012 = abc2sc(Vabc);            % Symmetrical components of voltage
V012p= rec2pol(V012)  % Converts rectangular phasors to polar forms
I012 = inv(Z012)*V012 ;         % Symmetrical components of current
I012p= rec2pol(I012)  % Converts rectangular phasors to polar forms
Iabc = sc2abc(I012);                               % Phase currents
Iabcp= rec2pol(Iabc)  % Converts rectangular phasors to polar forms
S3ph = 3*(V012.')*conj(I012)  %  Power using symmetrical components
Vabcr = Vabc(:,1).*(cos(pi/180*Vabc(:,2))+j*sin(pi/180*Vabc(:,2)));
S3ph=(Vabcr.')*conj(Iabc) % Power using phase currents and voltages
