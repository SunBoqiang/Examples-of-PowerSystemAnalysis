disp('C = A*B')
A = [1  7  12];
B = [1  0  9];
C= conv(A, B)
disp('X = Z/Y')
Z = [1     9    37    81    52];
Y = [1  4  13];
[X, r] = deconv(Z, Y)
