function  V = obsvable(A,C)

%  H. Saadat,  1998
clc
% discr=[
%' The  function V=obsvable(A,C) returns the transformation matrix  '
%' V = [C; CA; CA^2; . . . CA^(n-1)]. The system is completely state'
%' observable if and only if V has a rank of n.                     '
%'                                                                  '];
%disp(discr)

n=length(A);
  for i=1:n;
  V(n+1-i,:) = C*A^(n-i);
  end
  if rank(V)~=n
  disp('System is not state observable')
  else
  disp('System is state observable')
  end
