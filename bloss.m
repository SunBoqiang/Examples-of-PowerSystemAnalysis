% This program named 'bloss' obtains the B-coefficients of the
% loss formula as the function of real power generation.
%
%         PL = P*B*P'+B0*P'+B00.
%
% It requires the power flow solution. To obtain the B-coefficients use the command bloss after
% the command 'bloss' after any of the power flow programs lfgauss,
% lfnewton, or decouple.
%
% Copyright (C)1998 by H. Saadat.

clear B B0 B00
Zbus=inv(Ybus);
ngg=0;
I=-1/basemva*(Pd-j*Qd)./conj(V); %new
ID= sum(I);  %new

for k=1:nbus
  if kb(k)== 0
%    I(k) = conj(S(k))/conj(V(k));
%   else, ngg=ngg+1; I(k)=0;  end
    else, ngg=ngg+1;  end
   if kb(k)==1 ks=k; else, end
end
%ID= sum(I);
d1=I/ID;
DD=sum(d1.*Zbus(ks,:));  %new
kg=0; kd=0;
for k=1:nbus
    if kb(k)~=0
    kg=kg+1;
    t1(kg) = Zbus(ks,k)/DD;   %new
    else, kd=kd+1;
    d(kd)=I(k)/ID;
    end
end
nd=nbus-ngg;
C1g=zeros(nbus, ngg);
kg=0;
for k=1:nbus
  if kb(k)~=0
  kg=kg+1;
    for m=1:ngg
       if kb(m)~=0
        C1g(k, kg)=1;
       else, end
    end
  else,end
end
C1gg=eye(ngg,ngg);
C1D=zeros(ngg,1);
C1=[C1g,conj(d1)'];
C2gD=[C1gg; -t1];
CnD=[C1D;-t1(1)];
C2=[C2gD,CnD];
C=C1*C2;
kg=0;
for k=1:nbus
  if kb(k)~=0
  kg=kg+1;
  al(kg)=(1-j*((Qg(k)+Qsh(k))/Pg(k)))/conj(V(k));  %new
  else,end
end
alp=[al, -V(ks)/Zbus(ks,ks)];
for k=1:ngg+1
    for m=1:ngg+1
    if k==m
    alph(k,k)=alp(k);
    else, alph(k,m)=0;end
end,end
T = alph*conj(C)'*real(Zbus)*conj(C)*conj(alph);
BB=0.5*(T+conj(T));
for k=1:ngg
    for m=1:ngg
    B(k,m)=BB(k,m);
    end
    B0(k)=2*BB(ngg+1,k);
end
B00=BB(ngg+1,ngg+1);
B, B0, B00
PL = Pgg*(B/basemva)*Pgg'+B0*Pgg'+B00*basemva;
fprintf('Total system loss = %g MW \n', PL)
clear I BB C C1 C1D C1g C1gg C2 C2gD CnD DD ID T al alp alph t1 d d1 kd kg ks nd ng
