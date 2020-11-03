function [ret,x0,str,ts,xts]=sim11ex6(t,x,u,flag);
%SIM11EX6   is the M-file description of the SIMULINK system named SIM11EX6.
%   The block-diagram can be displayed by typing: SIM11EX6.
%
%   SYS=SIM11EX6(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes SIM11EX6 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling SIM11EX6 with a FLAG of zero:
%   [SIZES]=SIM11EX6([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[127,58,980,604])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '2')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.01')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Note',[sys,'/','EXAMPLE  11.6'])
set_param([sys,'/','EXAMPLE  11.6'],...
        'position',[325,40,330,45])

add_block('built-in/Note',[sys,'/','NUMERICAL SOLUTION OF THE SWING EQUATION  (ONE MACHINE SYSTEM)'])
set_param([sys,'/','NUMERICAL SOLUTION OF THE SWING EQUATION  (ONE MACHINE SYSTEM)'],...
        'position',[350,70,355,75])

add_block('built-in/Note',[sys,'/','Change the clrearing time of faut'])
set_param([sys,'/','Change the clrearing time of faut'],...
        'position',[330,105,335,110])

add_block('built-in/Note',[sys,'/','to find the critical clearing time'])
set_param([sys,'/','to find the critical clearing time'],...
        'position',[325,130,330,135])

add_block('built-in/Note',[sys,'/',['X2''']])
set_param([sys,'/',['X2''']],...
        'position',[250,170,255,175])

add_block('built-in/Integrator',[sys,'/','integ1'])
set_param([sys,'/','integ1'],...
        'position',[270,182,305,218])

add_block('built-in/Note',[sys,'/','x2'])
set_param([sys,'/','x2'],...
        'position',[320,175,325,180])

add_block('built-in/Integrator',[sys,'/','integ2'])
set_param([sys,'/','integ2'],...
        'Initial','0.46055',...
        'position',[350,182,385,218])

add_block('built-in/Switch',[sys,'/','tc = 0.3'])
set_param([sys,'/','tc = 0.3'],...
        'orientation',2,...
        'Threshold','0.3',...
        'position',[160,263,220,397])

add_block('built-in/Clock',[sys,'/','t'])
set_param([sys,'/','t'],...
        'orientation',2,...
        'position',[250,315,275,345])

add_block('built-in/Fcn',[sys,'/',[' Fault cleared',13,'']])
set_param([sys,'/',[' Fault cleared',13,'']],...
        'orientation',2,...
        'Expr','1.4625*sin(u)',...
        'position',[290,266,400,304])

add_block('built-in/Fcn',[sys,'/','During fault'])
set_param([sys,'/','During fault'],...
        'orientation',2,...
        'Expr','0.65*sin(u)',...
        'position',[285,356,400,394])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','+-',...
        'position',[110,174,135,221])

add_block('built-in/Gain',[sys,'/','60*pi//H'])
set_param([sys,'/','60*pi//H'],...
        'Gain','pi*60/5',...
        'position',[165,159,240,241])

add_block('built-in/Note',[sys,'/','Pe'])
set_param([sys,'/','Pe'],...
        'position',[250,255,260,265])

add_block('built-in/Note',[sys,'/','Pe_'])
set_param([sys,'/','Pe_'],...
        'position',[255,380,260,385])

add_block('built-in/Note',[sys,'/','x1'])
set_param([sys,'/','x1'],...
        'position',[420,170,425,175])

add_block('built-in/Gain',[sys,'/',['Rad. to Degree',13,'']])
set_param([sys,'/',['Rad. to Degree',13,'']],...
        'Gain','180/pi',...
        'position',[480,162,550,238])


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
        'Mask Entries','2\/-50\/100\/200\/''r-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block ['Auto-Scale',13,'Graph'].

set_param([sys,'/',['Auto-Scale',13,'Graph']],...
        'position',[610,168,655,232])

add_block('built-in/Note',[sys,'/','delta'])
set_param([sys,'/','delta'],...
        'position',[575,170,580,175])

add_block('built-in/Note',[sys,'/',['To change the clearing time of fault open the switch ',13,'dialog box and change the Threshold setting.            ']])
set_param([sys,'/',['To change the clearing time of fault open the switch ',13,'dialog box and change the Threshold setting.            ']],...
        'position',[315,430,320,435])

add_block('built-in/Step Fcn',[sys,'/','Step'])
set_param([sys,'/','Step'],...
        'Time','.01',...
        'Before','0.8',...
        'After','0.8',...
        'position',[15,158,65,212])

add_block('built-in/Note',[sys,'/','Pm = 0.8'])
set_param([sys,'/','Pm = 0.8'],...
        'position',[50,130,55,135])
add_line(sys,[310,200;345,200])
add_line(sys,[70,185;105,185])
add_line(sys,[555,200;605,200])
add_line(sys,[390,200;475,200])
add_line(sys,[140,200;160,200])
add_line(sys,[245,200;265,200])
add_line(sys,[285,285;225,285])
add_line(sys,[280,375;225,375])
add_line(sys,[155,330;85,330;85,210;105,210])
add_line(sys,[245,330;225,330])
add_line(sys,[420,200;420,285;405,285])
add_line(sys,[440,200;440,375;405,375])

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
