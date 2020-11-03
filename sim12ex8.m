function [ret,x0,str,ts,xts]=chp12sm8(t,x,u,flag);
%CHP12SM8   is the M-file description of the SIMULINK system named CHP12SM8.
%   The block-diagram can be displayed by typing: CHP12SM8.
%
%   SYS=CHP12SM8(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes CHP12SM8 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling CHP12SM8 with a FLAG of zero:
%   [SIZES]=CHP12SM8([],[],[],0),  returns a vector, SIZES, which
%   contains the sizes of the state vector and other parameters.
%       SIZES(1) number of states
%       SIZES(2) number of discrete states
%       SIZES(3) number of outputs
%       SIZES(4) number of inputs
%       SIZES(5) number of roots (currently unsupported)
%       SIZES(6) direct feedthrough flag
%       SIZES(7) number of sample times
%
%   For the definition of other parameters in SIZES, see SFUNC.
%   See also, TRIM, LINMOD, LINSIM, EULER, RK23, RK45, ADAMS, GEAR.

% Note: This M-file is only used for saving graphical information;
%       after the model is loaded into memory an internal model
%       representation is used.

% the system will take on the name of this mfile:
sys = mfilename;
new_system(sys)
simver(1.3)
if (0 == (nargin + nargout))
     set_param(sys,'Location',[21,298,921,743])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '2')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.010')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Transfer Fcn',[sys,'/','Sensor'])
set_param([sys,'/','Sensor'],...
        'orientation',2,...
        'Denominator','[0.05  1]',...
        'position',[410,259,505,311])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
        'Time','2',...
        'Before','1',...
        'position',[20,92,60,128])

add_block('built-in/Note',[sys,'/','Vref'])
set_param([sys,'/','Vref'],...
        'position',[75,55,80,75])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','+-',...
        'position',[95,100,130,140])


%     Subsystem  'PID Controller'.

new_system([sys,'/','PID Controller'])
set_param([sys,'/','PID Controller'],'Location',[0,0,362,244])

add_block('built-in/Sum',[sys,'/','PID Controller/Sum'])
set_param([sys,'/','PID Controller/Sum'],...
        'inputs','+++',...
        'position',[245,57,265,93])

add_block('built-in/Gain',[sys,'/','PID Controller/D'])
set_param([sys,'/','PID Controller/D'],...
        'Gain','D',...
        'position',[95,129,115,151])

add_block('built-in/Gain',[sys,'/','PID Controller/Proportional'])
set_param([sys,'/','PID Controller/Proportional'],...
        'Gain','P',...
        'position',[120,13,140,37])

add_block('built-in/Transfer Fcn',[sys,'/','PID Controller/Integral'])
set_param([sys,'/','PID Controller/Integral'],...
        'Numerator','[I]',...
        'Denominator','[1 0]',...
        'position',[110,57,145,93])

add_block('built-in/Derivative',[sys,'/','PID Controller/Derivative'])
set_param([sys,'/','PID Controller/Derivative'],...
        'position',[150,128,190,152])

add_block('built-in/Outport',[sys,'/','PID Controller/Out_1'])
set_param([sys,'/','PID Controller/Out_1'],...
        'position',[290,65,310,85])

add_block('built-in/Inport',[sys,'/','PID Controller/In_1'])
set_param([sys,'/','PID Controller/In_1'],...
        'position',[25,65,45,85])
add_line([sys,'/','PID Controller'],[120,140;145,140])
add_line([sys,'/','PID Controller'],[270,75;285,75])
add_line([sys,'/','PID Controller'],[50,75;105,75])
add_line([sys,'/','PID Controller'],[65,75;65,140;90,140])
add_line([sys,'/','PID Controller'],[80,75;80,25;115,25])
add_line([sys,'/','PID Controller'],[195,140;215,140;215,85;240,85])
add_line([sys,'/','PID Controller'],[150,75;240,75])
add_line([sys,'/','PID Controller'],[145,25;210,25;210,65;240,65])
set_param([sys,'/','PID Controller'],...
        'Mask Display','PID',...
        'Mask Type','PID Controller',...
        'Mask Dialogue','Enter expressions for proportional, integral, and derivative terms.\nP+I/s+Ds|Proportional:|Integral|Derivative:')
set_param([sys,'/','PID Controller'],...
        'Mask Translate','P=@1; I=@2; D=@3;')
set_param([sys,'/','PID Controller'],...
        'Mask Help','This block implements a PID controller where parameters are entered for the Proportional, Integral and Derivative terms. Unmask this block to see how it works. The derivative term is implemented using a true derivative block.')
set_param([sys,'/','PID Controller'],...
        'Mask Entries','1\/0.25\/0.28\/')


%     Finished composite block 'PID Controller'.

set_param([sys,'/','PID Controller'],...
        'position',[175,104,215,136])

add_block('built-in/Transfer Fcn',[sys,'/','Amplifier'])
set_param([sys,'/','Amplifier'],...
        'Numerator','10',...
        'Denominator','[0.1  1]',...
        'position',[260,92,345,148])

add_block('built-in/Note',[sys,'/','VR'])
set_param([sys,'/','VR'],...
        'position',[360,95,390,101])

add_block('built-in/Transfer Fcn',[sys,'/','Exciter'])
set_param([sys,'/','Exciter'],...
        'Numerator','1',...
        'Denominator','[0.4  1]',...
        'position',[410,92,495,148])

add_block('built-in/Note',[sys,'/','VF'])
set_param([sys,'/','VF'],...
        'position',[515,85,525,101])

add_block('built-in/Transfer Fcn',[sys,'/','Generator'])
set_param([sys,'/','Generator'],...
        'Denominator','[1  1]',...
        'position',[555,94,635,146])

add_block('built-in/Note',[sys,'/','Vt'])
set_param([sys,'/','Vt'],...
        'position',[650,94,675,99])

add_block('built-in/Note',[sys,'/','Ve'])
set_param([sys,'/','Ve'],...
        'position',[145,84,150,91])

add_block('built-in/Mux',[sys,'/','Mux'])
set_param([sys,'/','Mux'],...
        'orientation',2,...
        'inputs','2',...
        'position',[640,211,675,249])

add_block('built-in/To Workspace',[sys,'/','Terminal Voltage'])
set_param([sys,'/','Terminal Voltage'],...
        'orientation',2,...
        'mat-name','Vt',...
        'position',[540,215,590,245])


%     Subsystem  'Graph'.

new_system([sys,'/','Graph'])
set_param([sys,'/','Graph'],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/','Graph/x'])
set_param([sys,'/','Graph/x'],...
        'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['Graph/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Graph/S-function',13,'M-file which plots',13,'lines',13,'']],...
        'function name','sfuny',...
        'parameters','ax, color,dt',...
        'position',[130,55,180,75])
add_line([sys,'/','Graph'],[90,65;125,65])
set_param([sys,'/','Graph'],...
        'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
        'Mask Type','Graph scope.')
set_param([sys,'/','Graph'],...
        'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/','Graph'],...
        'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/','Graph'],...
        'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/','Graph'],...
        'Mask Entries','2\/0\/1.2\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
        'Drop Shadow',4,...
        'position',[670,125,710,165])

add_block('built-in/Clock',[sys,'/','Clock'])
set_param([sys,'/','Clock'],...
        'orientation',2,...
        'position',[705,190,725,210])
add_line(sys,[65,110;90,110])
add_line(sys,[500,120;550,120])
add_line(sys,[405,285;80,285;90,130])
add_line(sys,[350,120;405,120])
add_line(sys,[135,120;170,120])
add_line(sys,[220,120;255,120])
add_line(sys,[640,120;765,120;765,285;510,285])
add_line(sys,[650,120;650,145;665,145])
add_line(sys,[635,230;595,230])
add_line(sys,[700,200;690,200;680,220])
add_line(sys,[745,120;745,240;680,240])

drawnow

% Return any arguments.
if (nargin | nargout)
    % Must use feval here to access system in memory
    if (nargin > 3)
        if (flag == 0)
            eval(['[ret,x0,str,ts,xts]=',sys,'(t,x,u,flag);'])
        else
            eval(['ret =', sys,'(t,x,u,flag);'])
        end
    else
        [ret,x0,str,ts,xts] = feval(sys);
    end
else
    drawnow % Flash up the model and execute load callback
end
