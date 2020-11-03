% This function computes the receiving-end voltage of an open-ended
% transmission line.
%
% Copyright (C) 1998 by H. Saadat

function openline(ABCD)
global resp model par1 par2 linelngt freq
if exist('ABCD')~=1
A = input('Enter the complex line constant A = ');
B = input('Enter the complex line constant B = ');
C = input('Enter the complex line constant C = ');
D = A; ABCD=[A B; C D]; end
Vsm = input('Enter sending end line-line voltage kV = ');
ds = input('Enter receiving end voltage phase angleø (for Ref. enter 0 ) = ');
dsrad=ds*pi/180;
Vs = Vsm*(cos(dsrad) +j*sin(dsrad))/sqrt(3);   % Rec.-end phase voltage
Vro = Vs/(ABCD(1,1));
Is = ABCD(2,1)*Vro;
Vrm = abs(Vro)*sqrt(3);
dr = angle(Vro); drdg = dr*180/pi;
Ism = abs(Is)*1000;
angIs = angle(Is); pfs = cos(dsrad - angIs ); angIs = angIs*180/pi;
ths = angIs - ds;
clc
fprintf(' \n')
fprintf(' Open line and shunt reactor compensation \n')
fprintf(' ---------------------------------------- \n')
fprintf(' Vs = %g kV (L-L)', Vsm), fprintf('  at %gø \n', ds)
fprintf(' Vr = %g kV (L-L)', Vrm), fprintf('  at %gø \n', dr)
fprintf(' Is = %g A', Ism), fprintf('  at %gø', angIs), fprintf('  PFs = %g', pfs)

if abs(ths) >0.01 & ths <0, fprintf(' lagging '),end
if abs(ths) >0.01 & ths >0, fprintf(' leading '),end
fprintf(' \n')
  if ABCD(2,1)==0
      shrtline= [
'                                                            '
' Line charging capacitance is zero. A short line is assumed '
' VR(nl) = VS. Shunt reactor compensation is not required.   '
'                                                            '];
  disp(shrtline)
  fprintf(' \n Hit return to continue \n '), pause, return
  else, end
fprintf(' \n Desired no load receiving end voltage ')
VrNL = input(' with shunt reactor compensation kV (L-L) = ');
k = Vsm/VrNL;
Xr =-j*ABCD(1,2)/(k - ABCD(1,1));
Qind = VrNL^2/Xr;
fprintf(' \n Desired no load receiving end voltage = %g kV \n',VrNL)
fprintf(' Shunt reactor reactance = %g ohm \n', Xr)
fprintf(' Shunt reactor rating = %g Mvar \n', Qind)
fprintf(' \n Hit return to continue \n ')
pause
%if exist('linelngt')~=1
if par1 == 3 | par1 == 4
Length = input(' Enter line length = '); else, Length=linelngt; end
Zc = sqrt(ABCD(1,2)/ABCD(2,1));
gama = acosh(ABCD(1,1))/Length;
Vr=VrNL/sqrt(3);
Ir = Vr/(j*Xr);
x=0:Length/50:Length;
a = cosh(gama*x); b = Zc*sinh(gama*x); c = 1/Zc*sinh(gama*x);
Vx = Vr*a + Ir*b;
Ix = Vr*c + Ir*a;
VxL=sqrt(3)*abs(Vx);
Vro = Vs./cosh(gama*x);
Vrm = sqrt(3)*abs(Vro);
vscale1 = 0.9*Vsm;
vscale2 = ceil(max(Vrm)/10)*10;
tx1 = .7*Length; tx2=.75*Length;
ynl= .995*max(Vrm); ycmp=.993*VxL(1);
xl = Length - x;
h = figure;
plot(xl, VxL, x, Vrm,'-'), grid
axis([0 , Length, vscale1, vscale2])
title(['Voltage profile of an unloaded line, XLsh = ', num2str(real(Xr)),' ohms'])
ylabel('Line-Line kV'),
sen = vscale1-.08*(vscale2-vscale1);
rec = Length -.2*Length;
text(0, sen , 'Sending end')
text(rec, sen, 'Receiving end')
text(tx1, ynl, 'Uncompensated')
text(tx2, ycmp, 'Compensated')
pause
fprintf(' \n Hit return to continue \n ')
