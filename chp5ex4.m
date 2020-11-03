z = 0.045 + j*.4;    y = j*4.0/1000000; Length = 250;
gamma = sqrt(z*y);  Zc = sqrt(z/y);
A = cosh(gamma*Length);  B = Zc*sinh(gamma*Length);
C = 1/Zc * sinh(gamma*Length);  D = A;
ABCD = [A  B; C  D]
Z = Zc * sinh(gamma*Length)
Y = 2/Zc * tanh(gamma*Length/2)
