% TRANSIENT STABILITY ANALYSIS OF A MULTIMACHINE POWER SYSTEM NETWORK
%
% Program ``trstab'' must be used in conjuntion with the power flow
% program. Any of the power flow programs ``lfgauss'', ``lfnewton'',
% ``decoupled'' or ``perturb'' can be used prior to ``trstab'' program.
% Power flow program provide the power, voltage magnitude and phase
% angle for each bus. Also, the load admittances are returned in a
% matrix named ``yload''.  In addition to the required power flow data,
% Transient reactance, and inertia constant of each machine must be
% specified.  This is defined in a matrix named ``gendata'', Each row
% contain the bus No. to which a generator is connected, armature
% resistance, transient reactance, and the machine inertia constant.
% Program ``trstab'' obtains the prefault bus admittance matrix including
% the load admittances. Voltage behind transient reactances are obtained.
% The reduced admittance matrix before, during and after fault are found.
% Machine equations are expressed in state variable form and the MATLAB
% ode23 is used to solve the multimachine equations. The phase angle
% difference of each machine with respect to the slack bus are plotted.
% The simulation can be repeated for a different fault clearing time, or
% a different fault location.
%
% Copyright (c) 1998 by H. Saadat
%
global Pm f H E  Y th ngg
f=60;
%zdd=gendata(:,2)+j*gendata(:,3);
ngr=gendata(:,1);
%H=gendata(:,4);
ngg=length(gendata(:,1));
%%
for k=1:ngg
zdd(ngr(k))=gendata(k, 2)+j*gendata(k,3);
%H(ngr(k))=gendata(k, 4);
H(k)=gendata(k,4);   % new
end
%%
for k=1:ngg
I=conj(S(ngr(k)))/conj(V(ngr(k)));
%Ep(ngr(k)) = V(ngr(k))+zdd(ngr(k))*I;
%Pm(ngr(k))=real(S(ngr(k)));
Ep(k) = V(ngr(k))+zdd(ngr(k))*I;  % new
Pm(k)=real(S(ngr(k)));            % new

end
E=abs(Ep); d0=angle(Ep);
for k=1:ngg
nl(nbr+k) = nbus+k;

nr(nbr+k) = gendata(k, 1);

%R(nbr+k)  = gendata(k, 2);
%X(nbr+k)  = gendata(k, 3);

R(nbr+k)  = real(zdd(ngr(k)));
X(nbr+k)  = imag(zdd(ngr(k)));

Bc(nbr+k)  = 0;
a(nbr+k) = 1.0;
yload(nbus+k)=0;
end
nbr1=nbr; nbus1=nbus;
nbrt=nbr+ngg;
nbust=nbus+ngg;
linedata=[nl, nr, R, X, -j*Bc, a];
[Ybus, Ybf]=ybusbf(linedata, yload, nbus1,nbust);
fprintf('\nPrefault reduced bus admittance matrix \n')
Ybf
Y=abs(Ybf); th=angle(Ybf);
Pm=zeros(1, ngg);
disp(['      G(i)    E''(i)     d0(i)      Pm(i)'])
for ii = 1:ngg
for jj = 1:ngg
Pm(ii) = Pm(ii) + E(ii)*E(jj)*Y(ii, jj)*cos(th(ii, jj)-d0(ii)+d0(jj));

end,
fprintf('       %g', ngr(ii)), fprintf('   %8.4f',E(ii)), fprintf('   %8.4f', 180/pi*d0(ii))
fprintf('  %8.4f \n',Pm(ii))
end
respfl='y';
while respfl =='y' | respfl=='Y'
nf=input('Enter faulted bus No. -> ');
fprintf('\nFaulted reduced bus admittance matrix\n')
Ydf=ybusdf(Ybus, nbus1, nbust, nf)
%Fault cleared
[Yaf]=ybusaf(linedata, yload, nbus1,nbust, nbrt);
fprintf('\nPostfault reduced bus admittance matrix\n')
Yaf
resptc='y';
while resptc =='y' | resptc=='Y'
tc=input('Enter clearing time of fault in sec. tc = ');
tf=input('Enter final simulation time in sec.  tf = ');
clear t  x  del
t0 = 0;
w0=zeros(1, length(d0));
x0 = [d0,  w0];
tol=0.0001;
Y=abs(Ydf); th=angle(Ydf);
%[t1, xf] =ode23('dfpek', t0, tc, x0, tol);  % Solution during fault (use with MATLAB 4)
tspan=[t0, tc];                                        %use with MATAB 5
[t1, xf] =ode23('dfpek', tspan, x0);  % Solution during fault (use with MATLAB 5)
x0c =xf(length(xf), :);
Y=abs(Yaf); th=angle(Yaf);
%[t2,xc] =ode23('afpek', tc, tf, x0c, tol); % Postfault solution (use with MATLAB 4)
tspan = [tc, tf];                           % use with MATLAB 5
[t2,xc] =ode23('afpek', tspan, x0c);        % Postfault solution (use with MATLAB 5)
t =[t1; t2]; x = [xf; xc];
fprintf('\nFault is cleared at %4.3f Sec. \n', tc)
for k=1:nbus
    if kb(k)==1
    ms=k; else, end
end
fprintf('\nPhase angle difference of each machine \n')
fprintf('with respect to the slack in degree.\n')
fprintf('   t - sec')
kk=0;
for k=1:ngg
    if k~=ms
    kk=kk+1;
    del(:,kk)=180/pi*(x(:,k)-x(:,ms));
    fprintf('    d(%g,',ngr(k)), fprintf('%g)', ngr(ms))
    else, end
end
fprintf(' \n')
disp([t, del])
h=figure; figure(h)
plot(t, del)
title(['Phase angle difference (fault cleared at ', num2str(tc),'s)'])
xlabel('t, sec'), ylabel('Delta, degree'), grid
   resp=0;
   while strcmp(resp, 'n')~=1 & strcmp(resp, 'N')~=1 & strcmp(resp, 'y')~=1 & strcmp(resp, 'Y')~=1
   resp=input('Another clearing time of fault? Enter ''y'' or ''n'' within quotes -> ');

   if strcmp(resp, 'n')~=1 & strcmp(resp, 'N')~=1 & strcmp(resp, 'y')~=1 & strcmp(resp, 'Y')~=1
   fprintf('\n Incorrect reply, try again \n\n'), end
   end
resptc=resp;

end
    resp2=0;
    while strcmp(resp2, 'n')~=1 & strcmp(resp2, 'N')~=1 & strcmp(resp2, 'y')~=1 & strcmp(resp2, 'Y')~=1
    resp2=input('Another fault location: Enter ''y'' or ''n'' within quotes -> ');
    if strcmp(resp2, 'n')~=1 & strcmp(resp2, 'N')~=1 & strcmp(resp2, 'y')~=1 & strcmp(resp2, 'Y')~=1
    fprintf('\n Incorrect reply, try again \n\n'), end
    respf1=resp2;
    end
    if respf1=='n' | respf1=='N', return, else, end
end
