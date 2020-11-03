function ltstm = ltstm(A)
clc
%  This program obtains the Laplace transform of the state transition matrix
%  i.e. phi(s) = Inverse{[sI - A]}
%  The program is based on the Faddeeva algorithm. See computational methods
%  of Linear algebra, Dover Publ. Also see introduction to control systems by
%  B. Watkins, Macmillan Publ.
%
%  H. Saadat
Head = [
' phi(s) = inv(SI - A) = P / q  where,                          '
' P = s**(n-1)E(n-1) + S**(n-2)E(n-2) + . . . + E(0)            '
' q = a(n)s**n + a(n-1)s**n-1 + a(1)s + . . . + a(0)            '
' a(i) = coefficients of the characteristic equation q          '
'                                                               '
' The E matrices in descending power of s are :                 '];
disp(Head)

n= length(A);
a=poly(A);
F(:,1:n) =eye(n);
E=F(:,1:n)
for i=1:n-1
F(:,(i*n+1):(i+1)*n)=A*F(:,(i-1)*n+1:i*n)+a(i+1)*eye(n);
E=F(:,(i*n+1):(i+1)*n)
end
a
