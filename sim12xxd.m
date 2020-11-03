function [ret,x0,str,ts,xts]=sim12x9b(t,x,u,flag);
%SIM12X9B   is the M-file description of the SIMULINK system named SIM12X9B.
%   The block-diagram can be displayed by typing: SIM12X9B.
%
%   SYS=SIM12X9B(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes SIM12X9B to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling SIM12X9B with a FLAG of zero:
%   [SIZES]=SIM12X9B([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[129,222,819,636])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '3')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.050')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Gain',[sys,'/','K1'])
set_param([sys,'/','K1'],...
        'orientation',2,...
        'Gain','4.2',...
        'position',[205,184,250,236])

add_block('built-in/State-Space',[sys,'/','State-Space'])
set_param([sys,'/','State-Space'],...
        'A','[-5  0  -100;  2  -2  0;  0  0.1  -0.08]',...
        'B','[0;   0 ;  -0.1]',...
        'C','eye(3)',...
        'D','zeros(3, 1)',...
        'position',[260,99,360,161])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','+---',...
        'position',[195,107,215,153])


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
        'Mask Entries','3\/-0.005\/0\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
        'position',[575,123,620,177])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
        'Time','10',...
        'Before','0.2',...
        'After','.2',...
        'position',[45,95,85,135])

add_block('built-in/Demux',[sys,'/','Demux'])
set_param([sys,'/','Demux'],...
        'outputs','3',...
        'position',[405,98,465,162])

add_block('built-in/Gain',[sys,'/','K3'])
set_param([sys,'/','K3'],...
        'orientation',2,...
        'Gain','.8',...
        'position',[205,327,260,383])

add_block('built-in/Gain',[sys,'/','K2'])
set_param([sys,'/','K2'],...
        'orientation',2,...
        'Gain','.8',...
        'position',[205,257,255,313])

add_block('built-in/Note',[sys,'/','State feedback'])
set_param([sys,'/','State feedback'],...
        'position',[450,230,455,235])

add_block('built-in/Note',[sys,'/','Feedback gain'])
set_param([sys,'/','Feedback gain'],...
        'position',[350,290,355,295])

add_block('built-in/Note',[sys,'/','Using pole-placement design'])
set_param([sys,'/','Using pole-placement design'],...
        'position',[395,315,410,320])
add_line(sys,[365,130;400,130])
add_line(sys,[470,150;570,150])
add_line(sys,[470,110;500,110;500,210;255,210])
add_line(sys,[470,130;520,130;520,285;260,285])
add_line(sys,[220,130;255,130])
add_line(sys,[200,210;170,210;170,145;190,145])
add_line(sys,[200,285;155,285;155,135;190,135])
add_line(sys,[90,115;190,115])
add_line(sys,[550,150;550,355;265,355])
add_line(sys,[200,355;130,355;130,125;190,125])

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
