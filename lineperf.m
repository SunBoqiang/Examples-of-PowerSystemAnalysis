% This program is developed for the complete analysis and compensation
% of a transmission line.
% Copyright (C)1998 by H. Saadat.

global resp model par1 par2 linelngt freq
clc
par1 = -1;
menu1 =[
'              TRANSMISSION LINE MODEL             '
'                                                  '
' Type of parameters for input              Select '
'                                                  '
' Parameters per unit length                       '
' r(ohms), g(siemens) L(mH) & C (micro F)      1   '
'                                                  '
' Complex z and y per unit length                  '
' r+j*x (ohms/length), g+j*b (siemens/length)  2   '
'                                                  '
' Nominal pi or Eq. pi model                   3   '
'                                                  '
' A, B, C, D constants                         4   '
'                                                  '
' Conductor configuration and dimension        5   '
'                                                  '
' To quit                                      0   '
'                                                  '];
disp(menu1)

  while par1 ~=1 & par1 ~= 2 & par1 ~= 3 & par1 ~= 4 & par1 ~= 5 & par1 ~= 0
par1 = input(' Select number of menu --> ');
    if par1 ~= 1 & par1 ~= 2 & par1 ~= 3 & par1 ~= 4 & par1 ~= 5 & par1 ~= 0
     disp(' Enter 1, 2, 3, 4, 5 or 0'), end
  end
fprintf(' \n')
if par1 == 0,
    if exist('par2')==1
    fprintf('\n To display the Analysis Menu for the existing model enter listmenu \n')
    else, end
return, end


if par1 == 1
Length = input('Enter Line length = '); linelngt= Length;
f = input('Enter Frequency in Hz = ');  freq=f;
r = input('Enter line resistance/phase in ohms per unit length r = ');
L = input('Enter line inductance/phase in millihenry per unit length L = ');
C = input('Enter line capacitance/phase in micro F per unit length C = ');
g = input('Enter line conductance/phase in siemens per unit length g = ');
[Z,Y, ABCD] = rlc2abcd(r, L, C, g, f, Length);
end
if par1 ==2
Length = input('Enter Line length = '); linelngt=Length;
f = input('Enter Frequency in Hz = ');  freq=f;
z = input('Enter series impedance r + j*x in ohms per unit length z = ');
y = input('Enter shunt admittance  g + j*b in siemens per unit length y = ');
r = real(z);  L = abs(imag(z))/(2*pi*f)*1000;
g = real(y);  C = abs(imag(y))/(2*pi*f)*1000000;
[Z,Y, ABCD] = zy2abcd(z, y, Length);
end
if par1 == 3
Z = input('Enter total series impedance R + j*X in ohms Z = ');
Y = input('Enter total shunt admittance G + j*B in siemens Y = ');
[Z, Y, ABCD] = pi2abcd(Z, Y);
end

if par1 == 4
model = 1;
A = input('Enter the complex constant A = ');
B = input('Enter the complex constant B = ');
C = input('Enter the complex constant C = ');
D = A;
[Z, Y, ABCD] = abcd2pi(A, B, C);
end
if par1==5
[L, C]=gmd2lc;
  if isempty(L)==0 |isempty(C)==0
  Length = input('Enter Line length = '); linelngt=Length;
  f = input('Enter Frequency in Hz = ');  freq=f;
  r = input('Enter line resistance/phase in ohms per unit length = ');
  g = input('Enter line conductance/phase in siemens per unit length = ');
shrt=input('Is the line model Short? Enter ''Y'' or ''N'' within quotes --> ');
if shrt == 'Y' | shrt == 'y', C = 0; g = 0; else, end
  [Z,Y, ABCD] = rlc2abcd(r, L, C, g, f, Length);
  else lineperf, end
end
if par1 ==1 | par1== 2 | par1==3 | par1==4 | par1 ==5
if model == -1 | model == 1 | model ==2
  fprintf('\n Hit return to continue \n')
  pause
listmenu
else, fprintf(' You must Enter 1, 2, 3, 4 or 5. Try again \n'), end
end
