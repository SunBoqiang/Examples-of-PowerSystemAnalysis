% This function computes the shunt capacitor compensation required
% for an specified receiving-end voltage and a given series capacitor
% compensation.
% Copyright (C) 1998 by H. Saadat.

function srshcomp(ABCD)
global resp model par1 par2 linelngt freq
if exist('ABCD')~=1
A = input('Enter the complex line constant A = ');
B = input('Enter the complex line constant B = ');
C = input('Enter the complex line constant C = ');
D = A; ABCD=[A B; C D]; end
if exist('freq')~=1
f = input('Enter frequency in Hz = '); else f = freq; end
Z = ABCD(1,2); Y = 2*ABCD(2,1)/(ABCD(1,1)+1);

Vsm = input('Enter sending end line-line voltage kV = ');
Vrm = input('Enter desired receiving end line-line voltage kV = ');
dr = input('Enter receiving end voltage phase angleø (for Ref. enter 0 ) = ');
drrad=dr*pi/180;
Vr = Vrm*(cos(drrad) +j*sin(drrad))/sqrt(3);   % Rec.-end phase voltage
Pr = input('Enter receiving end 3-phase real power MW = ');
fprintf(' Enter receiving end 3-phase reactive power')
Qload = input('(+ for lagging & - for leading power factor) Mvar = ');
Sload = Pr +j*Qload;
fprintf(' Enter percent compensation for series capacitor')
kc= input('(recommended range 25 to 75% of the line reactance) = ');
Xcsr = -j*kc*imag(Z)/100;  csr = 1000000/(2*pi*60*abs(Xcsr));
Z2 = Z + Xcsr;
ssrf = f*sqrt(abs(Xcsr)/imag(Z));
ABCDnu = [1+Z2*Y/2  Z2; Y*(1+Z2*Y/4) 1+Z2*Y/2];
ba = angle( ABCDnu(1,2) )- angle(ABCDnu(1,1));
S1 = Vsm*Vrm/abs(ABCDnu(1,2)); S2 = abs(ABCDnu(1,1))*Vrm^2/abs(ABCDnu(1,2));
bd = acos( (Pr + S2*cos(ba))/S1 );
Qr = S1*sin(bd) - S2*sin(ba);
Qcsh = Qr - Qload;
Sr = Pr + j*Qr;
Xcsh = Vrm^2/abs(Qcsh); csh = 1000000/(2*pi*60*Xcsh)

Ir = conj(Sr)/(3*conj(Vr));  % Rec. end current  kA
Irm = abs(Ir)*1000;
angIr = angle(Ir); pfr = cos(drrad - angIr); angIr = angIr*180/pi;

Iload = conj(Sload)/(3*conj(Vr));  % Rec. end current  kA
Iloadm = abs(Iload)*1000;
angIl = angle(Iload); pfl = cos(drrad - angIl); angIl = angIl*180/pi;
Icsh = Ir - Iload;
Icshm = abs(Icsh)*1000;
angIc= angle(Icsh)*180/pi;

VsIs = ABCDnu*[Vr; Ir];
Vs = VsIs(1);  Is = VsIs(2);
Vsm = abs(Vs)*sqrt(3);
ds = angle(Vs); dsdg = ds*180/pi;
Ism = abs(Is)*1000;
angIs = angle(Is); pfs = cos(ds - angIs ); angIs = angIs*180/pi;
Ss = 3*Vs*conj(Is);  Ps = real(Ss); Qs = imag(Ss);
Sl = Ss - Sr;  Pl = real(Sl); Ql = imag(Sl);
Iline = Ir + Y/2*Vr;
Qcsr =  abs(Xcsr)*(abs(Iline))^2;
Reg = 100*(Vsm/abs(ABCDnu(1,1)) - Vrm)/Vrm;
Eff = Pr/Ps*100;
clc
fprintf(' \n')
fprintf(' Series and shunt capacitor compensation \n')
fprintf(' --------------------------------------- \n')
fprintf(' Vs = %g kV (L-L)', Vsm), fprintf('  at %gø \n', dsdg)
fprintf(' Vr = %g kV (L-L)', Vrm), fprintf('  at %gø \n', dr)
fprintf(' Pload = %g MW', Pr), fprintf('   Qload = %g Mvar \n', Qload)
fprintf(' Load current = %g A', Iloadm), fprintf('  at %gø', angIl), fprintf('  PFl = %g', pfl)
if Qload > 0, fprintf(' lagging \n'),elseif Qload < 0 fprintf(' leading \n'), end
fprintf(' Required shunt capcitor: %g ohm,',Xcsh)
fprintf('  %g micro F,', csh), fprintf(' %g Mvar \n', abs(Qcsh))
fprintf(' Shunt capacitor current = %g A', Icshm), fprintf('  at %gø \n', angIc)
fprintf(' Required series capacitor: %g ohm,', abs(Xcsr))
fprintf('  %g micro F,', csr), fprintf(' %g Mvar \n', Qcsr)
fprintf(' Subsynchronous resonant frequency = %g Hz \n', ssrf)
fprintf(' Pr = %g MW', Pr), fprintf('   Qr = %g Mvar \n', Qr)
fprintf(' Ir = %g A', Irm), fprintf('  at %gø', angIr), fprintf('  PFr = %g', pfr)

if abs(Qr) >0.01 & Qr > 0, fprintf(' lagging '),end
if abs(Qr) >0.01 & Qr < 0, fprintf(' leading '),end
fprintf(' \n')
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
