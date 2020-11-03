num = 100;
den = [1  26  216  576];
figure(1), rlocus(num, den), grid, axis([-20 0 -15 15]);
zeta = 0.96;                                     % damping ratio
[numo, deno, denc]=rldesign(num, den, zeta);   % Gain controller
t = 0:.005:4;
c1= step(numo, denc, t);         % Step response for zeta = 0.96
num2=100*32.64;  den2 = [1 26 216 3840];
c2= step(num2, den2, t);           % Step response for K = 32.64
figure(2), plot(t, c1,  t, c2) , grid
xlabel('t, sec'), ylabel('c(t)')
text(3.1, 0.75, 'K = 32.64'), text(3.1, 0.1, 'K = 0.28')
timespec(num2, den2)           % Time-domain spec. for K = 32.64
