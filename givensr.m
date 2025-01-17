% This function obtains the line performance for given receiving-end
% conditions.
%Copyright (C) 1998 by H. Saadat

function givensr(ABCD)
global resp model par1 par2 linelngt freq
if exist('ABCD')~=1
A = input('Enter the complex line constant A = ');
B = input('Enter the complex line constant B = ');
C = input('Enter the complex line constant C = ');
D = A; ABCD=[A B; C D]; end
Vrm = input('Enter receiving end line-line voltage kV = ');
dr = input('Enter receiving end voltage phase angle� (for Ref. enter 0 ) = ');
drrad=dr*pi/180;
Vr = Vrm*(cos(drrad) +j*sin(drrad))/sqrt(3);   % Rec.-end phase voltage
Pr = input('Enter receiving end 3-phase real power MW = ');
fprintf(' Enter receiving end 3-phase reactive power')
Qr = input('(+ for lagging & - for leading power factor) Mvar = ');
Sr = Pr +j*Qr;
Ir = conj(Sr)/(3*conj(Vr));  % Rec. end current  kA
Irm = abs(Ir)*1000;
angIr = angle(Ir); pfr = cos(drrad - angIr); angIr = angIr*180/pi;
VsIs = ABCD*[Vr; Ir];
Vs = VsIs(1);  Is = VsIs(2);
Vsm = abs(Vs)*sqrt(3);
ds = angle(Vs); dsdg = ds*180/pi;
Ism = abs(Is)*1000;
angIs = angle(Is); pfs = cos(ds - angIs );  angIs = angIs*180/pi;
Ss = 3*Vs*conj(Is);  Ps = real(Ss); Qs = imag(Ss);
Sl = Ss - Sr;  Pl = real(Sl); Ql = imag(Sl);
Reg = 100*(Vsm/abs(ABCD(1,1)) - Vrm)/Vrm;
Eff = Pr/Ps*100;
clc
fprintf(' \n')
fprintf(' Line performance for specified receiving end quantities \n')
fprintf(' ------------------------------------------------------- \n')
fprintf(' Vr = %g kV (L-L)', Vrm), fprintf('  at %g� \n', dr)
fprintf(' Pr = %g MW', Pr), fprintf('   Qr = %g Mvar \n', Qr)
fprintf(' Ir = %g A', Irm), fprintf('  at %g�', angIr), fprintf('  PFr = %g', pfr)

if abs(Qr) >0.01 & Qr > 0, fprintf(' lagging '),end
if abs(Qr) >0.01 & Qr < 0, fprintf(' leading '),end
fprintf(' \n')

fprintf(' Vs = %g kV (L-L)', Vsm), fprintf('  at %g� \n', dsdg)
fprintf(' Is = %g A', Ism), fprintf('  at %g�', angIs), fprintf('  PFs = %g', pfs)

if abs(Qs) >0.01 & Qs > 0, fprintf(' lagging '),end
if abs(Qs) >0.01 & Qs < 0, fprintf(' leading '),end
fprintf(' \n')

fprintf(' Ps = %-10.3f MW', Ps), fprintf('   Qs = %-10.3f Mvar \n', Qs)
fprintf(' PL = %-10.3f MW', Pl), fprintf('   QL = %-10.3f Mvar \n', Ql)
fprintf(' Percent Voltage Regulation   = %g \n', Reg)
fprintf(' Transmission line efficiency = %g \n', Eff)
fprintf(' \n Hit return to continue \n')
pause
