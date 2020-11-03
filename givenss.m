% This function obtains the line performance for given sending-end
% conditions.
% Copyright (C) 1998 by H. Saadat

function givenss(ABCD)
global resp model par1 par2 linelngt freq
if exist('ABCD')~=1
A = input('Enter the complex line constant A = ');
B = input('Enter the complex line constant B = ');
C = input('Enter the complex line constant C = ');
D = A; ABCD=[A B; C D]; end

Vsm = input('Enter sending end line-line voltage kV = ');
ds = input('Enter sending end voltage phase angleø (for Ref. enter 0 ) = ');
dsrad=ds*pi/180;
Vs = Vsm*(cos(dsrad) +j*sin(dsrad))/sqrt(3);   % Rec.-end phase voltage
Ps = input('Enter sending end 3-phase real power MW = ');
fprintf(' Enter sending end 3-phase reactive power')
Qs = input('(+ for lagging & - for leading power factor) Mvar = ');

Ss = Ps +j*Qs;
Is = conj(Ss)/(3*conj(Vs));  % Rec. end current  kA
Ism = abs(Is)*1000;
angIs = angle(Is); pfs = cos(dsrad - angIs); angIs = angIs*180/pi;
VrIr = inv(ABCD)*[Vs; Is];
Vr = VrIr(1);  Ir = VrIr(2);
Vrm = abs(Vr)*sqrt(3);
dr = angle(Vr); drdg = dr*180/pi;
Irm = abs(Ir)*1000;
angIr = angle(Ir); pfr = cos(dr - angIr ); angIr = angIr*180/pi;
Sr = 3*Vr*conj(Ir);  Pr = real(Sr); Qr = imag(Sr);
Sl = Ss - Sr;  Pl = real(Sl); Ql = imag(Sl);
Reg = 100*(Vsm/abs(ABCD(1,1)) - Vrm)/Vrm;
Eff = Pr/Ps*100;
clc
fprintf(' \n')
fprintf(' Line performance for specified sending end quantities \n')
fprintf(' ----------------------------------------------------- \n')
fprintf(' Vs = %g kV (L-L)', Vsm), fprintf('  at %gø \n', ds)
fprintf(' Ps = %g MW', Ps), fprintf('   Qs = %g Mvar \n', Qs)
fprintf(' Is = %g A', Ism), fprintf('  at %gø', angIs), fprintf('  PFs = %g', pfs)

if abs(Qs) >0.01 & Qs > 0, fprintf(' lagging '),end
if abs(Qs) >0.01 & Qs < 0, fprintf(' leading '),end
fprintf(' \n')
fprintf(' Vr = %g kV (L-L)', Vrm), fprintf('  at %gø \n', drdg)
fprintf(' Ir = %g A', Irm), fprintf('  at %gø', angIr), fprintf('  PFr = %g', pfr)

if abs(Qr) >0.01 & Qr > 0, fprintf(' lagging '),end
if abs(Qr) >0.01 & Qr < 0, fprintf(' leading '),end
fprintf(' \n')
fprintf(' Pr = %-10.3f MW', Pr), fprintf('   Qr = %-10.3f Mvar \n', Qr)
fprintf(' PL = %-10.3f MW', Pl), fprintf('   QL = %-10.3f Mvar \n', Ql)
fprintf(' Percent Voltage Regulation   = %g \n', Reg),
fprintf(' Transmission line efficiency = %g \n', Eff),
fprintf(' \n Hit return to continue \n')
pause
