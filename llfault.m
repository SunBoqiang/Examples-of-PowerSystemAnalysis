% The program llfault is designed for the line-to-line
% fault analysis of a power system network. The program requires
% the positive- and negative-sequence bus impedance matrices,
% Zbus1, and Zbus2.The bus impedances matrices may be defined
% by the user, obtained by the inversion of Ybus or it may be
% determined either from the function Zbus = zbuild(zdata)
% or the function Zbus = zbuildpi(linedata, gendata, yload).
% The program prompts the user to enter the faulted bus number
% and the fault impedance Zf. The prefault bus voltages are
% defined by the reserved Vector V. The array V may be defined or
% it is returned from the power flow programs lfgauss, lfnewton,
% decouple or perturb. If V does not exist the prefault bus voltages
% are automatically set to 1.0 per unit. The program obtains the
% total fault current, bus voltages and line currents during the fault.
%
% Copyright (C) 1998 Hadi Saadat

function llfault(zdata1, Zbus1, zdata2, Zbus2, V)
if exist('zdata2') ~= 1
zdata2=zdata1;
else, end
if exist('Zbus2') ~= 1
Zbus2=Zbus1;
else, end

nl = zdata1(:,1); nr = zdata1(:,2);
R1 = zdata1(:,3); X1 = zdata1(:,4);
R2 = zdata2(:,3); X2 = zdata2(:,4);
ZB1 = R1 + j*X1;  ZB2 = R2 + j*X2;
nbr=length(zdata1(:,1)); nbus = max(max(nl), max(nr));
if exist('V') == 1
    if length(V) == nbus
    V0 = V;
    else, end
else,  V0 = ones(nbus, 1) + j*zeros(nbus, 1);
end
fprintf('\nLine-to-line fault analysis \n')
ff = 999;
while ff > 0
nf = input('Enter Faulted Bus No. -> ');
while nf <= 0 | nf > nbus
     fprintf('Faulted bus No. must be between 1 & %g \n', nbus)
     nf = input('Enter Faulted Bus No. -> ');
     end
fprintf('\nEnter Fault Impedance Zf = R + j*X in ')
Zf = input('complex form (for bolted fault enter 0). Zf = ');
fprintf('  \n')
fprintf('Line-to-line fault at bus No. %g\n', nf)
a =cos(2*pi/3)+j*sin(2*pi/3);
sctm = [1   1   1; 1 a^2  a; 1 a  a^2];
Ia0=0;
Ia1 = V0(nf)/(Zbus1(nf,nf)+Zbus2(nf, nf)+Zf); Ia2=-Ia1;
I012=[Ia0; Ia1; Ia2];
Ifabc = sctm*I012;
Ifabcm = abs(Ifabc);
fprintf('Total fault current = %9.4f per unit\n\n', Ifabcm(2))
fprintf('Bus Voltages during the fault in per unit \n\n')
fprintf('     Bus    -------Voltage Magnitude-------  \n')
fprintf('     No.    Phase a     Phase b     Phase c  \n')

for n = 1:nbus
Vf0(n)= 0;
Vf1(n)= V0(n) - Zbus1(n, nf)*Ia1;
Vf2(n)= 0 - Zbus2(n, nf)*Ia2;
Vabc = sctm*[Vf0(n); Vf1(n); Vf2(n)];
Va(n)=Vabc(1); Vb(n)=Vabc(2); Vc(n)=Vabc(3);
fprintf(' %5g',n)
fprintf(' %11.4f', abs(Va(n))),fprintf(' %11.4f', abs(Vb(n)))
fprintf(' %11.4f\n', abs(Vc(n)))
end
fprintf('  \n')
fprintf('Line currents for fault at bus No.  %g\n\n', nf)
fprintf('     From      To      -----Line Current Magnitude----  \n')
fprintf('     Bus       Bus     Phase a     Phase b     Phase c  \n')

for n= 1:nbus
   for I = 1:nbr
      if nl(I) == n | nr(I) == n
         if nl(I) ==n       k = nr(I);
         elseif nr(I) == n  k = nl(I);
         end
            if k ~= 0
            Ink0(n, k) = 0;
            Ink1(n, k) = (Vf1(n) - Vf1(k))/ZB1(I);
            Ink2(n, k) =  (Vf2(n) - Vf2(k))/ZB2(I);

            Inkabc = sctm*[Ink0(n, k); Ink1(n, k); Ink2(n, k)];
            Inkabcm = abs(Inkabc); th=angle(Inkabc);
                 if real(Inkabc(2)) < 0

               fprintf('%7g', n), fprintf('%10g', k),
                fprintf(' %11.4f', abs(Inkabc(1))),fprintf(' %11.4f', abs(Inkabc(2)))
                fprintf(' %11.4f\n', abs(Inkabc(3)))
                elseif real(Inkabc(2)) ==0 & imag(Inkabc(2)) > 0
                fprintf('%7g', n), fprintf('%10g', k),
                fprintf(' %11.4f', abs(Inkabc(1))),fprintf(' %11.4f', abs(Inkabc(2)))
                fprintf(' %11.4f\n', abs(Inkabc(3)))
                else, end
             else, end
      else, end
   end
   if n==nf
   fprintf('%7g',n), fprintf('         F'),
   fprintf(' %11.4f', Ifabcm(1)),fprintf(' %11.4f', Ifabcm(2))
   fprintf(' %11.4f\n', Ifabcm(3))
   else, end
end
resp=0;
   while strcmp(resp, 'n')~=1 & strcmp(resp, 'N')~=1 & strcmp(resp, 'y')~=1 & strcmp(resp, 'Y')~=1
   resp = input('Another fault location? Enter ''y'' or ''n'' within single quote -> ');
   if strcmp(resp, 'n')~=1 & strcmp(resp, 'N')~=1 & strcmp(resp, 'y')~=1 & strcmp(resp, 'Y')~=1
   fprintf('\n Incorrect reply, try again \n\n'), end
   end
   if resp == 'y' | resp == 'Y'
   nf = 999;
   else ff = 0; end
end   % end for while
