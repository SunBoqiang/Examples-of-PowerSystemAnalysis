% This program displays three options for capacitive compensation
% of transmission line.
% Copyright (C) 1998 by H. Saadat.

clc
  menu3 = [
  '         CAPACITIVE COMPENSATION                 '
  '             Analysis                      Select'
  '             --------                      ------'
  ' Shunt capacitive compensation                1  '
  '                                                 '
  ' Series capacitive compensation               2  '
  '                                                 '
  ' Series & Shunt capacitive compensation       3  '
  '                                                 '
  ' To quit                                      0  '];

  disp(menu3)
  par3 = -1;
    while par3~=1 & par3~=2 & par3~=3 & par3~=0
    par3 = input('Select number of menu --> ');
    if par3~=1 & par3~=2 & par3~=3 & par3~=0
    disp('Enter 1, 2, 3 or 0 '), else, end
    end
  if par3 == 0, return, end
  if par3 == 1, shntcomp(ABCD), compmenu, else, end
  if par3 == 2, sercomp(ABCD), compmenu, else, end
  if par3 == 3, srshcomp(ABCD), compmenu, else, end
