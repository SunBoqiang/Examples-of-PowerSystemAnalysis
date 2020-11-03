% This function forms the bus admittance matrix including load
% admittances during fault.  The corresponding reduced bus
% admittance matrix is obtained for transient stability study.
%
% Copyright (c) 1998 by H. Saadat

function Ypf=ybusdf(Ybus, nbus1, nbust, nf)
global Pm f H E  Y th ngg
nbusf=nbust-1;
Ybus(:,nf:nbusf)=Ybus(:,nf+1:nbust);
Ybus(nf:nbusf,:)=Ybus(nf+1:nbust,:);
YLL=Ybus(1:nbus1-1, 1:nbus1-1);
YGG = Ybus(nbus1:nbusf, nbus1:nbusf);
YLG = Ybus(1:nbus1-1, nbus1:nbusf);
Ypf=YGG-YLG.'*inv(YLL)*YLG;
