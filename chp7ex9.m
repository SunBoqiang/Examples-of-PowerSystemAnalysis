clear
basemva = 100;  accuracy = 0.0001;  maxiter = 10;

%        Bus Bus  Voltage Angle   ---Load---- -------Generator----- Injected
%        No  code Mag.    Degree  MW    Mvar  MW  Mvar Qmin Qmax    Mvar
busdata=[1   1    1.06    0.0      0     0     0   0    10   50      0
         2   2    1.045   0.0     20    10    40  30    10   50      0
         3   2    1.03    0.0     20    15    30  10    10   40      0
         4   0    1.00    0.0     50    30     0   0     0    0      0
         5   0    1.00    0.0     60    40     0   0     0    0      0];

%                                        Line code
%         Bus bus   R      X     1/2 B   = 1 for lines
%         nl  nr  p.u.   p.u.   p.u.     > 1 or < 1 tr. tap at bus nl
linedata=[1   2   0.02   0.06   0.030     1
          1   3   0.08   0.24   0.025     1
          2   3   0.06   0.18   0.020     1
          2   4   0.06   0.18   0.020     1
          2   5   0.04   0.12   0.015     1
          3   4   0.01   0.03   0.010     1
          4   5   0.08   0.24   0.025     1];

lfybus                     % form the bus admittance matrix
lfnewton     % Power flow solution by Newton-Raphson method
busout       % Prints the power flow solution on the screen
bloss               % Obtains the loss formula coefficients
