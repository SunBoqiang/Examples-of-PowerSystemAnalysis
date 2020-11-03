function [ret,x0,str,ts,xts]=chp12sm7(t,x,u,flag);
%CHP12SM7   is the M-file description of the SIMULINK system named CHP12SM7.
%   The block-diagram can be displayed by typing: CHP12SM7.
%
%   SYS=CHP12SM7(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes CHP12SM7 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling CHP12SM7 with a FLAG of zero:
%   [SIZES]=CHP12SM7([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[151,245,996,690])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-23')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '10')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.050')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','+--',...
        'position',[245,100,280,140])

add_block('built-in/Note',[sys,'/','Ve'])
set_param([sys,'/','Ve'],...
        'position',[300,90,305,95])

add_block('built-in/Note',[sys,'/','VR'])
set_param([sys,'/','VR'],...
        'position',[435,90,440,95])

add_block('built-in/Note',[sys,'/','VF'])
set_param([sys,'/','VF'],...
        'position',[560,75,565,95])

add_block('built-in/Note',[sys,'/','Vt'])
set_param([sys,'/','Vt'],...
        'position',[710,90,715,95])

add_block('built-in/Note',[sys,'/','Vref'])
set_param([sys,'/','Vref'],...
        'position',[210,65,215,85])

add_block('built-in/Transfer Fcn',[sys,'/','Generator'])
set_param([sys,'/','Generator'],...
        'Denominator','[1  1]',...
        'position',[595,94,675,146])

add_block('built-in/Transfer Fcn',[sys,'/','Amplifier'])
set_param([sys,'/','Amplifier'],...
        'Numerator','[10]',...
        'Denominator','[0.1  1]',...
        'position',[335,93,420,147])

add_block('built-in/Transfer Fcn',[sys,'/','Exciter'])
set_param([sys,'/','Exciter'],...
        'Denominator','[0.4  1]',...
        'position',[465,92,550,148])

add_block('built-in/Transfer Fcn',[sys,'/','Sensor'])
set_param([sys,'/','Sensor'],...
        'orientation',2,...
        'Denominator','[0.05  1]',...
        'position',[400,269,495,321])

add_block('built-in/Transfer Fcn',[sys,'/','Stabilizer'])
set_param([sys,'/','Stabilizer'],...
        'orientation',2,...
        'Numerator','[ 2.0  0]',...
        'Denominator','[.04  1]',...
        'position',[350,184,445,236])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
        'Time','10',...
        'Before','1',...
        'position',[145,87,185,123])


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
        'Mask Entries','10\/0\/1.0\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
        'orientation',2,...
        'position',[600,170,640,210])

add_block('built-in/Clock',[sys,'/','Clock'])
set_param([sys,'/','Clock'],...
        'orientation',2,...
        'position',[715,205,735,225])

add_block('built-in/Mux',[sys,'/','Mux'])
set_param([sys,'/','Mux'],...
        'orientation',2,...
        'inputs','2',...
        'position',[650,232,680,263])

add_block('built-in/To Workspace',[sys,'/','Terminal Voltage'])
set_param([sys,'/','Terminal Voltage'],...
        'orientation',2,...
        'mat-name','Vt',...
        'position',[560,235,610,265])
add_line(sys,[190,105;240,105])
add_line(sys,[285,120;330,120])
add_line(sys,[425,120;460,120])
add_line(sys,[555,120;590,120])
add_line(sys,[680,120;770,120;770,295;500,295])
add_line(sys,[345,210;230,210;240,135])
add_line(sys,[395,295;210,295;210,120;240,120])
add_line(sys,[570,120;570,210;450,210])
add_line(sys,[695,120;695,190;645,190])
add_line(sys,[710,215;700,215;700,240;685,240])
add_line(sys,[755,120;755,255;685,255])
add_line(sys,[645,250;615,250])

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
