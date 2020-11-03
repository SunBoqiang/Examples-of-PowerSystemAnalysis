% This function forms the bus admittance matrix including load
% admittances before fault.  The corresponding reduced bus
% admittance matrix is obtained for transient stability study.
%
% Copyright (c) 1998 by H. Saadat

function [Ybus, Ybf] = ybusbf(linedata, yload, nbus1, nbust)
global Pm f H E  Y th ngg

lfybus
for k=1:nbust
Ybus(k,k)=Ybus(k,k)+yload(k);
end
YLL=Ybus(1:nbus1, 1:nbus1);
YGG = Ybus(nbus1+1:nbust, nbus1+1:nbust);
YLG = Ybus(1:nbus1, nbus1+1:nbust);
Ybf=YGG-YLG.'*inv(YLL)*YLG;
