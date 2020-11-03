clear
basemva = 100;  accuracy = 0.001; accel = 1.8; maxiter = 100;

%        IEEE 30-BUS TEST SYSTEM (American Electric Power)
%        Bus Bus  Voltage Angle   ---Load---- -------Generator----- Static Mvar
%        No  code Mag.    Degree  MW    Mvar  MW  Mvar Qmin Qmax    +Qc/-Ql
busdata=[1   1    1.06    0.0     0.0   0.0    0.0  0.0   0   0       0
         2   2    1.043   0.0   21.70  12.7   40.0  0.0 -40  50       0
         3   0    1.0     0.0     2.4   1.2    0.0  0.0   0   0       0
         4   0    1.06    0.0     7.6   1.6    0.0  0.0   0   0       0
         5   2    1.01    0.0    94.2  19.0    0.0  0.0 -40  40       0
%          6   0    1.0     0.0     0.0   0.0    0.0  0.0   0   0       0
%          7   0    1.0     0.0    22.8  10.9    0.0  0.0   0   0       0
%          8   2    1.01    0.0    30.0  30.0    0.0  0.0 -30  40       0
%          9   0    1.0     0.0     0.0   0.0    0.0  0.0   0   0       0
%         10   0    1.0     0.0     5.8   2.0    0.0  0.0  -6  24      19
%         11   2    1.082   0.0     0.0   0.0    0.0  0.0   0   0       0
%         12   0    1.0     0       11.2  7.5    0    0     0   0       0
%         13   2    1.071   0        0    0.0    0    0    -6  24       0
%         14   0    1       0       6.2   1.6    0    0     0   0       0
%         15   0    1       0       8.2   2.5    0    0     0   0       0
%         16   0    1       0       3.5   1.8    0    0     0   0       0
%         17   0    1       0       9.0   5.8    0    0     0   0       0
%         18   0    1       0       3.2   0.9    0    0     0   0       0
%         19   0    1       0       9.5   3.4    0    0     0   0       0
%         20   0    1       0       2.2   0.7    0    0     0   0       0
%         21   0    1       0      17.5  11.2    0    0     0   0       0
%         22   0    1       0       0     0.0    0    0     0   0       0
%         23   0    1       0       3.2   1.6    0    0     0   0       0
%         24   0    1       0       8.7   6.7    0    0     0   0      4.3
%         25   0    1       0       0     0.0    0    0     0   0       0
%         26   0    1       0       3.5   2.3    0    0     0   0       0
%         27   0    1       0       0     0.0    0    0     0   0       0
%         28   0    1       0       0     0.0    0    0     0   0       0
%         29   0    1       0       2.4   0.9    0    0     0   0       0
%         30   0    1       0      10.6   1.9    0    0     0   0       0
];

%                                        Line code
%         Bus bus   R      X     1/2 B   = 1 for lines
%         nl  nr  p.u.   p.u.   p.u.     > 1 or < 1 tr. tap at bus nl
linedata=[1   2   0.0192   0.0575   0.02640    1
          1   3   0.0452   0.1852   0.02040    1
          2   4   0.0570   0.1737   0.01840    1
          3   4   0.0132   0.0379   0.00420    0.978
          4   5   0.0472   0.1983   0.02090    1];
lfybus                            % form the bus admittance matrix
Ybus
lfgauss                % Load flow solution by Gauss-Seidel method
busout              % Prints the power flow solution on the screen
lineflow          % Computes and displays the line flow and losses
