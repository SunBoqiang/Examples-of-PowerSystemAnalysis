% This function constructs the receiving end power circle diagram
% for varying values of Vs from Vr up to 1.35 Vr.
%
% Copyright (C) 1998 by H. Saadat
function pwrcirc(ABCD)
global resp model par1 par2 linelngt freq
diary off
if exist('ABCD')~=1
A = input('Enter the complex line constant A = ');
B = input('Enter the complex line constant B = ');
C = input('Enter the complex line constant C = ');
D = A; ABCD=[A B; C D]; end
fprintf(' \n')
fprintf(' Receiving end power circle diagram \n')
fprintf(' ---------------------------------- \n')

Vrm = input('Enter receiving end line-line voltage kV = ');
ba = angle( ABCD(1,2) )- angle(ABCD(1,1));
delta = 0:3:42;
d = delta*pi/180;

Vsm = 1.35*Vrm;

h=figure;
hold on

for k = 1:7
Vsm = Vsm -.05*Vrm;
bd = angle(ABCD(1,2)) - d;
S1 = Vsm*Vrm/abs(ABCD(1,2)); S2 = abs(ABCD(1,1))*Vrm^2/abs(ABCD(1,2));
Pr = S1*cos(bd) - S2*cos(ba);
Qr = S1*sin(bd) - S2*sin(ba);
tx = max(Pr); ty = min(Qr);

  if k ==1
  pm = ceil(max(Pr));
  x = 0:.1*pm:pm; y = zeros(1,length(x));
  else end
plot(Pr, Qr)


if k == 1, text( tx, ty, '1.30'), else end
if k == 2, text( tx, ty, '1.25'), else end
if k == 3, text( tx, ty, '1.20'), else end
if k == 4, text( tx, ty, '1.15'), else end
if k == 5, text( tx, ty, '1.10'), else end
if k == 6, text( tx, ty, '1.05'), else end
if k == 7, text( tx, ty, '1.0'), else end

end

plot(x,y), grid
axis([0 pm -pm/2  pm/2]);
axis('square')
xlabel('Pr, MW'), ylabel('Qr,  Mvar')
title('Power circle diagram  Vs: from Vr to 1.3Vr ')
hold off
pause
%axis('auto')
fprintf(' \n Hit return to continue \n')
pause
