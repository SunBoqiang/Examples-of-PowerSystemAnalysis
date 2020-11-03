function [ret,x0,str,ts,xts]=chp12sm1(t,x,u,flag);
%CHP12SM1   is the M-file description of the SIMULINK system named CHP12SM1.
%   The block-diagram can be displayed by typing: CHP12SM1.
%
%   SYS=CHP12SM1(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes CHP12SM1 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling CHP12SM1 with a FLAG of zero:
%   [SIZES]=CHP12SM1([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[137,147,882,840])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '10')
set_param(sys,'Min step size', '0.001')
set_param(sys,'Max step size', '.05')
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
        'position',[290,130,335,180])

add_block('built-in/Transfer Fcn',[sys,'/','   Governor'])
set_param([sys,'/','   Governor'],...
        'Denominator','[0.2   1]',...
        'position',[150,52,215,98])

add_block('built-in/Transfer Fcn',[sys,'/','Turbine'])
set_param([sys,'/','Turbine'],...
        'Denominator','[0.5  1]',...
        'position',[255,53,325,97])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','-+',...
        'position',[380,60,400,80])

add_block('built-in/Transfer Fcn',[sys,'/',['Inertia & load',13,'']])
set_param([sys,'/',['Inertia & load',13,'']],...
        'Denominator','[10  0.8]',...
        'position',[435,47,515,93])


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
        'Mask Entries','10\/-.015\/0\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
        'position',[595,51,625,89])

add_block('built-in/To Workspace',[sys,'/','To Workspace'])
set_param([sys,'/','To Workspace'],...
        'mat-name','Dw',...
        'position',[595,4,645,26])

add_block('built-in/Step Fcn',[sys,'/',['DPL',13,'']])
set_param([sys,'/',['DPL',13,'']],...
        'Time','100',...
        'Before','0.2',...
        'After','.2',...
        'position',[325,10,345,30])
add_line(sys,[220,75;250,75])
add_line(sys,[330,75;375,75])
add_line(sys,[405,70;430,70])
add_line(sys,[120,75;145,75])
add_line(sys,[520,70;590,70])
add_line(sys,[285,155;55,155;55,85;90,85])
add_line(sys,[540,70;540,155;340,155])
add_line(sys,[560,70;560,15;590,15])
add_line(sys,[350,20;360,20;360,65;375,65])

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
