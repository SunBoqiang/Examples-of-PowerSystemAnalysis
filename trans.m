% This program displays three options for obtaining the transformer
% performance characteristics/
%
% Copyright (C) 1998  by H. Saadat.

clc
global  par1
par1 = -1;
menu1 =[
'                 TRANSFORMER ANALYSIS               '
'                                                    '
' Type of parameters for input                Select '
' ----------------------------                ------ '
' To obtain equivalent circuit from tests        1   '
'                                                    '
' To input individual winding impedances         2   '
'                                                    '
' To input transformer equivalent impedance      3   '
'                                                    '
' To quit                                        0   '];
disp(menu1)

  while par1 ~=1 & par1 ~= 2 & par1 ~= 3 & par1 ~=0
  par1 = input(' Select number of menu --> ');
    if par1 ~= 1 & par1 ~= 2 & par1 ~= 3 & par1 ~=0
     disp(' Enter 1, 2, 3, or 0'), else, end
  end
fprintf(' \n')

    if isempty(par1) == 1
    disp('You must enter 1, 2, 3, or 0  try again'), return,
    else, end
if par1 == 0, return, end
if par1 == 1
   S = input(' Enter Transformer rated power in kVA, S = ');
   Elv = input(' Enter rated low voltage in volts  = ');
   Ehv = input(' Enter rated high voltage in volts = ');
   fprintf('\n Open circuit test data \n\n')
   fprintf(' ----------------------   \n')
   tso = 0;
   while strcmp(tso, 'lv')~=1 & strcmp(tso, 'LV')~=1 & strcmp(tso, 'hv')~=1 & strcmp(tso, 'HV')~=1
   fprintf(' Enter ''lv'' within quotes for data referred to low side or \n')
   tso = input(' enter ''hv'' within quotes for data referred to high side -> ');
   if strcmp(tso, 'lv')~=1 & strcmp(tso, 'LV')~=1 & strcmp(tso, 'hv')~=1 & strcmp(tso, 'HV')~=1
   fprintf('\n Incorrect reply, try again \n\n'), end
   end
   Vo = input(' Enter input voltage in volts, Vo = ');
   Io = input(' Enter no-load current in Amp, Io = ');
   Po = input(' Enter no-load input power in Watt, Po = ');
   [Rc, Xm] = troct(Vo, Io, Po);
      if tso == 'lv' | tso == 'LV'
      Rclv = Rc; Xmlv = Xm;
      Rchv = (Ehv/Elv)^2*Rc; Xmhv = (Ehv/Elv)^2*Xm;
      else, end
      if tso == 'hv' | tso == 'HV'
      Rchv = Rc; Xmhv = Xm;
      Rclv = (Elv/Ehv)^2*Rc; Xmlv = (Elv/Ehv)^2*Xm;
      else, end
  fprintf('\n Short circuit test data \n')
  fprintf(' ----------------------- \n')
  tsc=0;
  while strcmp(tsc, 'lv')~=1 & strcmp(tsc, 'LV')~=1 & strcmp(tsc, 'hv')~=1 & strcmp(tsc, 'HV')~=1
  fprintf(' Enter ''lv'' within quotes for data referred to low side or \n')
  tsc = input(' enter ''hv'' within quotes for data referred to high side -> ');
  if strcmp(tsc, 'lv')~=1 & strcmp(tsc, 'LV')~=1 & strcmp(tsc, 'hv')~=1 & strcmp(tsc, 'HV')~=1
  fprintf('\n Incorrect reply, try again \n\n'), end
  end
  Vsc = input(' Enter reduced input voltage in volts, Vsc = ');
  Isc = input(' Enter input current in Amp, Isc = ');
  Psc = input(' Enter input power in Watt, Psc = ');
  [Ze] = trsct(Vsc, Isc, Psc);
      if tsc == 'lv' | tsc == 'LV'
      Zelv = Ze;
      Zehv = (Ehv/Elv)^2*Ze; else, end
      if tsc == 'hv' | tsc == 'HV'
      Zehv = Ze;
      Zelv = (Elv/Ehv)^2*Ze; else, end
end

if par1 ==2
S = input(' Enter Transformer rated power in kVA, S = ');
Elv = input(' Enter rated low voltage in volts  = ');
Ehv = input(' Enter rated high voltage in volts = ');
Zlv = input(' Enter LV winding series impedance R1 + j*X1 in ohm = ');
Zhv = input(' Enter HV winding series impedance R2 + j*X2 in ohm = ');
[Zelv, Zehv] = wz2eqz(Elv, Ehv, Zlv, Zhv);

   tso=0;
   while strcmp(tso, 'lv')~=1 & strcmp(tso, 'LV')~=1 & strcmp(tso, 'hv')~=1 & strcmp(tso, 'HV')~=1
   fprintf(' Enter ''lv'' within quotes for low side shunt branch or \n')
   tso = input(' enter ''hv'' within quotes for high side shunt branch -> ');
   if strcmp(tso, 'lv')~=1 & strcmp(tso, 'LV')~=1 & strcmp(tso, 'hv')~=1 & strcmp(tso, 'HV')~=1
   fprintf('\n Incorrect reply, try again \n\n'), end
   end


Rc = input(' Shunt resistance in ohm (if neglected enter inf) = ');
Xm = input(' Shunt reactance in ohm (if neglected enter inf) = ');
    if tso == 'lv' | tso == 'LV'
    Rclv = Rc; Xmlv = Xm;
    Rchv = (Ehv/Elv)^2*Rc; Xmhv = (Ehv/Elv)^2*Xm;
    else, end
    if tso == 'hv' | tso == 'HV'
    Rchv = Rc; Xmhv = Xm;
    Rclv = (Elv/Ehv)^2*Rc; Xmlv = (Elv/Ehv)^2*Xm;
    else, end
end

if par1 == 3
S = input(' Enter Transformer rated power in kVA, S = ');
Elv = input(' Enter rated low voltage in volts  = ');
Ehv = input(' Enter rated high voltage in volts = ');

tsc=0;
  while strcmp(tsc, 'lv')~=1 & strcmp(tsc, 'LV')~=1 & strcmp(tsc, 'hv')~=1 & strcmp(tsc, 'HV')~=1
   fprintf(' \n Enter ''lv'' within quotes for equivalent impedance referred to low side or \n')
tsc = input(' enter ''hv'' within quotes for equivalent impedance referred to high side -> ');
       if strcmp(tsc, 'lv')~=1 & strcmp(tsc, 'LV')~=1 & strcmp(tsc, 'hv')~=1 & strcmp(tsc, 'HV')~=1
       fprintf('\n Incorrect reply, try again \n\n'), end
  end

Ze = input(' Enter transformer equivalent impedance Re + j*Xe in ohm, Ze = ');
    if tsc == 'lv' | tsc == 'LV'
    Zelv = Ze;
    Zehv = (Ehv/Elv)^2*Ze; else, end
    if tsc == 'hv' | tsc == 'HV'
    Zehv = Ze;
    Zelv = (Elv/Ehv)^2*Ze; else, end
tso = 0;
   while strcmp(tso, 'lv')~=1 & strcmp(tso, 'LV')~=1 & strcmp(tso, 'hv')~=1 & strcmp(tso, 'HV')~=1
   fprintf(' Enter ''lv'' within quotes for low side shunt branch or \n')
   tso = input(' enter ''hv'' within quotes for high side shunt branch -> ');
   if strcmp(tso, 'lv')~=1 & strcmp(tso, 'LV')~=1 & strcmp(tso, 'hv')~=1 & strcmp(tso, 'HV')~=1
   fprintf('\n Incorrect reply, try again \n\n'), end
   end
Rc = input(' Shunt resistance in ohm (if neglected enter inf) = ');
Xm = input(' Shunt reactance in ohm (if neglected enter inf) = ');
    if tso == 'lv' | tso == 'LV'
    Rclv = Rc; Xmlv = Xm;
    Rchv = (Ehv/Elv)^2*Rc; Xmhv = (Ehv/Elv)^2*Xm;
    else, end
    if tso == 'hv' | tso == 'HV'
    Rchv = Rc; Xmhv = Xm;
    Rclv = (Elv/Ehv)^2*Rc; Xmlv = (Elv/Ehv)^2*Xm;
    else, end
end
clc

fprintf('\n Shunt branch ref. to LV side ')
fprintf('             Shunt branch ref. to HV side \n')
fprintf(' Rc = %12.3f ohm', Rclv), fprintf('                     Rc = %12.3f ohm \n', Rchv)
fprintf(' Xm = %12.3f ohm', Xmlv), fprintf('                     Xm = %12.3f ohm \n', Xmhv)
fprintf('\n Series branch ref. to LV side ')
fprintf('            Series branch ref. to HV side \n')
fprintf(' Ze = %10.6f', real(Zelv)), fprintf(' + j %10.6f ohm', imag(Zelv))
fprintf('        Ze = %10.6f', real(Zehv)), fprintf(' + j %10.6f ohm \n\n', imag(Zehv))
%fprintf('\n\n Hit return to continue \n')
%pause
tperf
