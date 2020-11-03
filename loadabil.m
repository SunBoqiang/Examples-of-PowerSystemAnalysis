% This function obtains the line loadability curve for a transmission line.
% Copyright (C) 1998  by H. Saadat.

function loadabil(L, C, f)
global resp model par1 par2 linelngt freq
diary off
fprintf(' \n')
fprintf(' Loadability curve of a lossless line (up to 1/4 wavelength \n')
fprintf(' ---------------------------------------------------------- \n')

%if exist('r')~=1
%  r = input('Enter line resistance in ohms/km = '); else end
r = 0;
if exist('L')~=1
    L = input('Enter line inductance  in millihenry/km = '); else end
if exist('C')~=1
    C = input('Enter line capacitance in microfarad/km = '); else end
    if exist('f')~=1
    f = input('Enter line frequency in Hz f = '); else end
  if C==0
  shrtline = [
'                                                            '
' Line charging capacitance is zero. A short line is assumed.'
' A loadability curve is not obtained for a short line.      '
'                                                            '];
  disp(shrtline)
  fprintf(' \n Hit return to continue \n')
  pause, return
  else, end
w=2*pi*f;
z= r + j*w*L*1E-03;  y = j*w*C*1E-06;
Zc = sqrt(z/y); gama = sqrt(z*y); beta = imag(gama);

lamda = 2*pi/beta;
del=30;
delta = del*pi/180;

Vsm = input('Enter sending end line-line voltage kV = ');
Vrm = input('Enter receiving end line-line voltage kV = ');
Vrate = input('Enter rated line-line voltage kV = ');
Ith = input('Enter line current-carrying capacity, Amp/phase = ');

Vs = Vsm/sqrt(3);  Vr = Vrm/sqrt(3);
Vrateph = Vrate/sqrt(3);
SIL = Vrate^2/Zc;
Vspu = Vsm/Vrate;  Vrpu = Vrm/Vrate;

Kc = Vspu*Vrpu*SIL;
dist1=50:10: lamda/4;
dist2=100:10: lamda/4;
dist3=0:10:lamda/4;
P = Kc*sin(delta)./sin(beta*dist1);
Pmax = Kc./sin(beta*dist2);
mP= P/SIL;
mPmax= Pmax/SIL;
tx = 0.5*lamda/4;
ty1 = Kc*sin(delta)/sin(beta*tx)/SIL;
ty2 = Kc/sin(beta*tx)/SIL;
Pth = sqrt(3)*Vrate*Ith*1E-3;
mPth = Pth/SIL*ones(1, length(dist3));
ty3 = 1.02*Pth/SIL;
h=figure;
plot(dist1, mP, dist2, mPmax,'-', dist3, mPth,'-'), grid

xlabel('Line length');
ylabel('P.U. SIL')
title('Loadability curve for length up to 1/4 wavelength')
text(0.45*tx, .9*mP(1), ['SIL = ',num2str(SIL), 'MW, ',' delta = ',num2str(del), 'degrees'])
text(tx, ty1+.2, ['Practical line loadability'])
text(tx, ty2+.2, 'Theoretical stability limit')
text(tx, ty3+.2, 'Thermal limit')
pause
fprintf(' \n Hit return to continue \n')
pause
