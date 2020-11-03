data = [ 0   2    6
         2   6    5
         6   9   10
         9  12   15
        12  14   12
        14  16   14
        16  18   16
        18  20   18
        20  22   16
        22  23   12
        23  24    6];

P =data(:,3);                               % Column array of load
Dt = data(:, 2) - data(:,1);    %  Column array of demand interval
W = P'*Dt;                    % Total energy, area under the curve
Pavg = W/sum(Dt)                                    % Average load
Peak = max(P)                                          % Peak load
LF = Pavg/Peak*100                           % Percent load factor
barcycle(data)                              % Plots the load cycle
xlabel('Time, hr'), ylabel('P, MW'), grid
