% This function computes the current at both ends of a transmission
% line for a solid short-circuit at the receiving-end.
% Copyright (C) 1998 by H. Saadat.

function shcktlin(ABCD)
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
Vr = 0;
Vrm = 0;
Ir = Vs/ABCD(1,2);
Irm = abs(Ir)*1000;
angIr = angle(Ir); angIr = angIr*180/pi;
Is= ABCD(2,2)*Ir
Ism = abs(Is)*1000;
angIs = angle(Is); angIs = angIs*180/pi;
clc
fprintf(' \n')
fprintf(' Line short-circuited at the receiving end \n')
fprintf(' ----------------------------------------- \n')
fprintf(' Vs = %g kV (L-L)', Vsm), fprintf('  at %gø \n', ds)
fprintf(' Ir = %g A', Irm), fprintf('  at %gø \n', angIr)
fprintf(' Is = %g A', Ism), fprintf('  at %gø \n', angIs)
fprintf(' \n Hit return to continue \n ')
pause
