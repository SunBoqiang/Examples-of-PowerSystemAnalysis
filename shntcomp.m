% This function computes the shunt capacitor compensation required
% for an specified receiving-end voltage.
%
% Copyright (C) 1998 by H. Saadat

function shntcomp(ABCD)
global resp model par1 par2 linelngt freq
diary off
if exist('ABCD')~=1
A = input('Enter the complex line constant A = ');
B = input('Enter the complex line constant B = ');
C = input('Enter the complex line constant C = ');
D = A; ABCD=[A B; C D]; end
Vsm = input('Enter sending end line-line voltage kV = ');
Vrm = input('Enter desired receiving end line-line voltage kV = ');
dr = input('Enter receiving end voltage phase angle� (for Ref. enter 0 ) = ');
drrad=dr*pi/180;
Vr = Vrm*(cos(drrad) +j*sin(drrad))/sqrt(3);   % Rec.-end phase voltage
Pr = input('Enter receiving end 3-phase real power MW = ');
%r = input('Enter receiving end 3-phase reactive power (+ for lagging & - for leading  power factor ) Mvar = ');
fprintf(' Enter receiving end 3-phase reactive power')
Qload = input('(+ for lagging & - for leading power factor) Mvar = ');
Sload = Pr +j*Qload;
ba = angle( ABCD(1,2) )- angle(ABCD(1,1));
S1 = Vsm*Vrm/abs(ABCD(1,2)); S2 = abs(ABCD(1,1))*Vrm^2/abs(ABCD(1,2));
bd = acos( (Pr + S2*cos(ba))/S1 );
Qr = S1*sin(bd) - S2*sin(ba);
Qc = Qr - Qload;
Sr = Pr + j*Qr;
Xc = Vrm^2/abs(Qc); Cap = 1000000/(2*pi*60*Xc)
Ir = conj(Sr)/(3*conj(Vr));  % Rec. end current  kA
Irm = abs(Ir)*1000;
angIr = angle(Ir); pfr = cos(drrad - angIr); angIr = angIr*180/pi;
Iload = conj(Sload)/(3*conj(Vr));  % Rec. end current  kA
Iloadm = abs(Iload)*1000;
angIl = angle(Iload); pfl = cos(drrad - angIl); angIl = angIl*180/pi;
Ic = Ir - Iload;
Icm = abs(Ic)*1000;
angIc= angle(Ic)*180/pi;
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
fprintf(' Shunt capacitive compensation \n')
fprintf(' ----------------------------- \n')
fprintf(' Vs = %g kV (L-L)', Vsm), fprintf('  at %g� \n', dsdg)
fprintf(' Vr = %g kV (L-L)', Vrm), fprintf('  at %g� \n', dr)
fprintf(' Pload = %g MW', Pr), fprintf('   Qload = %g Mvar \n', Qload)
fprintf(' Load current = %g A', Iloadm), fprintf('  at %g�', angIl), fprintf('  PFl = %g', pfl)
if Qload > 0, fprintf(' lagging \n'),elseif Qload < 0 fprintf(' leading \n'), end
fprintf(' Required shunt capcitor: %g ohm,', Xc)
fprintf('  %g micro F,',Cap), fprintf('  %g Mvar \n', abs(Qc))
fprintf(' Shunt capacitor current = %g A', Icm), fprintf('  at %g� \n', angIc)
fprintf(' Pr = %-10.3f MW', Pr), fprintf('   Qr = %-10.3f Mvar \n', Qr)
fprintf(' Ir = %g A', Irm), fprintf('  at %g�', angIr), fprintf('  PFr = %g', pfr)
if abs(Qr) >0.01 & Qr > 0, fprintf(' lagging '),end
if abs(Qr) >0.01 & Qr < 0, fprintf(' leading '),end
fprintf(' \n')
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
