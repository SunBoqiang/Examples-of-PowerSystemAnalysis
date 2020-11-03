Da1=(3^2+4^2)^.5;
Da2=(4.2^2+4^2)^0.5;
Ia= 200; Ic=200*(cos(2*pi/3)+j*sin(2*pi/3));
Lambda12=0.2*Ia*log(Da2/Da1)+0.2*Ic*log(Da1/Da2);
V = j*2*pi*60*Lambda12/1000;
Vm=abs(V), Vang=angle(V)*180/pi
