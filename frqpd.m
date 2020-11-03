function [numopen, denopen, denclsd] = frqpd(num, den)
% Hadi Saadat,  1998

%discr=[
%'                                                                           '
%'  The function [numopen,denopen,denclsd]=frqpd(num, den) is used for the   '
%'  frequency response design of a PD controller.    num & den are           '
%'  row vectors of polynomial coefficients of the uncompensated open-loop    '
%'  plant transfer function. Design is based on the phase margin criterion.  '
%'  The user is prompted to enter the desired Phase Margin. The program finds'
%'  and displays a gain crossover frequency range for an stable controller.  '
%'  The user is then prompted to enter the gain crossover frequency in this  '
%'  range.  The controller transfer function and the frequency-domain        '
%'  specifications before and after compensation are found.  The function    '
%'  returns the open-loop and the closed-loop numerator and denominators of  '
%'  the compensated system transfer function.                                '];

%disp(discr);

r=abs(roots(den));
i=find(r>0); rp=r(i);
rmx=max(rp); rmn=min(rp); wst=0.1*round(rmn); wf=20*round(rmx);;dw=wf/800;
w=wst:dw:wf;

clc
pm=input('Enter the desired phase margin -> ');
[mag, phase] = bode(num, den, w);
phase=180/pi*unwrap(phase*pi/180);

if phase(1) > (-180+pm)
     i = find(phase < (-180 + pm));
else
     i = find(phase > (-180 + pm));
end
if length(i)==0
     disp('Phase does not cross (-180 + P.M.). ')
return, else
     i2=i(1); i1 = i2 -1;
     if i1 ==0 wpm=w(i2); else
     wa = w(i1); wb = w(i2); p1 = phase(i1); p2 = phase(i2);
     wpm = wa + (-180+pm - p1)/(p2-p1)*(wb-wa);
     end
end

w1=wpm;
[M,ph]=bode(num, den, w1);  % Returns the mag. and phase of G(w)H(w1)
thta=-180 + pm - ph;
thtar=thta*pi/180;

stab=0;
wmx=10*w1; dw1=wmx/100;
while sin(thtar)/(M*w1) < 0 | cos(thtar) < 0  & w1 < wmx
  w1=w1+dw1;
  [M,ph]=bode(num, den, w1);  % Returns the mag. and phase of G(w)H(w1)
  thta=-180 + pm - ph;
  thtar=thta*pi/180;
end
w1mn=w1;

[M,ph]=bode(num, den, w1);  % Returns the mag. and phase of G(w)H(w1)
thta=-180 + pm - ph;
thtar=thta*pi/180;

while sin(thtar)/(M*w1) > 0 & cos(thtar) > 0  & w1 < wmx
  stab=stab+1;
  w1=w1+dw1;
  [M,ph]=bode(num, den, w1);  % Returns the mag. and phase of G(w)H(w1)
  thta=-180 + pm - ph;
  thtar=thta*pi/180;
end
w1mx=w1-dw1;
if stab==0
  fprintf('Unstable controller. Reduce Phase Margin and repeat.\n'),
  return
  else
  fprintf('For a stable controller select a compensated gain crossover\n')
  fprintf('frequency wgc between %7.3g',w1mn),fprintf(' and %7.3g\n',w1mx)
end

w1=input('Enter wgc -> ');
[M,ph]=bode(num, den, w1);  % Returns the mag. and phase of G(w)H(w1)
thta=-180 + pm - ph;
thtar=thta*pi/180;
Kp= cos(thtar)/M;
KD=sin(thtar)/(w1*M);

clc
fprintf('Uncompensated control system \n')
[Gm1, Pm1, wpc1, wgc1]=margin(mag, phase, w);
fprintf('Gain Margin  = %7.3g',Gm1),fprintf('    Gain crossover w = %7.3g\n',wgc1)
fprintf('Phase Margin = %7.3g',Pm1),fprintf('   Phase crossover w = %7.3g\n',wpc1)
fprintf('\n')
fprintf('Controller transfer function \n')
fprintf('     Gc = %g',Kp),fprintf(' + %g',KD),
fprintf('s \n\n')
% the following statements will form the characteristic Equation
% of the compensated system.
m=length(num); n=length(den);
if n > m
o=zeros(1,n-m); mk=[o,1]; num1=conv(num,mk);
else, num1=num, end
numgc=[KD,Kp]; numopen=conv(numgc,num1);
dengc=[0, 1];  denopen=conv(dengc, den);
denclsd=denopen+numopen;
%fprintf('Row vectors of polynomial coefficients of the compensated system:\n')
%fprintf('Open-loop num. '),disp(numopen)
%fprintf('Open-loop den. '),disp(denopen)
%fprintf('Closed-loop den'),disp(denclsd)
fprintf('Compensated open-loop ')
GH = tf(numopen, denopen)
fprintf('Compensated closed-loop ')
T = tf(numopen, denclsd)

[magp,phasep]=bode(numopen,denopen,w);
[Gm, Pm, wpc,wgc]=margin(magp,phasep,w);
if Pm>360 Pm=Pm-360; else, end
fprintf('Gain Margin  = %7.3g',Gm),fprintf('    Gain crossover w = %7.3g\n',wgc)
fprintf('Phase Margin = %7.3g',Pm),fprintf('   Phase crossover w = %7.3g\n',wpc)
fprintf('\n')
[M,ph]=bode(numopen,denclsd, w);
frqspec(w,M)

discr2=[
'Roots of the compensated characteristic equation:       '];
disp(discr2)
r=roots(denclsd);
disp(r)
rreal=real(r);
  for l=1:n-1
  if rreal(l) >=0
  fprintf('   Root on the RHP, system is unstable. Change Phase Margin and repeat.\n\n')
  else,end
  end
