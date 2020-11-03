%   Power Flow Solution by the Power Perturbation Technique
%   Copyright (c) 1998 H. Saadat

ns=0;
nbus = length(busdata(:,1));
for k=1:nbus
n=busdata(k,1);
kb(n)=busdata(k,2); Vm(n)=busdata(k,3); delta(n)=busdata(k, 4);
Pd(n)=busdata(k,5); Qd(n)=busdata(k,6); Pg(n)=busdata(k,7); Qg(n) = busdata(k,8);
Qmin(n)=busdata(k, 9); Qmax(n)=busdata(k, 10);
Qsh(n)=busdata(k, 11);
    if Vm(n) <= 0  Vm(n) = 1.0; V(n) = 1 + j*0;
    else delta(n) = pi/180*delta(n);
         V(n) = Vm(n)*(cos(delta(n)) + j*sin(delta(n)));
         P(n)=(Pg(n)-Pd(n))/basemva;
         Q(n)=(Qg(n)-Qd(n)+ Qsh(n))/basemva;
         S(n) = P(n) + j*Q(n);
    end
if kb(n) == 1, ns = ns+1; else, end
nss(n) = ns;
end
ii=0;
for ib=1:nbus
     if kb(ib) == 0 | kb(ib) == 2
     ii = ii+1;
      jj=0;
         for jb=1:nbus
             if kb(jb) == 0 | kb(jb) == 2
             jj = jj+1;
             Y1(ii,jj)=Ybus(ib,jb);
             else,end
         end
     else, end
end
YS =Y1;
maxerror = 1;
iter = 0;
% Start of iterations
while maxerror >= accuracy & iter <= maxiter % Test for max. power mismatch
iter = iter+1;
id=0; iv=0;
  for n=1:nbus
  nn=n-nss(n);
    if kb(n) ~=1
    I(nn)=0;
      for ii=1:nbr
        if nl(ii) == n | nr(ii) == n
           if nl(ii) == n,  l = nr(ii); end
           if nr(ii) == n,  l = nl(ii); end
              if kb(l)==1
              I(nn)=I(nn)-Ybus(n,l)*V(l); end
        else, end
      end
     YS(nn,nn) = Y1(nn,nn)- conj(S(n))/Vm(n)^2 ;
    else,end
  end
Vk = YS\conj(I');
  for n=1:nbus
    if kb(n)~=1
    nn=n-nss(n);
    V(n) = Vk(nn);
    Pk(n)= (abs(Vk(nn)))^2/(Vm(n))^2*P(n);
    Qk(n)= (abs(Vk(nn)))^2/(Vm(n))^2*Q(n);
    Vm(n)=abs(Vk(nn));
    else, end
    if kb(n)==1
    Pk(n)=P(n); Qk(n)=Q(n); else, end
  end
DP = Pk - P;
DQ = Qk - Q;
maxerror=max(max(abs(DP)),max(abs(DQ)));
end
for ii=1:nbus
  if kb(ii) ==1
     S1=0;
     for jj=1:nbus
     S1 = S1 + conj(Ybus(ii,jj))*conj(V(jj));
     end
  S(n)=V(ii)*S1;
  Pk(ii) = real(S(n));
  Qk(ii) = imag(S(n));
  else,end
end
P = Pk; Q = Qk; S = P+j*Q;
delta=angle(V);
deltad=180/pi*delta;
%clear Ybus; clear Ym; clear t, clear A; clear DC; clear DX
  tech=('               Power Flow Solution by Power Perturbation Technique');
k=0;
for n = 1:nbus
     if kb(n) == 1
     S(n)=P(n)+j*Q(n);
     Pg(n) = P(n)*basemva + Pd(n);
     Qg(n) = Q(n)*basemva + Qd(n) - Qsh(n);
     k=k+1;
     Pgg(k)=Pg(n);
     elseif  kb(n) ==2
     S(n)=P(n)+j*Q(n);
     Qg(n) = Q(n)*basemva + Qd(n) - Qsh(n);
     k=k+1;
     Pgg(k)=Pg(n);
     Qgg(k)=Qg(n);     %june 97
     end
yload(n) = (Pd(n)- j*Qd(n)+j*Qsh(n))/(basemva*Vm(n)^2);
end
busdata(:,3)=Vm'; busdata(:,4)=deltad';
Pgt = sum(Pg);  Qgt = sum(Qg); Pdt = sum(Pd); Qdt = sum(Qd); Qsht = sum(Qsh);
clear Pk Qk DP DQ DV I S1 Vk Y1 YS delta ib id ii iv jb jj
