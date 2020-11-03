disp('Example 9.9')
basemva = 1000;  accuracy = 0.0001;  maxiter = 10;
% The impedances are expressed on a 1000 MVA base.
% In problems 9.7-9.9 the base is mistakenly stated as 100 MVA. 
%       Bus  Bus   |V|  Ang   ---Load---      ---Gen---   Gen Mvar Injected
%       No.  code p.u.  Deg   MW     Mvar   MW   Mvar   Min   Max    Mvar
busdata=[1    1   1.04   0    00.0    0.0     0.0   0.0    0     0    0
         2    0   1.0    0    00.0    0.0     0.0   0.0    0     0    0
         3    0   1.0    0   150.0  120.0     0.0   0.0    0     0    0
         4    0   1.0    0     0.0    0.0     0.0   0.0    0     0    0
         5    0   1.0    0   120.0   60.0     0.0   0.0    0     0    0
         6    0   1.0    0   140.0   90.0     0.0   0.0    0     0    0
         7    0   1.0    0     0.0    0.0     0.0   0.0    0     0    0
         8    0   1.0    0   110.0   90.0     0.0   0.0    0     0    0
         9    0   1.0    0    80.0   50.0     0.0   0.0    0     0    0
         10   2   1.035  0     0.0    0.0   200.0   0.0    0    180   0
         11   2   1.03   0     0.0    0.0   160.0   0.0    0    120   0];

%        Bus   Bus     R        X       1/2B
%        No.   No.    p.u.     p.u.     p.u.
linedata=[1     2     0.00     0.06     0.0000    1
          2     3     0.08     0.30     0.0004    1
          2     6     0.12     0.45     0.0005    1
          3     4     0.10     0.40     0.0005    1
          3     6     0.04     0.40     0.0005    1
          4     6     0.15     0.60     0.0008    1
          4     9     0.18     0.70     0.0009    1
          4    10     0.00     0.08     0.0000    1
          5     7     0.05     0.43     0.0003    1
          6     8     0.06     0.48     0.0000    1
          7     8     0.06     0.35     0.0004    1
          7    11     0.00     0.10     0.0000    1
          8     9     0.052    0.48     0.0000    1];
%         Gen.  Ra     Xd'
gendata=[ 1     0     0.20
          10    0     0.15
          11    0     0.25];
      lfybus                              % Forms the bus admittance matrix
      lfnewton               % Power flow solution by Newton-Raphson method
      busout                 % Prints the power flow solution on the screen
      Zbus=zbuildpi(linedata, gendata, yload)%Forms Zbus including the load
      symfault(linedata, Zbus, V)    % 3-phase fault including load current
