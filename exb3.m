num = 100;
den = [1  26  216  576];
[numo, deno, denc]=frdesign(num, den);           %PID design
w = .1:.1:20;
[mag, phase] =bode(numo, deno, w);
dB = 20*log10(mag);
figure(1), plot(w, dB), grid
xlabel('w, rad/sec'), ylabel('dB')
figure(2), plot(w, phase), grid
xlabel('w, rad/sec'), ylabel('Degrees')
