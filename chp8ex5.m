w0 = 2*pi*60; E0 = 1.0; delta = 0;
Xd2dash = 0.15;   Xddash  = 0.4;  Xd = 1.2;
tau2dash = 0.035; taudash = 1.0;
t=0:1/(4*240):1;
iac = sqrt(2)*E0*((1/Xd2dash-1/Xddash)*exp(-t/tau2dash) +...
  (1/Xddash-1/Xd)*exp(-t/taudash) + 1/Xd).*sin(w0*t + delta);
di1 = sqrt(2)*E0*((1/Xd2dash-1/Xddash)*exp(-t/tau2dash) +...
  (1/Xddash-1/Xd)*exp(-t/taudash) + 1/Xd);
di2 = sqrt(2)*E0*((1/Xddash-1/Xd)*exp(-t/taudash)+1/Xd);
di3=sqrt(2)*E0/Xd*ones(1,length(t));
plot(t, iac, t, di1, t, di2, t, di3), grid
xlabel('t, sec'), ylabel('iac, A')
[t' iac']
