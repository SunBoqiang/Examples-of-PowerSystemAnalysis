% This function obtains the voltage profile for a transmission line.
%
% Copyright (C) 1998 by H. Saadat

function vprofile(r, L, C, f)
global resp model par1 par2 linelngt freq
fprintf(' \n')
fprintf(' Voltage profile for line length up to 1/8 wavelength \n')
fprintf(' ---------------------------------------------------- \n')

if exist('r')~=1
    r = input('Enter line resistance in ohms/km = '); else end
if exist('L')~=1
    L = input('Enter line inductance in millihenry/km = '); else end
if exist('C')~=1
    C = input('Enter line capacitance in microfarad/km = '); else end
    if exist('f')~=1
    f = input('Enter line frequency in Hz f = '); else end

  if C == 0
  shrtline =[
'                                                             '
' Line charging capacitance is zero. A short line is assumed. '
' A voltage profile is not obtained for a short line.         '
'                                                             '];
  disp(shrtline)
  fprintf(' \n Hit return to continue \n')
  pause, return
  else, end

w=2*pi*f;
z= r + j*w*L*1E-03;  y = j*w*C*1E-06;
Zc = sqrt(z/y); gama = sqrt(z*y); beta = imag(gama);
lamda = 2*pi/beta;
Vsm = input('Enter sending end line-line voltage kV = ');
MVArat = input('Enter rated sending end power, MVA = ');
pfrat = input('Enter power factor  = ');
Vs = Vsm/sqrt(3);
dist3 = 0:10:lamda/8;
Vrnl = abs(Vsm./cosh(gama*dist3));
Vrsil = Vsm./abs(cosh(gama*dist3)+sinh(gama*dist3));
Vmax = ceil(max(Vrnl/100))*100;
dismax=  ceil(max(dist3/100))*100*1.1;
tx = max(dist3);
ynl = abs(Vsm./cosh(gama*lamda/8));
ysil= Vsm./abs(cosh(gama*lamda/8)+sinh(gama*lamda/8));
Is =cosh(gama*lamda/8)*Vs/(Zc*sinh(gama*lamda/8));
Vshrt = Vs*cosh(gama*dist3)-Zc*Is*sinh(gama*dist3);
Vshrt= sqrt(3)*abs(Vshrt);
yshrt= min(Vshrt);

th = acos(pfrat);
Srate = MVArat*(cos(th)+j*sin(th));
Is =conj(Srate)/(3*Vs);
Vrc = Vs*cosh(gama*dist3) - Zc*Is*sinh(gama*dist3);
Vrc = sqrt(3)*abs(Vrc);
yfl = sqrt(3)*abs(Vs*cosh(gama*lamda/8) - Zc*Is*sinh(gama*lamda/8));

h=figure;
plot(dist3, Vrnl, dist3, Vrsil, '-', dist3, Vshrt,'-', dist3, Vrc,'-'), grid

axis([0  dismax  0 Vmax]);
ylabel('Vr')
title(['Voltage profile for length up to 1/8 wavelength, Zc = ',num2str(real(Zc)), ' ohm'])
text(tx, ynl, 'No-load')
text(tx, ysil, 'SIL')
text(tx, yshrt+25, 'Short-ckt')
text(tx, yfl, 'Rated load')
xsc= tx/dismax*.96;
%text(0.11, 0.05, 'Sending end','sc')
text(0.11, -80, 'Sending end')
text(tx, -80, 'Receiving end')
pause
fprintf(' \n Hit return to continue \n')
pause
%axis('auto');
