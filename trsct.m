% This function computes the equivalent series impedance of a
% transformer from the short-circuit data.
%
% Copyright (C) 1998 by H. Saadat.

function [Ze] = trsct(Vsc, Isc, Psc)
if exist('Vsc') ~= 1
Vsc = input(' Enter reduced input voltage in volts, Vsc = '); else, end
if exist('Isc') ~= 1
Isc = input(' Enter input current in Amp, Isc = '); else, end
if exist('Psc') ~= 1
Psc = input(' Enter input power in Watt, Psc = '); else, end

Zemag = Vsc/Isc;
Re = Psc/Isc^2;
if Re > Zemag
   fprintf(' Error, Re > Ze. Inconsistent test data. Check test data and try again');
   return, end
Xe = sqrt(Zemag^2 - Re^2);
Ze = Re + j*Xe;
