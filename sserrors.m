function  sserrors(z,p,k)
if(k)==0
  [z,p,k]=tf2zp(z,p);
  else
end
p=-p;
z=-z;
systype=0;
km=1;
kn=1;

n=length(p);
m=length(z);
for i=1:m
  if(z(i)) ~= 0
     if(z(i)) ~=-inf
     km=km*z(i);
     else
     end
   else
   end
end
for i=1:n
if(p(i))== 0
   systype=systype+1;
   else
     if(p(i)) ~=-inf
     kn=kn*p(i);
     end
   end
end
Kc=k*km/kn;

if(systype)==0
  Kp = Kc; Kv = 0; Ka = 0;
  EssStep = 1/(1+Kc); EssRamp = inf; EssParab = inf;
  end

if(systype)== 1
  Kp = inf; Kv = Kc;  Ka = 0;
  EssStep = 0; EssRamp = 1/Kv; EssParab = inf;
  end

if(systype)== 2
  Kp = inf; Kv = inf ; Ka = Kc;
  EssStep = 0; EssRamp = 0; EssParab = 1/Ka;
  end
  fprintf('System type is %2.0f \n\n',systype)

disp('Error Constants:')
disp('      Kp    Kv    Ka  ')
disp([Kp,Kv,Ka])
disp('Steady-state Errors:')
disp('        Step    Ramp   Parabolic')
disp([EssStep, EssRamp,EssParab])
