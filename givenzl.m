% This program obtains the line performance for a given load impedance.
% Copyright (C) 1998 by H. Saadat

function givenzl(ABCD)
global resp model par1 par2 linelngt freq
if exist('ABCD')~=1
A = input('Enter the complex line constant A = ');
B = input('Enter the complex line constant B = ');
C = input('Enter the complex line constant C = ');
D = A; ABCD=[A B; C D]; end

Vrm = input('Enter receiving end line-line voltage kV = ');
dr = input('Enter receiving end voltage phase angleø (for Ref. enter 0 ) = ');
drrad=dr*pi/180;
Vr = Vrm*(cos(drrad) +j*sin(drrad))/sqrt(3);   % Rec.-end phase voltage
fprintf(' Enter receiving end complex load impedance ');
Zr = input('Rload + j*Xload in ê/phase  Zload = ');
Ir = Vr/Zr;  % Rec. end current  kA
Sr = 3*Vr*conj(Ir); Pr =real(Sr); Qr = imag(Sr);
Irm = abs(Ir)*1000;
angIr = angle(Ir); pfr = cos(drrad - angIr); angIr = angIr*180/pi;
VsIs = ABCD*[Vr; Ir];
Vs = VsIs(1);  Is = VsIs(2);
Vsm = abs(Vs)*sqrt(3);
ds = angle(Vs); dsdg = ds*180/pi;
Ism = abs(Is)*1000;
angIs = angle(Is); pfs = cos(ds - angIs ); angIs = angIs*180/pi;
Ss = 3*Vs*conj(Is);  Ps = real(Ss); Qs = imag(Ss);
Sl = Ss - Sr;  Pl = real(Sl); Ql = imag(Sl);
Reg = 100*(Vsm/abs(ABCD(1,1)) - Vrm)/Vrm;
Eff = Pr/Ps*100;
clc
fprintf(' \n')
fprintf(' Line performance for specified load impedance \n')
fprintf(' ---------------------------------------------  \n')
fprintf(' Vr = %g kV (L-L)', Vrm), fprintf('  at %gø \n', dr)
fprintf(' Ir = %g A', Irm), fprintf('  at %gø', angIr), fprintf('  PFr = %g', pfr)

if abs(Qr) >0.01 & Qr > 0, fprintf(' lagging '),end
if abs(Qr) >0.01 & Qr < 0, fprintf(' leading '),end
fprintf(' \n')
fprintf(' Pr = %g MW', Pr), fprintf('   Qr = %g Mvar \n', Qr)
fprintf(' Vs = %g kV (L-L)', Vsm), fprintf('  at %gø \n', dsdg)
fprintf(' Is = %g A', Ism), fprintf('  at %gø', angIs), fprintf('  PFs = %g', pfs)

if abs(Qs) >0.01 & Qs > 0, fprintf(' lagging '),end
if abs(Qs) >0.01 & Qs < 0, fprintf(' leading '),end
fprintf(' \n')
fprintf(' Ps = %-10.3f MW', Ps), fprintf('   Qs = %-10.3f Mvar \n', Qs)
fprintf(' PL = %-10.3f MW', Pl), fprintf('   QL = %-10.3f Mvar \n', Ql)
fprintf(' Percent Voltage Regulation   = %g \n', Reg),
fprintf(' Transmission line efficiency = %g \n', Eff),
fprintf(' \n Hit return to continue \n')
pause
