function [ret,x0,str,ts,xts]=sim12x10(t,x,u,flag);
%SIM12X10   is the M-file description of the SIMULINK system named SIM12X10.
%   The block-diagram can be displayed by typing: SIM12X10.
%
%   SYS=SIM12X10(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes SIM12X10 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling SIM12X10 with a FLAG of zero:
%   [SIZES]=SIM12X10([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[147,280,837,694])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '1')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.010')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/State-Space',[sys,'/','State-Space'])
set_param([sys,'/','State-Space'],...
        'A','[-5  0  -100;  2  -2  0;  0  0.1  -0.08]',...
        'B','[0;   0 ;  -0.1]',...
        'C','eye(3)',...
        'D','zeros(3, 1)',...
        'position',[260,99,360,161])

add_block('built-in/Demux',[sys,'/','Demux'])
set_param([sys,'/','Demux'],...
        'outputs','3',...
        'position',[425,96,480,164])


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
        'Mask Entries','1\/-0.0015\/0\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
        'position',[540,123,585,177])

add_block('built-in/State-Space',[sys,'/',['Feedback Gain ',13,'using LQR Design.']])
set_param([sys,'/',['Feedback Gain ',13,'using LQR Design.']],...
        'orientation',2,...
        'A','[]',...
        'B','[]',...
        'C','[]',...
        'D','k',...
        'Mask Display','K',...
        'Mask Type','Regulator')
set_param([sys,'/',['Feedback Gain ',13,'using LQR Design.']],...
        'Mask Dialogue','Linear quadratic regulator.\n(Requires Control Toolbox)|Plant A matrix:|Plant B matrix:|Plant C matrix:|Plant D matrix:|Output weighting, y''Qy:|Input weighting, u''Ru:')
set_param([sys,'/',['Feedback Gain ',13,'using LQR Design.']],...
        'Mask Translate','[k]=lqry(@1,@2,@3,@4,@5,@6);',...
        'Mask Help','Implements a linear state quadratic regulator. Mask and unmask this block to see how it works.')
set_param([sys,'/',['Feedback Gain ',13,'using LQR Design.']],...
        'Mask Entries','[-5   0   -100;  2   -2    0;   0    0.1   -0.08]\/[0;   0;    -0.1]\/eye(3)\/zeros(3,1)\/[20, 0  0;  0  10   0;  0   0   5]      \/eye(1,1)*.15\/')
set_param([sys,'/',['Feedback Gain ',13,'using LQR Design.']],...
        'position',[295,225,365,285])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','+-',...
        'position',[185,104,210,151])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
        'Time','10',...
        'Before','0.2',...
        'After','.2',...
        'position',[55,95,95,135])

add_block('built-in/Note',[sys,'/','Dw'])
set_param([sys,'/','Dw'],...
        'position',[505,120,510,125])

add_block('built-in/Note',[sys,'/',['LQG Demo. Start simulation.',13,'Try varying weighting parameters.']])
set_param([sys,'/',['LQG Demo. Start simulation.',13,'Try varying weighting parameters.']],...
        'position',[320,40,325,45])
add_line(sys,[365,130;420,130])
add_line(sys,[215,130;255,130])
add_line(sys,[100,115;180,115])
add_line(sys,[485,150;535,150])
add_line(sys,[395,130;395,255;370,255])
add_line(sys,[290,255;155,255;155,140;180,140])

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
