function [ret,x0,str,ts,xts]=simexa23(t,x,u,flag);
%SIMEXA23   is the M-file description of the SIMULINK system named SIMEXA23.
%   The block-diagram can be displayed by typing: SIMEXA23.
%
%   SYS=SIMEXA23(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes SIMEXA23 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling SIMEXA23 with a FLAG of zero:
%   [SIZES]=SIMEXA23([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[186,222,686,522])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '20')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.10')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/State-Space',[sys,'/','State-Space'])
set_param([sys,'/','State-Space'],...
        'A','[0   1   0;  0   0   1;  -5  -4  -2]',...
        'B','[0;   0 ;  5]',...
        'C','[1 0   0 ]',...
        'D','0',...
        'position',[170,99,270,161])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
        'Time','100',...
        'Before','1',...
        'position',[70,110,110,150])

add_block('built-in/Note',[sys,'/','u(t)'])
set_param([sys,'/','u(t)'],...
        'position',[90,80,95,85])


%     Subsystem  ['Auto-Scale',13,'Graph'].

new_system([sys,'/',['Auto-Scale',13,'Graph']])
set_param([sys,'/',['Auto-Scale',13,'Graph']],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/',['Auto-Scale',13,'Graph/x']])
set_param([sys,'/',['Auto-Scale',13,'Graph/x']],...
        'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['Auto-Scale',13,'Graph/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Auto-Scale',13,'Graph/S-function',13,'M-file which plots',13,'lines',13,'']],...
        'function name','sfunyst',...
        'parameters','ax, color, npts, dt',...
        'position',[130,55,180,75])
add_line([sys,'/',['Auto-Scale',13,'Graph']],[90,65;125,65])
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
        'Mask Display','plot(0,0,100,100,[83,76,63,52,42,38,28,16,11,84,11,11,11,90,90,11],[75,58,47,54,72,80,84,74,65,65,65,90,40,40,90,90])',...
        'Mask Type','Storage scope.')
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
        'Mask Dialogue','Storage scope using MATLAB graph window.\nEnter plotting ranges and line type.|Initial Time Range:|Initial y-min:|Initial y-max:|Storage pts.:|Line type (rgbw-.:xo):')
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
        'Mask Translate','npts = @4; color = @5; ax = [0, @1, @2, @3]; dt=-1;')
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
        'Mask Help','This block uses a MATLAB figure window to plot the input signal.  The graph limits are automatically scaled to the min and max values of the signal stored in the scope''s signal buffer.  Line type must be in quotes.  See the M-file sfunyst.m.')
set_param([sys,'/',['Auto-Scale',13,'Graph']],...
        'Mask Entries','20\/0\/1.5\/200\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block ['Auto-Scale',13,'Graph'].

set_param([sys,'/',['Auto-Scale',13,'Graph']],...
        'position',[335,100,380,160])
add_line(sys,[115,130;165,130])
add_line(sys,[275,130;330,130])

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
