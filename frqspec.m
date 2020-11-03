function  frqspec(w, mag)
n=length(w);
mB=mag(1)*0.707;
j=0;
Mp=max(mag);
if Mp >= mag(1)
  for i=1:n
    if mag(i) >= Mp
    np=i; wr=w(i);
    else,end
  end
else, np=1
end
for i=np:n-1
      if mag(i) >= mB
      wB1= w(i); wB2=w(i+1); maglo=mag(i+1);
      wB =(wB1+wB2)/2;
      else, end
end
if Mp > mag(1)
fprintf('Peak Mag.    = %7.3g', Mp), fprintf('    wr = %7.3g', wr)
else,end
if maglo > mB
   fprintf('\n')
   disp('Gain does not cross 70.7% times the low frequency gain.')
   disp('Extend the frequency range and repeat.\n')
   return, else end
fprintf('    Bandwidth = %7.3g\n\n', wB)
