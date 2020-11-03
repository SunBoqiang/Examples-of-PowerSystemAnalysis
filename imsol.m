% This program is used by im obtains the induction motor performance
% at a given slip.
%
% Copyright (C) 1998 by H. Saadat

Vmp=Vm/sqrt(3);
V= Vmp+j*0;
Ns=120.*f/P;
Nr=(1.-S)*Ns;
Ws=2.*pi*Ns/60;
Wr=(1.-S)*Ws;
R2ds=R2/S;
Z2=R2ds + j*abs(X2);
if Rc == inf | Rc == 0, Gc = 0; else Gc = 1/Rc; end
if abs(Xm) == inf | abs(Xm) == 0, Bm = 0; else Bm = 1/abs(Xm); end
Y2=1/Z2 ;
Ye=Gc-j*Bm;
if Gc == 0 & Bm == 0  Ze = inf+j*inf; else Ze = 1/Ye; end
Yf=Y2+Ye;
Zf=1/Yf;  Rf = real(Zf); Xf = imag(Zf);
Zin=Z1+Zf; Rin = real(Zin); Xin = imag(Zin);
   if Gc ~= 0  | Bm ~= 0
      Zth= Z1*Ze/(Z1+Ze);
      Vthc=V*Ze/(Z1 +Ze);
      else
      Zth=Z1 ;
      Vthc=V ;
      end
Vth=abs(Vthc); Tth = angle(Vthc)*180/pi;
Rth=real(Zth);
Xth=imag(Zth);
Rdd=sqrt(Rth^2 + (Xth+X2)^2);
Smax=R2/Rdd;
Pmax=1.5*Vth^2./(Rth+Rdd);
Tmax=Pmax/Ws;
I1=V/Zin;
I1m=abs(I1);
T1=angle(I1)*180./pi;
if real(Ze) == inf & imag(Ze) == inf I2 =I1; else
I2= Ze*I1/(Ze+Z2); end
T2=angle(I2)*180/pi;
I2m=abs(I2);
S1=3.*V*conj(I1);
SCL=3*R1*I1m^2;
Pin=real(S1);
Pg=3.* R2ds*I2m^2;
RCL=3.*R2*I2m^2;
Pm=Pg-RCL;
Td=Pg/Ws;
I2st = Vth/(Zth+Z2s);
Pgst = 3.*R2*abs(I2st)^2;
Tst = Pgst/Ws;
if S ~= 1
      Po=Pm-Prot;  hp = Po/746;
      To=Po/Wr;
      Ef=100*Po/Pin;
else, end
clc
fprintf('\n\n  Analysis of the equivalent circuit at slip S = %g\n\n', S)
fprintf('  ns = %g rpm', Ns), fprintf('   ws  = %g rad/s\n', Ws)
fprintf('  nr = %g rpm', Nr), fprintf('   wr  = %g rad/s\n', Wr)
fprintf('  Zshunt parallel with Z2''     Zf  = %g', Rf), fprintf(' + j %g ohm \n', Xf)
fprintf('  Input Impedance              Zin = %g', Rin), fprintf(' + j %g ohm \n', Xin)
fprintf('  Thevenin''s Impedance         Zth = %g', Rth), fprintf(' + j %g ohm \n', Xth)
fprintf('  Thevenin''s voltage/phase     Vth = %g', Vth)
fprintf(' at %gø \n', Tth)
if S ~= 1
  fprintf('  Stator current               I1  = %g A', I1m), fprintf(' at %gø\n', T1)
  fprintf('  Ref. rotor current           I2  = %g A', I2m), fprintf(' at %gø\n', T2)
  fprintf('  Stator input power           Pin = %g W\n', Pin)
  fprintf('  Stator copper loss           SCL = %g W\n', SCL)
  fprintf('  Power transferred to rotor   Pg  = %g W\n',Pg)
  fprintf('  Rotor copper loss            RCL = %g W\n', RCL)
  fprintf('  Gross mech. power developed  Pm  = %g W\n', Pm)
  fprintf('  Rotational & stray loss      Prot= %g W\n', Prot)
  fprintf('  Net power output             Po  = %g W', Po)
  fprintf('   (%g hp)\n', hp)
  fprintf('  Efficiency                   Eff = %g ', Ef), disp('%')
  fprintf('  Developed torque             Td  = %g N-m\n', Td)
  fprintf('  Output torque                T0  = %g N-m\n', To)
  fprintf('  Max. torque                  Tmax= %g N-m', Tmax)
  fprintf(' at s = %g\n', Smax)
  fprintf('  Starting torque              Ts  = %g N-m\n', Tst)
else, end
if S ==1
  fprintf('  Starting Stator current      I1  = %g A', I1m), fprintf(' at %gø\n', T1)
  fprintf('  Starting Ref. rotor current  I2  = %g A', I2m), fprintf(' at %gø\n', T2)
  fprintf('  Stator input power           Pin = %g W\n', Pin)
  fprintf('  Stator copper loss           SCL = %g W\n', SCL)
  fprintf('  Power transferred to rotor   Pg  = %g W\n',Pg)
  fprintf('  Rotor copper loss            RCL = %g W\n', RCL)
  fprintf('  Starting torque              Ts  = %g N-m\n', Td)
else,end
