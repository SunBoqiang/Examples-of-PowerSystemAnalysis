% This program displays two options for obtaining the voltage profile
% and the line loadability curves.
% Copyright (C)1998 by H. Saadat
global resp model par1 par2 linelngt freq
clc
  menu4 = [
  '      Voltage profile and line loadability       '
  '                                           Select'
  '                                           ------'
  ' Voltage profile curves                       1  '
  '                                                 '
  ' Line loadability curves                      2  '
  '                                                 '
  ' To quit                                      0  '];

  disp(menu4)
  par4 = -1;
    while par4~=1 & par4~=2 & par4~=0
    par4 = input('Select number of menu --> ');
    if par4~=1 & par4~=2 & par4~=0
    disp('Enter 1, 2 or 0 '), else, end
    end
  if par4 == 0, return, end
       if par1==3 | par1 == 4
       [r, L, C, f] = abcd2rlc(ABCD);
       else, end
  if par4 == 1, vprofile(r, L, C, f), profmenu, else, end
  if par4 == 2, loadabil(L, C, f), profmenu, else, end
