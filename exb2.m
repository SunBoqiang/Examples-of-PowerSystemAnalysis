num = 100;
den = [1  26  216  576];
s1= -10+j*1;             % Desired location of closed-loop poles
[numo, deno, denc]=rldesign(num, den, s1);           %PID design
t = 0:.01:4;
c= step(numo, denc, t);
plot(t, c), grid
xlabel('t, sec'), ylabel('c(t)')
