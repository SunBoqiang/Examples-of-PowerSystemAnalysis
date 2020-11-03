Ym=abs(Ybus); t = angle(Ybus);
%m=ng+ns;
clear A  J
for i=1:m
for k=1:m
   A(i,k)=0;      %Initializing Jacobian matrix
end, end

nn=0;
for n=1:nbus
    %nn=n-nss(n);
    %lm=nbus+n-ngs(n)-nss(n)-ns;
    if kb(n)~= 0
       nn=nn+1;
       J44=0;
         mm=0;
         for i=1:nbr
            if nl(i) == n | nr(i) == n
               if nl(i) == n,  l = nr(i); end
               if nr(i) == n,  l = nl(i); end
               J44=J44+ Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
                  if kb(l) ~=0
                     %l
                     %mm=mm+1
                    %if mm~=nn % Must be modified
                    A(nn, l) =-Vm(n)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
                    %else, end
                  else, end
            else, end
         end

     %nn,  %J44
     A(nn,nn) =-2*Vm(n)*Ym(n,n)*sin(t(n,n))-J44;  %diagonal of elements of J4


     else, end
 end
