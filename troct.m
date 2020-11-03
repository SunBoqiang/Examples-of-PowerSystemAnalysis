% This function computes the transformer shunt branch from
% open-circuit test data.
%
% Copyright (C) 1998 by H. Saadat.

function [Rc, Xm] = troct(Vo, Io, Po)
if exist('Vo') ~= 1
Vo = input(' Enter input voltage in volts, Vo = '); else, end
if exist('Io') ~= 1
Io = input(' Enter no-load current in Amp, Io = '); else, end
if exist('Po') ~= 1
Po = input(' Enter no-load power in Watt, Po = '); else, end

Rc = (Vo)^2/Po;
Ic = Vo/Rc;
if Ic > Io
   fprintf(' Error, Ic > Io. Inconsistent test data. Check test data and try again');
   return, end
Im = sqrt(Io^2 - Ic^2);
Xm = Vo/Im;
