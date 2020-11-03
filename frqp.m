function [numopen, denopen, denclsd] = frqp(num, den)

% Hadi Saadat,  1998

%discr=[
%'                                                                           '
%'  The function [numopen,denopen,denclsd]=frqp(num, den) is used for the    '
%'  frequency response design of a P controller.  num & den are row vectors  '
%'  of polynomial coefficients of the uncompensated open-loop plant transfer '
%'  function.  The user is prompted to enter the controller gain Kp.  The    '
%'  frequency-domain specifications before and after compensation are found. '
%'  The function returns the open-loop & closed-loop numerator & denominators'
%'  of the compensated system transfer function.                             '];
%disp(discr);

r=abs(roots(den));
i=find(r>0); rp=r(i);
rmx=max(rp); rmn=min(rp); wst=0.1*round(rmn); wf=20*round(rmx);;dw=wf/800;
w=wst:dw:wf;

clc
[mag,phase]=bode(num,den,w);
[Gm, Pm, wpc, wgc]= margin(mag, phase, w);
fprintf('Uncompensated control system \n')
fprintf('Gain Margin  = %7.3g',Gm),fprintf('    Gain crossover w = %7.3g\n',wgc)
fprintf('Phase Margin = %7.3g',Pm),fprintf('   Phase crossover w = %7.3g\n',wpc)
fprintf('\n')
Kp=input('Enter the desired gain factor Kp -> ');
numopen=Kp*num; denopen=den;
[magp,phasep]=bode(numopen,denopen,w);
[Gm1, Pm1, wpc1, wgc1]= margin(magp, phasep, w);
fprintf('Gain & Phase Margins with gain compensation, Kp = %g\n',Kp)
fprintf('Gain Margin  = %7.3g',Gm1),fprintf('    Gain crossover w = %7.3g\n',wgc1)
fprintf('Phase Margin = %7.3g',Pm1),fprintf('   Phase crossover w = %7.3g\n',wpc1)
fprintf('\n')

% the following statements will form the characteristic Equation
% of the compensated system.
m=length(num); n=length(den);
if n > m
o=zeros(1,n-m); mk=[o,1]; num1=conv(num,mk);
else, num1=num, end
numopen=conv(Kp,num1);
denclsd=denopen+numopen;
[M,ph]=bode(numopen,denclsd,w);
frqspec(w,M)
%fprintf('Row vectors of polynomial coefficients of the compensated system:\n')
%fprintf('Open-loop num. '),disp(numopen)
%fprintf('Open-loop den. '),disp(denopen)
%fprintf('Closed-loop den'),disp(denclsd)
fprintf('Compensated open-loop ')
GH = tf(numopen, denopen)
fprintf('Compensated closed-loop ')
T = tf(numopen, denclsd)

discr2=[
'Roots of the compensated characteristic equation:       '];
disp(discr2)
r=roots(denclsd);
disp(r)
rreal=real(r);
  for l=1:n-1
  if rreal(l) >=0
  fprintf('   Root on the RHP, system is unstable. Reduce Kp and repeat.\n\n')
  else,end
  end
