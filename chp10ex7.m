zdata1 = [0   1   0    0.25
          0   2   0    0.25
          1   2   0    0.125
          1   3   0    0.15
          2   3   0    0.25];

zdata0 = [0   1   0    0.40
          0   2   0    0.10
          1   2   0    0.30
          1   3   0    0.35
          2   3   0    0.7125];
zdata2 = zdata1;
Zbus1 = zbuild(zdata1)
Zbus0 = zbuild(zdata0)
Zbus2 = Zbus1;
disp('(a) Symmetrical three-phase fault')
symfault(zdata1, Zbus1)
disp('(b) Line-to-ground fault' )
lgfault(zdata0, Zbus0, zdata1, Zbus1, zdata2, Zbus2)
disp('(c) Line-to-line fault')
llfault(zdata1, Zbus1, zdata2, Zbus2)
disp('(d) double line-to-ground fault')
dlgfault(zdata0, Zbus0, zdata1, Zbus1, zdata2, Zbus2)
