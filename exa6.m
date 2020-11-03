j=sqrt(-1)            % Defining j
I=[30+j*40; 20+j*15]  % Column of node current phasors
Y=[1.5-j*2  -.35+j*1.2; -.35+j*1.2  .9-j*1.6];
                      % Complex admittance matrix Y
disp('The solution is')
V=inv(Y)*I            % node voltages (solving I=YV)
S=V.*conj(I)          % complex power at nodes
