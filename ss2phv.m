function [a,b] = ss2phv(A,B)
%ss2phv Transforms a general state variable equation into phase variable form
%                                                          n-1
%       for a given A and B if the matrix S =[B  AB  ... A   B] is nonsigular

%       H. Saadat,  1998


n=length(A);
  for i=1:n;
  S(:,n+1-i) = A^(n-i)*B;
  end
  if rank(S)~=n
  error('S is singular, cannot find the transformation matix')
  else
T=inv(S);
q1=T(n,:);
  for i =1:n;
  Q(n+1-i,:)=q1*A^(n-i);
  end
clc
disp('The transformation matrix is')
Q
a = Q*A*inv(Q);
b = Q*B;
   end
