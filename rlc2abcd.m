% This function returns the pi model's parameters and ABCD constants
% when r, l, c and f are specified.
%
% Copyright (C) 1998 by H. Saadat.

function [Z, Y, ABCD] = rlc2abcd(r, L, C, g, f, Length);
global resp model par1 par2 linelngt freq
par1=1;
if exist('r')~=1
r = input('Enter line resistance in ohms per unit length, r = '); else end
if exist('L')~=1
L = input('Enter line inductance in millihenry per unit length, L = ');else end
if exist('C')~=1
C = input('Enter line capacitance in microfarad per unit length, C = '); else end
if exist('g')~=1
g = input('Enter line conductance in siemens per unit length, g = '); else end
if exist('f')~=1
f = input('Enter Frequency in Hz = '); freq=f; else end
if exist('Length')~=1
Length = input('Enter Line length = '); linelngt=Length; else end
   model =-1;
   z =  r + j*2*pi*f*L/1000; ; Z = z*Length;
   R = real(Z); X = imag(Z);
   y = g + j*2*pi*f*C/1000000;
   Y = y*Length;
if g== 0 & C==0
      fprintf ('\n'), disp(' Short line model')
      disp(' ----------------')
      fprintf('\n')
      fprintf(' Z = %g + j ',real(Z)),  fprintf('%g ohms\n',imag(Z)),
      Y = 0 + j*0; Zc = 0;
else
   Zc = sqrt(Z/Y); Gamal=sqrt(Z*Y);
   while model ~=1 & model~=2
   model = input('Enter 1 for Medium line or 2 for long line --> ');
    if model ~=1 & model~=2
    disp(' Enter 1 or 2'), else, end
end

  if model==2
      Z = Zc*sinh(Gamal);  Y = 2*tanh(Gamal/2) /Zc;
  else, end

   if model==1,  disp(' '),  disp(' Nominal pi model'),
      disp(' ----------------')
      fprintf('\n'), fprintf(' Z = %g + j ',R), fprintf('%g ohms\n',X),
      fprintf(' Y = %g + j ',real(Y)), fprintf('%g Siemens\n',imag(Y))
      elseif model==2, disp(' '), disp(' Equivalent pi model')
      disp(' -------------------')
      fprintf('\n')
      fprintf(' Z'' = %g + j ',real(Z)),  fprintf('%g ohms\n',imag(Z)),
      fprintf(' Y'' = %g + j ',real(Y)),  fprintf('%g siemens\n',imag(Y))
      fprintf(' Zc  = %g + j ',real(Zc)), fprintf('%g ohms\n',imag(Zc))
      fprintf(' alpha l  = %g neper', real(Gamal))
      fprintf('    beta l = %g radian', imag(Gamal))
      fprintf('   = %gø\n', imag(Gamal*180/pi))
      else, end,
%end
end
if model == -1 | model ==1 |model ==2
  %  A,B,C,D constants of line
  A = 1 + Z*Y/2;  B = Z;
  C = Y*(1 + Z*Y/4);  D = A;
  ABCD = [A B; C D];
  disp(' ')
  fprintf('         %-11.5g + j', real(A)), fprintf(' %-11.5g', imag(A))
  fprintf('   %-11.5g + j', real(B)), fprintf(' %-11.5g  \n', imag(B))
  fprintf(' ABCD =                                                             \n')
  fprintf('         %-11.5g + j', real(C)), fprintf(' %-11.5g', imag(C))
  fprintf('   %-11.5g + j', real(D)), fprintf(' %-11.5g  \n', imag(D))
  fprintf(' \n')
else, fprintf(' You must enter 1 or 2. Try again \n'), return, end
