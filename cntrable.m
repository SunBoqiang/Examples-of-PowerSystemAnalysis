function  S = cntrable(A,B)
%  H. Saadat 1998
clc
% discr=[
%' The  function S=cntrable(A,B) returns the transformation matrix  '
%' S = [B AB A^2B . . . A^(n-1)B].  The system is completely state  '
%' controllable if and only if S has a rank of n.                   '
%'                                                                  '];
n=length(A);
  for i=1:n;
  S(:,n+1-i) = A^(n-i)*B;
  end
  if rank(S)~=n
  disp('System is not state controllable')
  else
  disp('System is state controllable')
  end
