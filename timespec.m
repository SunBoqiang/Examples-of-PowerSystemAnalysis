function timespec(num, den)

%  Hadi Saadat,  1998

   discr=[
 ' function timespec(num, den) returns the time domain performance        '
 ' specifications of the system step response.  num & den are row vectors '
 ' of the numerator & denominator coefficients of the closed-loop transfer'
 ' function.                                                              '
 '                                                                        '];
% disp(discr)

m=length(num); n=length(den);
[pn,r,k]=residue(num,den);
nr=length(r);
for i=1:nr
      if r(i) >=0  disp('Unbounded response'), return
      else, end
end
rp=abs(real(r)); i=find(rp>0 & abs(pn) >.0001); rn0=rp(i);
rmn=min(rn0); tf=10/rmn; dt=tf/1000;
tf1=tf;  % new
Css=num(m)/den(n);
if Css==inf
   disp('Unbounded response')
   return,else end

t=0:dt:tf;
tt=t;  %new
l=length(t);  l1=length(t); % new
c=step(num, den, t);  c1=c; % new
if c(l) > Css+0.1*Css | c(l) < Css-0.1*Css
disp(' Unbounded response'),return
else,end

j=0 ;m =0;
Cmax=max(c);

if Cmax > Css
   po= (Cmax - Css)/Css * 100;
   i=find(c==Cmax); tp=t(i); else,tp=0; end

if tp < 10*dt & tp>0
   tf=round(10*tp); dt=tf/200;
   t=0:dt:tf;
   l=length(t);
   c=step(num, den, t);
   j=0 ;m =0;
   Cmax=max(c);
else, end
if Cmax > Css
   po= (Cmax - Css)/Css * 100;
   i=find(c==Cmax); tp=t(i);

   fprintf('Peak time = %g',tp),fprintf('         Percent overshoot = %g',po),
else, tp=0;end

     for i =1:l
          if  j == 0
              if c(i) >= 0.1*Css  t1=t(i); j=1;
              end
          else, end
          if  m ==0
              if c(i) >= 0.9*Css  t9 = t(i); m =1;
              end
          else, end
      end
%end
if t9 ~= 0
  tr = t9 -t1;
fprintf('\n')
fprintf('Rise time = %g',tr),fprintf('\n')
end
tfu=1.02*Css; tfd=.98*Css;
if tp > tr  t0=tp; else t0=tr; end
if Cmax <= tfu  t0 = tr; else; end

ts1=0;ts2=0;

for i=1:l1
 if tt(i) >t0 & tt(i) <tf1
    if c1(i) >= tfu; ts1=tt(i); else, end
    if c1(i) <= tfd; ts2=tt(i); else, end

    else,end

end
ts=max(ts1,ts2);
fprintf('Settling time = %g ',ts),fprintf('\n\n')
