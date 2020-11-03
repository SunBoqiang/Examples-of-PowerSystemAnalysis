V012 = [.6    90
        1     30
        0.8   -30];
Vabc = sc2abc(V012);  % Unbalanced phasors from symmetrical components
Vabcp= rec2pol(Vabc)    % Converts rectangular phasors into polar form
