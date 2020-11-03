function c = stepres(Z, wn, R, A, T, t)
% Hadi Saadat,  1998
clc
discr=[
'                                                                      '
'This program obtains the step response for the s-domain function given'
'below:  The graphical time response c(t) is plotted on the screen and '
'the time-domain specifications are obtained.                          '
'                                                                      '
'                    wn^2(1 + as)                                      '
'   C(s) = -------------------------------- R(s) ,    where R(s) = R/s '
'           (1 + Ts)(s^2 + 2 z wn s + wn^2)                            '];
disp(discr)
l=length(t);
K=R;
if Z < 1
  Z1=1.-Z^2;
  CN1=1-2.*Z*A*wn + A^2*wn^2;
  CD11=1.-2.*T*Z*wn+T^2*wn^2;
  CD1=Z1*CD11;
  C1=sqrt(CN1/CD1);
  CN2=wn^2*T*(A-T);
  C2=CN2/CD11;
  B=sqrt(Z1);
  AFR=A*wn*B;
  AFI=1.-A*Z*wn;
  F1=atan2(AFR,AFI);
  BFR=T*wn*B;
  BFI=1.-T*Z*wn;
  F2=atan2(BFR,BFI);
  CFR=B;
  CFI=-Z;
  F3=atan2(CFR,CFI);
  F= F1-F2-F3;
  ALF=Z*wn ;
    if T ~=  0
    ALF2=1./T;
    else
    end
  FT=3;
  if T ~= 0
   c=K*(1.+C1*exp(-ALF*t).*sin(wn*B*t+F)+C2*exp(-ALF2*t));
   else
   c=K*(1.+C1*exp(-ALF*t).*sin(wn*B*t+F));
   end
else
end
if Z > 1
  bta=sqrt(Z^2 - 1);  p1 = Z*wn -wn*bta; p2 = Z*wn+wn*bta;
  if T ~= 0
   k1 = 1/(p1*p2); k2 = -(1-A/T)/( (-1/T+p1)*(-1/T+p2) );
   k3 = -(1-A*p1)/( T*p1*(-p1+1/T)*(-p1+p2) );
   k4 = -(1-A*p2)/( T*p2*(-p2+1/T)*(-p2+p1) );
   c= K*wn^2*( k1 + k2*exp(-1/T*t) + k3*exp(-p1*t) + k4*exp(-p2*t) );
   else
   k1 = 1/(p1*p2);
   k3 = -(1-A*p1)/( p1*(-p1+p2));
   k4 = -(1-A*p2)/( p2*(-p2+p1)) ;
   c= K*wn^2*( k1 +  k3*exp(-p1*t) + k4*exp(-p2*t) );
   end
else
end
if Z ==1
   p=Z*wn;
   if T ~= 0
   k1 = 1/(p^2); k2 = -(1-A/T)/((-1/T+p)^2);
   k3 = -(1-A*p)/( T*p*(-p+1/T) );
   k4 = (-A*p*(-p+1/T)-(-2*p+1/T)*(-A*p+1))/( T*(-p)^2*(-p+1/T)^2 );
   c= K*wn^2*( k1 + k2*exp(-1/T*t) + k3*t.*exp(-p*t) + k4*exp(-p*t) );
   else
   k1 = 1/(p^2); k3 =-(1-A*p)/p;
   k4 =(-A*p - (1-A*p) )/( (-p)^2 );
   c= K*wn^2*( k1 +  k3*t.*exp(-p*t) + k4*exp(-p*t) );
   end
end
j=0 ;m =0;
Cmax=max(c);
if Cmax > K
   overshoot= (Cmax - K)/K * 100;
   for i=1:l
       if c(i) == Cmax , tmax=t(i);
       end

       if A ==0
          if T==0
             sz=sqrt(1-Z^2);
             overshoot = 100*exp(-pi*Z/sz);
             tmax = pi/(wn*sz);
             else, end
        else,end
   end
fprintf('\n\n'),
fprintf('Peak time = %g',tmax),fprintf('         Percent overshoot = %g',overshoot),

%else
else,end
     for i =1:l
          if  j == 0
              if c(i) >= 0.1*K, t1=t(i); j=1;
              end
          else, end
          if  m ==0
              if c(i) >= 0.9*K t9 = t(i); m =1;
              end
          else, end
      end
end
if t9 ~= 0
  trise = t9 -t1;
fprintf('\n')
fprintf('Rise time = %g',trise),fprintf('\n\n')
end
clg
plot(t,c)
xlabel('  Time    Sec.  '), ylabel('  c(t)  ')
title('Step Response'),grid
