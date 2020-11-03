basemva = 100;  accuracy = 0.0001;  maxiter = 10;
busdata=[1  1  1.06   0.0  00.00    00.00    0.00    00.00     0     0   0
         2  2  1.04   0.0  00.00    00.00  150.00    00.00     0   140   0
         3  2  1.03   0.0  00.00    00.00  100.00    00.00     0    90   0
         4  0  1.0    0.0 100.00    70.00   00.00    00.00     0    0    0
         5  0  1.0    0.0  90.00    30.00   00.00    00.00     0    0    0
         6  0  1.0    0.0 160.00   110.00   00.00    00.00     0    0    0];


linedata=[1  4  0.035   0.225   0.0065   1.0
          1  5  0.025   0.105   0.0045   1.0
          1  6  0.040   0.215   0.0055   1.0
          2  4  0.000   0.035   0.0000   1.0
          3  5  0.000   0.042   0.0000   1.0
          4  6  0.028   0.125   0.0035   1.0
          5  6  0.026   0.175   0.0300   1.0];

lfybus                     % form the bus admittance matrix
lfnewton     % Power flow solution by Newton-Raphson method
busout       % Prints the power flow solution on the screen

%         Gen.  Ra   Xd'    H
gendata=[ 1     0   0.20   20
          2     0   0.15    4
          3     0   0.25    5];
trstab
