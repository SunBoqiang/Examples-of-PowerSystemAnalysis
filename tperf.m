% This program is called by trans  and obtains the transformer performance
% characteristics.
%
% Copyright (C) 1998 by H. Saadat.

if Rclv == inf | Rclv == 0
Pi = input(' Enter transformer core loss in Watt, Pi = ');
else, Pi = Elv^2/Rclv;
end

S2m = input(' Enter load kVA, S2 = ');
pf  = input(' Enter load power factor, pf = ');

if pf ~= 1
   ldlg = 0;
   while strcmp(ldlg, 'lg')~=1 & strcmp(ldlg, 'LG')~=1 & strcmp(ldlg, 'ld')~=1 & strcmp(ldlg, 'LD')~=1
   fprintf(' Enter ''lg'' within quotes for lagging pf \n')
   ldlg = input(' or ''ld'' within quotes for leading pf -> ');
   if strcmp(ldlg, 'lg')~=1 & strcmp(ldlg, 'LG')~=1 & strcmp(ldlg, 'ld')~=1 & strcmp(ldlg, 'LD')~=1
   fprintf('\n Incorrect reply, try again \n\n'), end
   end
else, end
V2m = input(' Enter load terminal voltage in volt, V2 = ');
V2 = V2m + j*0;
pf = abs(pf);
ang2 = acos(pf);

if ldlg == 'ld' | ldlg == 'LD'
    ang2 = -ang2; elseif ldlg == 'lg' | ldlg == 'LG', end
ang2d = ang2*180/pi;
S2 = S2m*1000*(pf + j*sin(ang2));
I2 = conj(S2)/V2;
I2m = abs(I2); angI2d = angle(I2)*180/pi;
Dvl = abs(Elv - V2m); Dvh = abs(Ehv - V2m);
if Dvl < Dvh
    V1r = (Ehv/Elv)*V2;       I1r = (Elv/Ehv)*I2; I1rm=abs(I1r);
    V1 = V1r + Zehv*I1r;
    V1m = abs(V1); ang1 = angle(V1); ang1d = ang1*180/pi;

    if Rchv == inf | Rchv == 0, Ior = 0;
    else, Ior= V1m/Rchv; end
    if Xmhv == inf | Xmhv == 0, Ioi = 0;
    else, Ioi= V1m/Xmhv;end
    Io = Ior -j*Ioi;
    I1 = I1r + Io;
    Pcu = real(Zehv)*I1rm^2;
    else, V1r = (Elv/Ehv)*V2; I1r = (Ehv/Elv)*I2; I1rm = abs(I1r);
    V1 = V1r + Zelv*I1r;
    V1m = abs(V1); ang1 = angle(V1); ang1d = ang1*180/pi;

    if Rclv == inf | Rclv == 0, Ior = 0;
    else, Ior= V1m/Rclv; end
    if Xmlv == inf | Xmlv == 0, Ioi = 0;
    else, Ioi= V1m/Xmlv;end
    Io = Ior -j*Ioi;
    I1 = I1r + Io;
    Pcu = real(Zelv)*I1rm^2;
end
I1rm = abs(I1r);
Iom = abs(Io); angIod = angle(Io)*180/pi;
I1m = abs(I1); angI1d = angle(I1)*180/pi;
VR = (V1m - abs(V1r))/abs(V1r)*100;
eff = (S2m*1000*pf)/(S2m*1000*pf+Pi+Pcu)*100;
Smax = sqrt(Pi/Pcu)*S2m;
effmax = (Smax*1000*pf)/(Smax*1000*pf+Pi+Pi)*100;
fprintf('\n Secondary load voltage  = %10.3f V \n', V2m)
fprintf(' Secondary load current  = %10.3f A', I2m)
fprintf('  at %5.2f degrees\n', angI2d)
fprintf(' Current ref. to primary = %10.3f A', I1rm)
fprintf('  at %5.2f degrees \n', angI2d)
fprintf(' Primary no-load current = %10.3f A ', Iom)
fprintf(' at %5.2f degrees \n', angIod)
fprintf(' Primary input current   = %10.3f A', I1m)
fprintf('  at %5.2f degrees \n', angI1d)

fprintf(' Primary input voltage   = %10.3f V ', V1m)
fprintf(' at %5.2f  degrees \n', ang1d)
fprintf(' Voltage regulation      =  %9.3f percent \n', VR)
fprintf(' Transformer efficiency  =  %9.3f percent \n', eff)

fprintf('\n Maximum  efficiency is%7.3f percent,', effmax)
fprintf(' occurs at%9.3f kVA', Smax)
fprintf(' with%5.2f pf\n', pf)

%fprintf('\n\n Hit return to continue \n')
%pause
Sl = 0.25*S2m:.01*S2m:1.25*S2m;
PCU = (Pcu/S2m^2)*Sl.^2;
Po = pf*Sl;
PI = Pi*ones(1,length(Sl));
EFF = 1000*Po./(1000*Po+PI+PCU)*100;
figure
plot(Po, EFF), grid
title(['Transformer Efficiency, pf = ', num2str(pf)])
xlabel('Output power, kW')
ylabel('Percent')
res=0;
while strcmp(res, 'n')~=1 & strcmp(res, 'N')~=1 & strcmp(res, 'y')~=1 & strcmp(res, 'Y')~=1
fprintf('\n Would you like the analysis for another load?'),
res = input(' Enter ''Y'' or ''N'' within quotes -> ');
if strcmp(res, 'n')~=1 & strcmp(res, 'N')~=1 & strcmp(res, 'y')~=1 & strcmp(res, 'Y')~=1
fprintf('\n Incorrect reply, try again \n\n'), end
end
if res == 'y' | res == 'Y', tperf
elseif res =='n' | res == 'N', trans, end
