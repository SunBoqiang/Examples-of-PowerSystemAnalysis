function [ret,x0,str,ts,xts]=chp12sm3(t,x,u,flag);
%CHP12SM3   is the M-file description of the SIMULINK system named CHP12SM3.
%   The block-diagram can be displayed by typing: CHP12SM3.
%
%   SYS=CHP12SM3(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes CHP12SM3 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling CHP12SM3 with a FLAG of zero:
%   [SIZES]=CHP12SM3([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[143,258,892,951])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '10')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.1')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Sum',[sys,'/','Sum1'])
set_param([sys,'/','Sum1'],...
        'inputs','--',...
        'position',[95,57,115,93])

add_block('built-in/Gain',[sys,'/','1//R'])
set_param([sys,'/','1//R'],...
        'orientation',2,...
        'Gain','20',...
        'position',[285,128,340,182])

add_block('built-in/Integrator',[sys,'/','Integrator'])
set_param([sys,'/','Integrator'],...
        'orientation',2,...
        'position',[260,198,290,242])

add_block('built-in/Gain',[sys,'/','KI'])
set_param([sys,'/','KI'],...
        'orientation',2,...
        'Gain','7',...
        'position',[165,197,215,243])

add_block('built-in/Transfer Fcn',[sys,'/','Governor'])
set_param([sys,'/','Governor'],...
        'Denominator','[0.2   1]',...
        'position',[145,52,210,98])

add_block('built-in/Transfer Fcn',[sys,'/','Turbine'])
set_param([sys,'/','Turbine'],...
        'Denominator','[0.5  1]',...
        'position',[250,53,320,97])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
        'Time','100',...
        'Before','0.2',...
        'After','.2',...
        'position',[295,5,315,25])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','-+',...
        'position',[375,60,395,80])

add_block('built-in/Transfer Fcn',[sys,'/','Inertia & load'])
set_param([sys,'/','Inertia & load'],...
        'Denominator','[10  0.8]',...
        'position',[420,47,500,93])


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
        'Mask Entries','10\/-.05\/.05\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
        'position',[620,51,650,89])

add_block('built-in/To Workspace',[sys,'/','To Workspace'])
set_param([sys,'/','To Workspace'],...
        'mat-name','Dw',...
        'position',[630,7,680,23])
add_line(sys,[215,75;245,75])
add_line(sys,[325,75;370,75])
add_line(sys,[400,70;415,70])
add_line(sys,[120,75;140,75])
add_line(sys,[505,70;615,70])
add_line(sys,[255,220;220,220])
add_line(sys,[160,220;30,220;30,65;90,65])
add_line(sys,[280,155;55,155;55,85;90,85])
add_line(sys,[320,15;350,15;350,65;370,65])
add_line(sys,[520,70;520,155;345,155])
add_line(sys,[565,70;565,220;295,220])
add_line(sys,[585,70;585,15;625,15])

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
