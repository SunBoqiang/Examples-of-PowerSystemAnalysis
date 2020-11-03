%  Copyright 1998 H. Saadat.

ab=['                        ROTATING MAGNETIC FIELD                      '
    '                                                                     '
    '  The basis of operation of all polyphase ac machines is the rotating'
    '  magnetic field.  All ac machines have a rotating part called rotor '
    '  and a stationary part called stator. A set of balanced three-phase '
    '  currents flowing through a symmetrical three-phase stator winding  '
    '  produce a magnetic field that rotates at synchronous speed with    '
    '  respect to the stator structure.  The synchronous machine rotor is '
    '  excited by dc current producing fixed magnetic poles which rotate  '
    '  in synchronism with the stator rotating field. This is the basis of'
    '  synchronous machines. Torque is produced by the tendency of the two'
    '  component magnetic fields to line up their magnetic axis.          '
    '                                                                     '
    '  In the case of an induction motor, the rotor will have currents    '
    '  induced in it by the relative motion of the fields. The rotor      '
    '  currents in turn produce a rotating magnetic field with the same   '
    '  speed as that of the stator field, irrespective of the speed of the'
    '  rotor.  The interaction of these fields produces a torque on the   '
    '  rotor, and this is the basis of the induction motor.               '
    '                                                                     '
    '                                                                     '
    '  Press Enter to see a demonstration of the rotating magnetic field  '
    '  produced by three-phase currents flowing in the stator windings for'
    '  phase sequence a-b-c and c-b-a.                                    '];

disp(ab)
pause


offset=pi/10;
tf=50;
theta=pi-offset;
theta=-pi/2;
thetadot= 2*pi/tf;
dt=1;  t =0;
clf


h1=axes('position',[.1 .55 .4 .4]);
axis([0 2*pi -4 4]); axis('off');
text(0.1, 3.5, 'fa'), text(2.1, 3.5, 'fb'),text(4.4, 3.5, 'fc'),
text(0.5, 4.35,'Positive-phase sequence')
line([0; 0],   [-4; 4],'color','w')
line([0; 6.3], [0; 0],'color','w')
text(-.3, 0,'0')


Displ1=line('xdata',[],'ydata',[],'linestyle','-','color','r','erasemode','none');
Displ2=line('xdata',[],'ydata',[],'linestyle','-','color','y','erasemode','non');
Displ3=line('xdata',[],'ydata',[],'linestyle','-','color','b','erasemode','none');


h2=axes('position',[.1 .05 .4 .4]);
axis([0 2*pi -4 4]);axis('off');
text(0.1, 3.5, 'fa'), text(2.1, 3.5, 'fc'),text(4.4, 3.5, 'fb'),
text(0.5, 4.35,'Negative-phase sequence')
line([0; 0],   [-4; 4],'color','w')
line([0; 6.3], [0; 0],'color','w')
text(-.3, 0,'0')
Displ4=line('xdata',[],'ydata',[],'linestyle','-','color','r','erasemode','none');
Displ5=line('xdata',[],'ydata',[],'linestyle','-','color','b','erasemode','non');
Displ6=line('xdata',[],'ydata',[],'linestyle','-','color','y','erasemode','none');

%h4=axes('position',[.58 .58 .4 .4]);
h4=axes('position',[.58 .68 .3 .3]);


axis([-2.  2. -2. 2.]);
axis('equal')
text(-1.75, -2.3,'Forward Rotating mmf')
%text(-1.0, 2.3,'Forward Rotating mmf')

data1=[0 0; 2 0 ];
phi=0;
R1=[cos(phi)  -sin(phi);  sin(phi)  cos(phi)];
bar1=line('xdata',data1(1,:),'ydata',data1(2,:),'linewidth',2,'color','g','erase','xor');
hinge1=line('xdata',0,'ydata',0,'linestyle','o','color','r'); %,'markersize',[4]);
path1=line('xdata',[],'ydata',[],'linestyle','.','color','m','erasemode','none');
%h3=axes('position',[.58 .05 .4 .4]);
h3=axes('position',[.58  0 .3 .3]);


axis([-2.  2. -2. 2.]);
axis('equal')
%text(-1.0, -2.3,'Reverse Rotating mmf')
text(-1.75,  2.3,'Reverse Rotating mmf')

data2=[0 0; -2 0 ];
R2=[cos(phi)  sin(phi);  sin(phi)  cos(phi)];
bar2=line('xdata',data2(1,:),'ydata',data2(2,:),'linewidth',2,'color','c','erase','xor');
hinge2=line('xdata',0,'ydata',0,'linestyle','o','color','r');  %,'markersize',[4]);
%hinge2=line('xdata',0,'ydata',0,'linestyle','o','color','r','markersize',[4]);
path2=line('xdata',[],'ydata',[],'linestyle','.','color','m','erasemode','none');
for k=1:1:50
t=0:1:k;
%while(t<tf);
%t=t+dt;
theta=theta+thetadot*dt;
thetadot==thetadot-sin(theta);
R1=[cos(theta)  (-sin(theta));  sin(theta)  cos(theta)];
datanew=R1*data1;
axes(h4); axis('off')
set(path1,'xdata',datanew(1,1),'ydata',datanew(2,1));
set(bar1,'xdata',datanew(1,:),'ydata',datanew(2,:));
R2=[cos(theta)  (sin(theta));  sin(theta)  cos(theta)];
datanew2=R2*data2;
axes(h3); axis('off')
set(path2,'xdata',datanew2(1,1),'ydata',datanew2(2,1));
set(bar2,'xdata',datanew2(1,:),'ydata',datanew2(2,:));
ia=3*cos(2*pi*t/tf);
ib=3*cos(2*pi*t/tf -2*pi/3);
ic=3*cos(2*pi*t/tf-4*pi/3);
axes(h1);
set(Displ1,'xdata',2*pi*t/50, 'ydata',ia);
set(Displ2,'xdata',2*pi*t/50, 'ydata',ib);
set(Displ3,'xdata',2*pi*t/50, 'ydata',ic);
axes(h2);
set(Displ4,'xdata',2*pi*t/50, 'ydata',ia);
set(Displ5,'xdata',2*pi*t/50, 'ydata',ib);
set(Displ6,'xdata',2*pi*t/50, 'ydata',ic);
drawnow;
end
