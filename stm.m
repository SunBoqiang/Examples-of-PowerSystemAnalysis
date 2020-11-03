function stm=stm(A);
L = eig(A);
n=length(A);
I=eye(n);
o=ones(n);
H=zeros(n,n);
for i=1:n-1
G(:,i)=L.^i;
end
H=[o(:,1),G];
for i=1:n-1,
  if L(i)==L(i+1),
      for j=1:n,
      H(i+1,j)=(j-1)/L(i+1)*H(i+1,j);
      end
  else
  end
end
K=inv(H);
m=n*n;
for j=1:n
for i=1:n:m
L1(j,i+j-1)=L((i+n-1)/n);
end
end
LI=L1';
FA=zeros(n,m);
for i=1:n:m
   for j=2:n
   FA(:,i:i+n-1)=FA(:,i:i+n-1)+A^(j-1)*K(j,(i+n-1)/n);
   end
F1(:,i:i+n-1)=I*K(1,(i+n-1)/n)+FA(:,i:i+n-1);
end

Head =[
' The state transition matrix is given by:                              '
'                                                                       '
' phi(t) = Sum Ci*exp(Li*t) + Sum Dj*t*exp(Lj*t)     i=1,. . .,n-j      '
' where                                                                 '
' Li = eigenvalues          & Ci = the corresponding matrix coefficients'
' Lj = repeated eigenvalues & Dj = the corresponding matrix coefficients'
'                                                                       '];
disp(Head)
%pause(4)

for i=1:n:m
k=(i+n-1)/n;
Li=L(k)
  if k>1
      if L(k)==L(k-1), Di=F1(:,i:i+n-1)
      else  Ci=F1(:,i:i+n-1)
      end
  else  Ci=F1(:,i:i+n-1)
  end
end
