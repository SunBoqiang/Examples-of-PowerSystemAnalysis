% Function routh(a) constructs the Routh table for a polynomial of degree n
% Hadi Saadat,  1998
function  routh(a)
head=['                        '
      '    Routh-Hurwitz Array '
      '                        '];
n=length(a);
jw=0;
m=2;
nc=round(n/2);
b=zeros(n,nc);
z=zeros(1,nc);
if round(n/2) > n/2
a(n+1)=0;
else,end
for i=1:2:n
k=(i+1)/2;
b(1,k)=a(i);
b(2,k)=a(i+1);
end
if b(2 ,:)==z
   fprintf('Elements of row %g',2)
   fprintf(' are all zero.\n')
   fprintf('They are replaced by the auxiliary Eq. coefficients \n\n')
   jw=1;
   for k=1:nc
   j=n-1;  d=j+2-2*k;
   b(2,k)=d*b(1,k);
   end
else,end
for i=1:n-2
  for j=1:nc-1
     if b(i+1,1)==0
     b(i+1,1)=0.00001;
     fprintf('Zero in the first column is replaced by 0.00001 \n\n')
     else,end
     b(m+i,j)=(b(i+1,1)*b(i, j+1)-b(i+1,j+1)*b(i,1)) /b(i+1,1);
  end

    if b(m+i,:) == z
     if m+i <n

      fprintf('Elements of row %g',m+i)
      fprintf(' are all zero.\n')
      fprintf('They are replaced by the auxiliary Eq. coefficients \n\n')
      jw=1;
        for k=1:nc
           j=n-m-i+1;
           d=j+2-2*k;
           if d< 0
           b(m+i,k)= b(m+i-1,k);
           else,
           b(m+i,k)=d*b(m+i-1,k);
           end
        end
      else, jw=3; end
    else,end
end
disp(head)
format short e
disp(b)
format short
j=0 ;nr=0;
for i= 1:n
   if j ==0
       if b(i,1) <0 ,nr=nr+1 ;j =1;
       else,end
     else,if b(i,1) > 0 ,nr=nr+1; j=0 ; else, end
   end
end


if jw==3, fprintf('Characterisitc Equation contain root at origin\n'),end
if jw==1, fprintf('Characteristic Equation include roots on jw-axis or \n')
     fprintf('pairs of real or complex roots symmetrical about jw-axis \n\n'),end
if nr==0
    if jw==0, fprintf('System is stable \n\n'),end
    else,fprintf('There are %g',nr)
fprintf(' roots in the right half s-plane \n\n'),end
