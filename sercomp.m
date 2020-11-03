% This function determines the line performance for a given
% series capacitor compensation.
% Copyright (C) 1998 by H. Saadat

function sercomp(ABCD)
global resp model par1 par2 linelngt freq
if exist('ABCD')~=1
A = input('Enter the complex line constant A = ');
B = input('Enter the complex line constant B = ');
C = input('Enter the complex line constant C = ');
D = A; ABCD=[A B; C D]; end
if exist('freq')~=1
f = input('Enter frequency in Hz = '); else, f = freq; end
Z = ABCD(1,2); Y = 2*ABCD(2,1)/(ABCD(1,1)+1);
Vrm = input('Enter receiving end line-line voltage kV = ');
dr = input('Enter receiving end voltage phase angleø (for Ref. enter 0 ) = ');
drrad=dr*pi/180;
Vr = Vrm*(cos(drrad) +j*sin(drrad))/sqrt(3);   % Rec.-end phase voltage
Pr = input('Enter receiving end 3-phase real power MW = ');

fprintf(' Enter receiving end 3-phase reactive power')
Qr = input('(+ for lagging & - for leading power factor) Mvar = ');

fprintf(' Enter percent compensation for series capacitor')
kc= input('(recommnded range 25 to 75% of the line reactance) = ');
Xc = -j*kc*imag(Z)/100;  caps = 1000000/(2*pi*60*abs(Xc));
Z2 = Z + Xc;
ssrf=f*sqrt(abs(Xc)/imag(Z));
ABCDnu = [1+Z2*Y/2  Z2; Y*(1+Z2*Y/4) 1+Z2*Y/2];
Sr = Pr +j*Qr;
Ir = conj(Sr)/(3*conj(Vr));  % Rec. end current  kA
Irm = abs(Ir)*1000;
angIr = angle(Ir); pfr = cos(drrad - angIr); angIr = angIr*180/pi;
VsIs = ABCDnu*[Vr; Ir];
Vs = VsIs(1);  Is = VsIs(2);
Vsm = abs(Vs)*sqrt(3);
ds = angle(Vs); dsdg = ds*180/pi;
Ism = abs(Is)*1000;
angIs = angle(Is); pfs = cos(ds - angIs ); angIs = angIs*180/pi;
Ss = 3*Vs*conj(Is);  Ps = real(Ss); Qs = imag(Ss);
Sl = Ss - Sr;  Pl = real(Sl); Ql = imag(Sl);
Iline = Ir + Y/2*Vr;
Qcap =  abs(Xc)*(abs(Iline))^2;
Reg = 100*(Vsm/abs(ABCDnu(1,1)) - Vrm)/Vrm;
Eff = Pr/Ps*100;
clc
fprintf(' \n')
fprintf(' Series capacitor compensation \n')
fprintf(' ----------------------------- \n')
fprintf(' Vr = %g kV (L-L)', Vrm), fprintf('  at %gø \n', dr)
fprintf(' Pr = %g MW', Pr), fprintf('   Qr = %g Mvar \n', Qr)
fprintf(' Required series capacitor:  %g ohm,', abs(Xc))
fprintf('   %g micro F,', caps), fprintf('   %g Mvar \n', Qcap)
fprintf(' Subsynchronous resonant frequency = %g Hz \n', ssrf)
fprintf(' Ir = %g A', Irm), fprintf('  at %gø', angIr), fprintf('  PFr = %g', pfr)
if abs(Qr) >0.01 & Qr > 0, fprintf(' lagging '),end
if abs(Qr) >0.01 & Qr < 0, fprintf(' leading '),end
fprintf(' \n')
fprintf(' Vs = %g kV (L-L)', Vsm), fprintf('  at %gø \n', dsdg)
fprintf(' Is = %g A', Ism), fprintf('  at %gø', angIs), fprintf('  PFs = %g', pfs)
if abs(Qs) >0.01 & Qs > 0, fprintf(' lagging '),end
if abs(Qs) >0.01 & Qs < 0, fprintf(' leading '),end
fprintf(' \n')
fprintf(' Ps = %-10.3f MW', Ps), fprintf('   Qs = %-10.3f Mvar \n', Qs)
fprintf(' PL = %-10.3f MW', Pl), fprintf('   QL = %-10.3f Mvar \n', Ql)
fprintf(' Percent Voltage Regulation   = %g \n', Reg)
fprintf(' Transmission line efficiency = %g \n', Eff)
fprintf(' \n Hit return to continue \n')
pause
