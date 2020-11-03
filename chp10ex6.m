Zdata1=[0  1    0   0.25
        0  2    0   0.25
        1  2    0   0.125
        1  3    0   0.15
        2  3    0   0.25];
Zbus1 = zbuild(Zdata1)

Zdata0=[0  1    0   0.40
        0  2    0   0.10
        1  2    0   0.30
        1  3    0   0.35
        2  3    0   0.7125];
Zbus0 = zbuild(Zdata0)

z12012 = [j*0.3;    j*0.125; j*0.125];
z13012 = [j*0.35;   j*0.15;  j*0.15];
z23012 = [j*0.7125; j* 0.25; j*0.25];
Z13012 = [Zbus0(1,3); Zbus1(1,3); Zbus1(1,3)];
Z23012 = [Zbus0(2,3); Zbus1(2,3); Zbus1(2,3)];
Z33012 = [Zbus0(3,3); Zbus1(3,3); Zbus1(3,3)];
%sctm;  % Symmetrical components transformation matrix
Zf = j*0.1;

disp('(a) Balanced three-phase fault at bus 3 through a fault imp. Zf = j0.1')
I31 = 1.0/(Zbus1(3,3) + Zf);
I32= 0; I30 = 0;
I3012 = [I30; I31; I32]
I3abc = sctm*I3012;
I3abcp = rec2pol(I3abc)

V1f012=[0; 1; 0] - Z13012.*I3012
V2f012=[0; 1; 0] - Z23012.*I3012
V3f012=[0; 1; 0] - Z33012.*I3012
V1fabc = sctm*V1f012;
V2fabc = sctm*V2f012;
V3fabc = sctm*V3f012;
V1fabcp=rec2pol(V1fabc)
V2fabcp=rec2pol(V2fabc)
V3fabcp=rec2pol(V3fabc)

I21012 = (V2f012-V1f012)./z12012
I13012 = (V1f012-V3f012)./z13012
I23012 = (V2f012-V3f012)./z23012
I21abc = sctm*I21012;
I13abc = sctm*I13012;
I23abc = sctm*I23012;
I21abcp = rec2pol(I21abc)
I13abcp = rec2pol(I13abc)
I23abcp = rec2pol(I23abc)

disp('(b) Single line-to-ground fault at bus 3 through a fault imp. Zf = j0.1')
I30 = 1.0/(Zbus1(3,3) + Zbus1(3,3)+ Zbus0(3,3)+3*Zf);
I31= I30; I32 = I30;
I3012 = [I30; I31; I32]
I3abc = sctm*I3012
I3abcp = rec2pol(I3abc);
%I3abcM=abs(I3abc), %I3abcA=angle(I3abc)*180/pi

V1f012=[0; 1; 0] - Z13012.*I3012
V2f012=[0; 1; 0] - Z23012.*I3012
V3f012=[0; 1; 0] - Z33012.*I3012
V1fabc = sctm*V1f012;
V2fabc = sctm*V2f012;
V3fabc = sctm*V3f012;
V1fabcp=rec2pol(V1fabc)
V2fabcp=rec2pol(V2fabc)
V3fabcp=rec2pol(V3fabc)

I21012 = (V2f012-V1f012)./z12012
I13012 = (V1f012-V3f012)./z13012
I23012 = (V2f012-V3f012)./z23012
I21abc = sctm*I21012;
I13abc = sctm*I13012;
I23abc = sctm*I23012;
I21abcp = rec2pol(I21abc)
I13abcp = rec2pol(I13abc)
I23abcp = rec2pol(I23abc)


disp('(c) Line-to-line fault at bus 3 through a fault imp. Zf = j0.1')
I30 = 0;
I31 = 1.0/(Zbus1(3,3) + Zbus1(3,3)+ Zf);
I32 = -I31;
I3012 = [I30; I31; I32]
I3abc = sctm*I3012;
I3abcp = rec2pol(I3abc)
%I3abcM=abs(I3abc), I3abcA=angle(I3abc)*180/pi

V1f012=[0; 1; 0] - Z13012.*I3012
V2f012=[0; 1; 0] - Z23012.*I3012
V3f012=[0; 1; 0] - Z33012.*I3012
V1fabc = sctm*V1f012;
V2fabc = sctm*V2f012;
V3fabc = sctm*V3f012;
V1fabcp=rec2pol(V1fabc)
V2fabcp=rec2pol(V2fabc)
V3fabcp=rec2pol(V3fabc)

I21012 = (V2f012-V1f012)./z12012
I13012 = (V1f012-V3f012)./z13012
I23012 = (V2f012-V3f012)./z23012
I21abc = sctm*I21012;
I13abc = sctm*I13012;
I23abc = sctm*I23012;
I21abcp = rec2pol(I21abc)
I13abcp = rec2pol(I13abc)
I23abcp = rec2pol(I23abc)


disp('(d) Double line-to-ground fault at bus 3 through a fault imp. Zf = j0.1')
I31 = 1.0/(Zbus1(3,3) + Zbus1(3,3)*(Zbus0(3,3) + 3*Zf)/(Zbus1(3,3)+Zbus0(3,3)+ ...
3*Zf));
I32 = -(1.0 - Zbus1(3,3)*I31)/Zbus1(3,3);
I30 = -(1.0 - Zbus1(3,3)*I31)/(Zbus0(3,3) + 3*Zf);
I3012 = [I30; I31; I32]
I3abc = sctm*I3012;
%I3abcM=abs(I3abc), %I3abcA=angle(I3abc)*180/pi
I3abcp = rec2pol(I3abc)

I3f=I3abc(2)+I3abc(3); I3f=rec2pol(I3f)
V1f012=[0; 1; 0] - Z13012.*I3012
V2f012=[0; 1; 0] - Z23012.*I3012
V3f012=[0; 1; 0] - Z33012.*I3012
V1fabc = sctm*V1f012;
V2fabc = sctm*V2f012;
V3fabc = sctm*V3f012;
V1fabcp=rec2pol(V1fabc)
V2fabcp=rec2pol(V2fabc)
V3fabcp=rec2pol(V3fabc)

I12012 = (V1f012-V2f012)./z12012
I13012 = (V1f012-V3f012)./z13012
I23012 = (V2f012-V3f012)./z23012
I12abc = sctm*I12012;
I13abc = sctm*I13012;
I23abc = sctm*I23012;
I12abcp = rec2pol(I12abc)
I13abcp = rec2pol(I13abc)
I23abcp = rec2pol(I23abc)
