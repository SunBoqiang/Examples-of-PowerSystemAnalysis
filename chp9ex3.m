Z1=[j*0.2     0    j*0.2
        0  j*.4        0
    j*0.2     0    j*0.6]
DZ1 = [-j*0.2; j*0.4;  -j*0.2]
zl1 = j*0.8 + j*0.2 + j*.4
ZX1=1/zl1*DZ1*(-DZ1)'
Z2 = Z1 - ZX1
DZ2 = [Z2(1,3)-Z2(1,2); Z2(2,3)-Z2(2,2); Z2(3,3)-Z2(3,2)]
zl2=j*0.4+Z2(2,2)+Z2(3,3)-2*Z2(2,3)
ZX2=1/zl2*DZ2*(-DZ2)'
Z3=Z2-ZX2
