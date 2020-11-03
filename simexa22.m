function [ret,x0,str,ts,xts]=simexa22(t,x,u,flag);
%SIMEXA22   is the M-file description of the SIMULINK system named SIMEXA22.
%   The block-diagram can be displayed by typing: SIMEXA22.
%
%   SYS=SIMEXA22(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes SIMEXA22 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling SIMEXA22 with a FLAG of zero:
%   [SIZES]=SIMEXA22([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[217,269,848,696])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '3')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '0.1')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')


%     Subsystem  ['Auto-Scale',13,'Graph1'].

new_system([sys,'/',['Auto-Scale',13,'Graph1']])
set_param([sys,'/',['Auto-Scale',13,'Graph1']],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/',['Auto-Scale',13,'Graph1/x']])
set_param([sys,'/',['Auto-Scale',13,'Graph1/x']],...
        'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['Auto-Scale',13,'Graph1/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Auto-Scale',13,'Graph1/S-function',13,'M-file which plots',13,'lines',13,'']],...
        'function name','sfunyst',...
        'parameters','ax, color, npts, dt',...
        'position',[130,55,180,75])
add_line([sys,'/',['Auto-Scale',13,'Graph1']],[90,65;125,65])
set_param([sys,'/',['Auto-Scale',13,'Graph1']],...
        'Mask Display','plot(0,0,100,100,[83,76,63,52,42,38,28,16,11,84,11,11,11,90,90,11],[75,58,47,54,72,80,84,74,65,65,65,90,40,40,90,90])',...
        'Mask Type','Storage scope.')
set_param([sys,'/',['Auto-Scale',13,'Graph1']],...
        'Mask Dialogue','Storage scope using MATLAB graph window.\nEnter plotting ranges and line type.|Initial Time Range:|Initial y-min:|Initial y-max:|Storage pts.:|Line type (rgbw-.:xo):')
set_param([sys,'/',['Auto-Scale',13,'Graph1']],...
        'Mask Translate','npts = @4; color = @5; ax = [0, @1, @2, @3]; dt=-1;')
set_param([sys,'/',['Auto-Scale',13,'Graph1']],...
        'Mask Help','This block uses a MATLAB figure window to plot the input signal.  The graph limits are automatically scaled to the min and max values of the signal stored in the scope''s signal buffer.  Line type must be in quotes.  See the M-file sfunyst.m.')
set_param([sys,'/',['Auto-Scale',13,'Graph1']],...
        'Mask Entries','3\/-0.5\/3\/200\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block ['Auto-Scale',13,'Graph1'].

set_param([sys,'/',['Auto-Scale',13,'Graph1']],...
        'position',[420,3,460,57])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','+--',...
        'position',[135,101,170,139])

add_block('built-in/Note',[sys,'/','x1'])
set_param([sys,'/','x1'],...
        'position',[470,90,475,95])

add_block('built-in/Note',[sys,'/','x2'])
set_param([sys,'/','x2'],...
        'position',[345,90,350,95])

add_block('built-in/Note',[sys,'/','x2dot'])
set_param([sys,'/','x2dot'],...
        'position',[195,75,200,80])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
        'Time','100',...
        'Before','25',...
        'After','25',...
        'position',[5,78,75,142])

add_block('built-in/Note',[sys,'/','F = 25'])
set_param([sys,'/','F = 25'],...
        'position',[35,45,40,50])

add_block('built-in/Gain',[sys,'/','Gain'])
set_param([sys,'/','Gain'],...
        'orientation',2,...
        'Gain','25',...
        'position',[220,263,280,337])

add_block('built-in/Gain',[sys,'/','Gain1'])
set_param([sys,'/','Gain1'],...
        'orientation',2,...
        'Gain','5',...
        'position',[210,163,275,227])


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
        'Mask Entries','3\/0\/1.5\/200\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block ['Auto-Scale',13,'Graph'].

set_param([sys,'/',['Auto-Scale',13,'Graph']],...
        'position',[565,92,605,148])

add_block('built-in/Integrator',[sys,'/','Integrator1'])
set_param([sys,'/','Integrator1'],...
        'position',[380,97,425,143])

add_block('built-in/Integrator',[sys,'/','Integrator'])
set_param([sys,'/','Integrator'],...
        'position',[225,95,275,145])
add_line(sys,[80,110;130,110])
add_line(sys,[175,120;220,120])
add_line(sys,[280,120;375,120])
add_line(sys,[205,195;120,195;130,130])
add_line(sys,[430,120;560,120])
add_line(sys,[515,120;515,300;285,300])
add_line(sys,[215,300;95,300;95,120;130,120])
add_line(sys,[310,120;310,30;415,30])
add_line(sys,[310,120;310,195;280,195])

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
