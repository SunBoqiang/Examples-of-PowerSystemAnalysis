% This function finds the equivalent impedance of a transformer
% referred to primary and secondary form individual winding impedances.
% Copyright (C) 1998 by H. Saadat.

function [Ze1, Ze2] = trsct(E1, E2, Z1, Z2)
if exist('E1') ~= 1
E1 = input(' Enter rated voltage in volt, LV side = '); else, end
if exist('E2') ~= 1
E2 = input(' Enter rated voltage in volt, LV side = '); else, end
if exist('Z1') ~= 1
Z1 = input(' Enter the LV series impedance R1 + j*X1 in ohms = '); else, end
if exist('Z2') ~= 1
Z2 = input(' Enter the HV series impedance R2 + j*X2 in ohms = '); else, end
Ze1 = Z1 + (E1/E2)^2*Z2;
Ze2 = Z2 + (E2/E1)^2*Z1;
