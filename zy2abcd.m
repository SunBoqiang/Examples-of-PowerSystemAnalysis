% This function computes the ABCD constants and the parameters
% of the transmission line pi models from impedance and admittance
% per unit length.
%
% Copyright (C) 1998 by H. Saadat.

function [Z, Y, ABCD] = zy2abcd(z, y, Length);
global resp model par1 par2 linelngt freq
par1=2;
if exist('z')~=1
z = input('Enter series impedance r + j*x in ohms per unit length, z = ');
else, end
if exist('y')~=1
y = input('Enter shunt admittance  g + j*b in siemens per unit length, y = ');
else, end
if exist('Length')~=1
Length = input('Enter Line length = '); linelngt = Length; else, end
%else, end
   model =-1;
   Z = z*Length;
   Y = y*Length;
if  real(Y)== 0 & imag(Y) == 0
    ZC = 0;
    fprintf(' \n'), disp(' Short line model')
    disp(' ----------------')
    fprintf('\n'), fprintf(' Z = %g + j ',real(Z)), fprintf('%g ohms\n',imag(Z)),
else
    Zc = sqrt(Z/Y); Gamal = sqrt(Z*Y);
       while model ~=1 & model ~=2
       model = input('Enter 1 for Medium line or 2 for long line --> ');
         if model ~=1 & model ~=2
         disp('Enter 1 or 2'), else,end
       end

      if model==2
      Z = Zc*sinh(Gamal);  Y = 2*tanh(Gamal/2) /Zc;
      else, end

  if model==1,  disp(' '),  disp(' Nominal pi model'),disp(' ----------------')
      fprintf('\n'), fprintf(' Z = %g + j ',real(Z)), fprintf('%g ohms\n',imag(Z)),
      fprintf(' Y = %g + j ',real(Y)), fprintf('%g Siemens\n',imag(Y))
      elseif model==2, disp(' '), disp(' Equivalent pi model')
      disp(' -------------------')
      fprintf('\n')
      fprintf(' Z'' = %g + j ',real(Z)),  fprintf('%g ohms\n',imag(Z)),
      fprintf(' Y'' = %g + j ',real(Y)),  fprintf('%g siemens\n',imag(Y))
      fprintf(' Zc  = %g + j ',real(Zc)), fprintf('%g ohms\n',imag(Zc))
      fprintf(' alpha l  = %g neper', real(Gamal))
      fprintf('    beta l = %g radian', imag(Gamal))
      fprintf('   = %g degree\n', imag(Gamal*180/pi))
      else, end,

%  end
end
if model == -1 | model == 1 | model == 2
  %  A,B,C,D constants of line
  A = 1 + Z*Y/2;  B = Z;
  C = Y*(1 + Z*Y/4);  D = A;

  ABCD = [A B; C D];
  disp(' ')
  fprintf('         %-11.5g + j', real(A)), fprintf(' %-11.5g', imag(A))
  fprintf('   %-11.5g + j', real(B)), fprintf(' %-11.5g  \n', imag(B))
  fprintf(' ABCD =                                                             \n')
  fprintf('         %-11.5g + j', real(C)), fprintf(' %-11.5g', imag(C))
  fprintf('   %-11.5g + j', real(D)), fprintf(' %-11.5g   \n', imag(D))

else, fprintf(' You must enter 1 or 2. Tray again \n'), return, end
