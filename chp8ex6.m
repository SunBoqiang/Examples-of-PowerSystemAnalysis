w0 = 2*pi*60; E0 = 1.0; delta = pi/2;
Xd2dash = 0.15;   Xddash  = 0.4;  Xd = 1.2;
tau2dash = 0.035; taudash = 1.0; ta = 0.15;
t=0:1/(4*240):1;
iasy = sqrt(2)*E0*((1/Xd2dash-1/Xddash)*exp(-t/tau2dash) +...
  (1/Xddash-1/Xd)*exp(-t/taudash) + 1/Xd).*sin(w0*t + delta) +...
  sqrt(2)*E0/Xd2dash *exp(-t/ta);

plot(t, iasy), grid
xlabel('t, sec'), ylabel('iasy, A')
[t' iasy']
