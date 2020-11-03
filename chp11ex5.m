%(a) Fault at the sending end. Both lines intact when fault is cleared
Pm = 0.8; E= 1.17; V = 1.0; X1 = 0.65; X2 = inf; X3 = 0.65;
eacfault(Pm, E, V, X1, X2, X3)

%(b) Fault at the mid-point of one line. Faulted line is isolated
X2 = 1.8; X3 = 0.8;
eacfault(Pm, E, V, X1, X2, X3)
