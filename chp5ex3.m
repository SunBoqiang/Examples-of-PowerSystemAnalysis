z = .036 + j* 0.3;  y = j*4.22/1000000;  Length = 130;
Vs3ph = 345;  Ism = 0.4;  %KA;
As = -acos(0.95);
Vs = Vs3ph/sqrt(3) + j*0;       % kV (sending end phase voltage)
Is = Ism*(cos(As) + j*sin(As));
[Z,Y, ABCD] = zy2abcd(z, y, Length);

VrIr = inv(ABCD)* [Vs; Is];      %        column vector [Vr; Ir]
Vr = VrIr(1);
Vr3ph = sqrt(3)*abs(Vr);         % kV(receiving end L-L voltage)
Ir = VrIr(2); Irm = 1000*abs(Ir);%     A (receiving end current)
pfr= cos(angle(Vr)- angle(Ir));  %  (receiving end power factor)
Sr = 3*Vr*conj(Ir);              %     MVA (receiving end power)
REG = (Vs3ph/abs(ABCD(1,1)) - Vr3ph)/Vr3ph *100;
fprintf(' Ir = %g A', Irm), fprintf('  pf = %g\n', pfr)
fprintf(' Vr = %g L-L kV\n', Vr3ph)
fprintf(' Pr = %g MW', real(Sr))
fprintf('  Qr = %g Mvar\n', imag(Sr))
fprintf(' Percent voltage Reg. = %g\n', REG)
