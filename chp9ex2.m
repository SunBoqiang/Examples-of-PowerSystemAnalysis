z12 = j*.8; z13 = j*.4; z23 = j*.4;
Ybus = j*[-8.75    1.25   2.5
           1.25   -6.25   2.5
           2.5     2.50  -5.0];
Zbus = inv(Ybus)
Zf = j*.16;
V0=[1; 1; 1];
I3F = V0(1)/(Zbus(3,3)+Zf)
VF = V0-I3F*Zbus(:,3)
I12 = (VF(1) - VF(2))/z12
I13 = (VF(1) - VF(3))/z13
I23 = (VF(2) - VF(3))/z23
