% This function forms the bus admittance matrix including load
% admittances after removal of faulted line. The corresponding reduced
% bus admittance matrix is obtained for transient stability study.
%
% Copyright (c) 1998 by H. Saadat
function [Yaf]=ybusaf(linedata, yload, nbus1,nbust, nbrt);
global Pm f H E  Y th ngg

nl=linedata(:, 1);  nr=linedata(:, 2);
remove = 0;
while remove ~= 1
  fprintf('\nFault is cleared by opening a line. The bus to bus nos. of the\n')
  fprintf('line to be removed must be entered within brackets, e.g. [5, 7]\n')
  fline=input('Enter the bus to bus Nos. of line to be removed -> ');
  nlf=fline(1); nrf=fline(2);
     for k=1:nbrt
       if nl(k)==nlf & nr(k)==nrf
       remove = 1;
       m=k;
       else, end
    end
    if remove ~= 1
       fprintf('\nThe line to be removed does not exist in the line data. try again.\n\n')
    end
end
linedat2(1:m-1,:)= linedata(1:m-1,:);
linedat2(m:nbrt-1,:)=linedata(m+1:nbrt,:);

linedat0=linedata;
linedata=linedat2;
lfybus
for k=1:nbust
Ybus(k,k)=Ybus(k,k)+yload(k);
end
YLL=Ybus(1:nbus1, 1:nbus1);
YGG = Ybus(nbus1+1:nbust, nbus1+1:nbust);
YLG = Ybus(1:nbus1, nbus1+1:nbust);
Yaf=YGG-YLG.'*inv(YLL)*YLG;
linedata=linedat0;
