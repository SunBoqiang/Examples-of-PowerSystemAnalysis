function [ret,x0,str,ts,xts]=chp12sm6(t,x,u,flag);
%CHP12SM6   is the M-file description of the SIMULINK system named CHP12SM6.
%   The block-diagram can be displayed by typing: CHP12SM6.
%
%   SYS=CHP12SM6(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes CHP12SM6 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling CHP12SM6 with a FLAG of zero:
%   [SIZES]=CHP12SM6([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[151,245,938,690])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '20')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.10')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','+-',...
        'position',[135,100,170,140])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
        'Time','20',...
        'Before','1',...
        'position',[40,92,80,128])

add_block('built-in/Transfer Fcn',[sys,'/','Sensor'])
set_param([sys,'/','Sensor'],...
        'orientation',2,...
        'Denominator','[0.05  1]',...
        'position',[265,229,360,281])

add_block('built-in/Note',[sys,'/','Vref'])
set_param([sys,'/','Vref'],...
        'position',[105,65,110,85])

add_block('built-in/Note',[sys,'/','Ve'])
set_param([sys,'/','Ve'],...
        'position',[195,90,200,95])

add_block('built-in/Transfer Fcn',[sys,'/','Amplifier'])
set_param([sys,'/','Amplifier'],...
        'Numerator','[10]',...
        'Denominator','[0.1  1]',...
        'position',[220,93,305,147])

add_block('built-in/Note',[sys,'/','VR'])
set_param([sys,'/','VR'],...
        'position',[320,90,345,95])

add_block('built-in/Transfer Fcn',[sys,'/','Exciter'])
set_param([sys,'/','Exciter'],...
        'Denominator','[0.4  1]',...
        'position',[375,92,460,148])

add_block('built-in/Note',[sys,'/','VF'])
set_param([sys,'/','VF'],...
        'position',[480,75,485,95])

add_block('built-in/Transfer Fcn',[sys,'/','Generator'])
set_param([sys,'/','Generator'],...
        'Denominator','[1  1]',...
        'position',[525,94,605,146])

add_block('built-in/Note',[sys,'/','Vt'])
set_param([sys,'/','Vt'],...
        'position',[620,85,625,90])


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
        'Mask Entries','20\/0\/2.0\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
        'position',[690,98,730,142])

add_block('built-in/To Workspace',[sys,'/','Terminal Voltage'])
set_param([sys,'/','Terminal Voltage'],...
        'mat-name','Vt',...
        'position',[695,184,740,216])
add_line(sys,[85,110;130,110])
add_line(sys,[175,120;215,120])
add_line(sys,[310,120;370,120])
add_line(sys,[465,120;520,120])
add_line(sys,[610,120;685,120])
add_line(sys,[260,255;120,255;130,130])
add_line(sys,[630,120;630,255;365,255])
add_line(sys,[655,120;655,200;690,200])

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
