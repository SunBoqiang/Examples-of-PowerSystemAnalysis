% This program displays a list of 1 to 8 options for transmission line
% analysis and compensation.
%
% Copyright (C) 1998 by H. Saadat.

global resp model par1 par2 linelngt freq
clc
  menu2 = [
  '     TRANSMISSION LINE PERFORMANCE                   '
  '     ----------Analysis----------              Select'
  ' To calculate sending end quantities                 '
  ' for specified receiving end MW, Mvar             1  '
  '                                                     '
  ' To calculate receiving end quantities               '
  ' for specified sending end MW, Mvar               2  '
  '                                                     '
  ' To calculate sending end quantities                 '
  ' when load impedance is specified                 3  '
  '                                                     '
  ' Open-end line & inductive compensation           4  '
  '                                                     '
  ' Short-circuited line                             5  '
  '                                                     '
  ' Capacitive compensation                          6  '
  '                                                     '
  ' Receiving end circle diagram                     7  '
  '                                                     '
  ' Loadability curve and voltage profile            8  '
  '                                                     '
  ' To quit                                          0  '];

  disp(menu2)

 par2 = -1;
    while par2~=1 & par2~=2 & par2~=3 & par2~=4 & par2~=5 & par2~=6 & par2~=7 & par2~=8 & par2~=0
    par2 = input(' Select number of menu --> ');
    if par2~=1 & par2~=2 & par2~=3 & par2~=4 & par2~=5 & par2~=6 & par2~=7 & par2~=8 & par2~=0
    disp(' Enter 1 to 8 or 0 to quit'), else, end
    end
  if par2 == 0, lineperf, end
  if par2 == 1, givensr(ABCD), listmenu, else, end
  if par2 == 2, givenss(ABCD), listmenu, else, end
  if par2 == 3, givenzl(ABCD), listmenu, else, end
  if par2 == 4, openline(ABCD), listmenu, else, end
  if par2 == 5, shcktlin(ABCD), listmenu, else, end
  if par2 == 6, compmenu, listmenu, else, end
  if par2 == 7, pwrcirc(ABCD), listmenu, else, end
  if par2 == 8, profmenu, listmenu, else, end
