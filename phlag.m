function [numopen, denopen, denclsd] = phlag(num,den,zeta)

% Hadi Saadat, 1998

discr=[
'                                                                         '
'  The function phlag(num, den, zeta) is used for the design of a phase-  '
'  lag compensator using the approximated method k =~ K0/Kc.  num & den   '
'  are row vectors of polynomial coefficients of the uncompensated open-  '
'  loop plant transfer function.  zeta is the desired damping ratio. The  '
'  user is prompted to enter gain K required for the steady-state error   '
'  specification & the magnitude of the compensator zero, Z0. [Z0 <<³s1³].'
'  The function returns the open-loop and the closed-loop numerator and   '
'  denominator of the compensated system transfer function.               '
'                                                                         '];
%disp(discr);

K=input('Enter gain K required for the steady-state error specification -> ');
Z0=input('Enter magnitude of the compensator zero -> ');
clc
%beta=atan2(imag(s1),real(s1));
%sm=abs(s1);
%[mag,phase]=ghs(num,den,s1);   % Returns the mag. and phase of G(s1)H(s1)


c1=0:.1:10; c2=11:1:100; c3=110:10:1000;
k=[c1 c2 c3]; kk=k';
j=0;
r=rlocus(num,den,k);
 ri=imag(r);  risum=sum(ri);
costhta=cos([pi-angle(r)]);
j= find (risum > .5);
if isempty(j)==1;
       disp('Warning: zeta line does not cross root-locus')
       return,else, end
 l=length(costhta);
 for i=1:l for c=1:j
     if costhta(i,c) ==-1 costhta(i,c)=1; end,end,end
cost=(costhta(:,j));
l=length(cost);
if cost(1) > zeta
        i = find(cost < zeta);
else
        i = find(cost > zeta);
end
if length(i) == 0
        disp('Warning: zeta line does not cross root-locus'),return
else
while i(1)>l i(1)=i(1)-l; end

        i2 = i(1);
        i1 = i2 - 1;
        k1 = min(kk(i1,:));
        k2 = min(kk(i2,:)) ;
        m1 = min(cost(i1,:));
        m2 = min(cost(i2,:));
        K0 = k1 + (m1-zeta)*(k2-k1)/(m1-m2);
end
K0=round(100*K0)/100;
clc
fprintf('   Gain for the desired closed-loop pole      K0 = %g\n\n',K0)
fprintf('   Gain for the desired steady-state response K  = %g\n\n',K)
Kc=K0/K;
P0=Kc*Z0;
KKc=K*Kc;
fprintf('   Gc(0) = %g',1),fprintf(',      Gc = %g',Kc),fprintf('(s + %g',Z0),
fprintf(')/(s + %g',P0), fprintf(')\n\n')
% the following statements will form the characteristic Equation
% of the compensated system.
m=length(num); n=length(den);
if n > m
o=zeros(1,n-m); mk=[o,1]; num1=conv(num,mk);
else, num1=num, end
numgc=[KKc,KKc*Z0]; numopen=conv(numgc,num1);
dengc=[1,P0];       denopen=conv(dengc,den);
denclsd=denopen+numopen;
%fprintf('Row vectors of polynomial coefficients of the compensated system:\n\n')
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
  for l=1:n
  if rreal(l) >=0
  fprintf('   Root on the RHP, system is unstable.\n')
  fprintf('   Change Z0 or K & repeat.\n\n')
  else,end
  end
