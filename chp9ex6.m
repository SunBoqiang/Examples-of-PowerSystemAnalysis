zdata =    [ 0   1   0    0.2
             0   2   0    0.4
             1   2   0    0.8
             1   3   0    0.4
             2   3   0    0.4];

Zbus = zbuild(zdata)
symfault(zdata, Zbus)
