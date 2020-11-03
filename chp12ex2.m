SB=1000;
f0=60; P01=500/SB; P02=400/SB;
R1 = SB/600*0.06;
R2 = SB/500*0.04;
DPL= 90/SB;
disp('(a) D = 0')
Dw = -DPL/(1/R1+1/R2)
Df = Dw*f0, f=f0+Df
DP1=-Dw/R1;
DP2=-Dw/R2;
P1=(P01+DP1)*SB
P2=(P02+DP2)*SB
disp('Graphical demonstration')
%P=0.2:0.01:0.6;
P=0:0.01:0.6;

f1=-0.10*P+1.050;
f2=-0.08*P+1.032;
f0g=ones(1, length(P));
fg =0.996*ones(1, length(P));
y=0.98:.001:0.996;
P1g=0.45*ones(1, length(y));
P2g=0.54*ones(1, length(y));
plot(P, f1, P, f2, P, f0g, P, fg, P1g, y,'--', P2g, y,'--'), grid
xlabel('Per-unit output'), ylabel('f, pu')
text(0.255, 1.026,'Unit # 1')
text(0.255, 1.013,'Unit # 2')
text(0.155, 0.994,'0.996')
disp('(b) D= 1.5')
D=1.5;
Dw = -DPL/(1/R1+1/R2+D)
Df = Dw*f0, f=f0+Df
DP1=-Dw/R1;
DP2=-Dw/R2;
disp('New generation')
P1=(P01+DP1)*SB
P2=(P02+DP2)*SB
disp('Change in load due to frequency drop')
DPL=(DP1+DP2)*SB - 90
