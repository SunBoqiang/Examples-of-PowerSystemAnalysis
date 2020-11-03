% Example 6.14  Power Perturbation Method
V1= 1.05; V2 = 1.0; V3 = 1.0; d1=0.0;
S2 = -4- j*2.5;
S3 = 2 + j*1.46177;
Y = [ 20-j*50  -10+j*20    -10+j*30
     -10+j*20   26-j*52    -16+j*32
     -10+j*30  -16+j*32     26-j*62];
Ym=abs(Y); t=angle(Y);
iter=0;
pwracur = .002;   % Power accuracy
DC = 10;          % Set the max power mismatch to a high value
disp('Iter   V2       d2       V3       d3      P2       Q2      P3       Q3')
while max(abs(DC))  >= pwracur
iter = iter +1;
YS=[Y(2,2)-conj(S2)/(V2^2)   Y(2,3)
    Y(3,2)     Y(3,3)-conj(S3)/(V3)^2];
C =-[Y(2,1)*V1; Y(3,1)*V1];
V=YS\C;
S2k=(abs(V(1)))^2/(V2^2)*S2; P2k = real(S2k); Q2k = imag(S2k);
S3k=(abs(V(2)))^2/(V3^2)*S3; P3k = real(S3k); Q3k = imag(S3k);
DC =[S2k-S2; S3k-S3];
V2=abs(V(1)); d2=angle(V(1));
V3=abs(V(2)); d3=angle(V(2));
%R=[V2 d2 V3 d3  P2k  Q2k P3k Q3k];
%R=[iter V2 d2 V3 d3  S2k S3k  DC(1) DC(2)];
fprintf('%g',iter),fprintf('%9.4f', V2), fprintf('%9.4f', d2)
fprintf('%9.4f', V3), fprintf('%9.4f', d3)
fprintf('%9.4f', P2k), fprintf('%9.4f', Q2k)
fprintf('%9.4f', P3k), fprintf('%9.4f\n', Q3k)
end
P1= V1^2*Ym(1,1)*cos(t(1,1))+V1*V2*Ym(1,2)*cos(t(1,2)-d1+d2)+ ...
    V1*V3*Ym(1,3)*cos(t(1,3)-d1+d3);
Q1=-V1^2*Ym(1,1)*sin(t(1,1))-V1*V2*Ym(1,2)*sin(t(1,2)-d1+d2)- ...
    V1*V3*Ym(1,3)*sin(t(1,3)-d1+d3);
S1=P1+j*Q1
