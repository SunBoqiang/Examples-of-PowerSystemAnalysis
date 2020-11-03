function [ret,x0,str,ts,xts]=chp12sm4(t,x,u,flag);
%CHP12SM4   is the M-file description of the SIMULINK system named CHP12SM4.
%   The block-diagram can be displayed by typing: CHP12SM4.
%
%   SYS=CHP12SM4(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes CHP12SM4 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling CHP12SM4 with a FLAG of zero:
%   [SIZES]=CHP12SM4([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[86,58,868,751])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '25')
set_param(sys,'Min step size', '0.001')
set_param(sys,'Max step size', '.1')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Transfer Fcn',[sys,'/',' Governor 1'])
set_param([sys,'/',' Governor 1'],...
        'Denominator','[0.2   1]',...
        'position',[165,202,230,248])

add_block('built-in/Sum',[sys,'/','Sum1'])
set_param([sys,'/','Sum1'],...
        'inputs','--',...
        'position',[90,207,110,243])

add_block('built-in/Gain',[sys,'/','1//R1'])
set_param([sys,'/','1//R1'],...
        'orientation',2,...
        'Gain','20',...
        'position',[320,85,365,125])

add_block('built-in/Transfer Fcn',[sys,'/',['Inertia & load 1',13,'']])
set_param([sys,'/',['Inertia & load 1',13,'']],...
        'Denominator','[10  0.6]',...
        'position',[480,202,560,248])

add_block('built-in/Gain',[sys,'/','1//R2'])
set_param([sys,'/','1//R2'],...
        'orientation',2,...
        'Gain','16',...
        'position',[330,487,385,533])

add_block('built-in/Transfer Fcn',[sys,'/','Inertia & load 2'])
set_param([sys,'/','Inertia & load 2'],...
        'Denominator','[8  0.9]',...
        'position',[480,372,560,418])

add_block('built-in/Sum',[sys,'/','Sum3'])
set_param([sys,'/','Sum3'],...
        'position',[415,377,435,413])

add_block('built-in/Sum',[sys,'/','Sum4'])
set_param([sys,'/','Sum4'],...
        'inputs','--',...
        'position',[100,387,120,423])

add_block('built-in/Transfer Fcn',[sys,'/','   Governor 2'])
set_param([sys,'/','   Governor 2'],...
        'Denominator','[0.3   1]',...
        'position',[170,382,235,428])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','-+-',...
        'position',[410,207,430,243])

add_block('built-in/Step Fcn',[sys,'/',['DPL',13,'']])
set_param([sys,'/',['DPL',13,'']],...
        'orientation',1,...
        'Time','100',...
        'Before','0.1875',...
        'After','.1875',...
        'position',[385,160,405,180])

add_block('built-in/Transfer Fcn',[sys,'/',' Turbine 1'])
set_param([sys,'/',' Turbine 1'],...
        'Denominator','[0.5  1]',...
        'position',[290,203,360,247])

add_block('built-in/Sum',[sys,'/','Sum2'])
set_param([sys,'/','Sum2'],...
        'orientation',2,...
        'inputs','+-',...
        'position',[545,310,565,330])


%     Subsystem  ['Dw1',13,'Dw2 '].

new_system([sys,'/',['Dw1',13,'Dw2 ']])
set_param([sys,'/',['Dw1',13,'Dw2 ']],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/',['Dw1',13,'Dw2 /x']])
set_param([sys,'/',['Dw1',13,'Dw2 /x']],...
        'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['Dw1',13,'Dw2 /S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Dw1',13,'Dw2 /S-function',13,'M-file which plots',13,'lines',13,'']],...
        'function name','sfuny',...
        'parameters','ax, color,dt',...
        'position',[130,55,180,75])
add_line([sys,'/',['Dw1',13,'Dw2 ']],[90,65;125,65])
set_param([sys,'/',['Dw1',13,'Dw2 ']],...
        'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
        'Mask Type','Graph scope.')
set_param([sys,'/',['Dw1',13,'Dw2 ']],...
        'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/',['Dw1',13,'Dw2 ']],...
        'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/',['Dw1',13,'Dw2 ']],...
        'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/',['Dw1',13,'Dw2 ']],...
        'Mask Entries','25\/-.015\/0.0\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block ['Dw1',13,'Dw2 '].

set_param([sys,'/',['Dw1',13,'Dw2 ']],...
        'orientation',1,...
        'position',[605,475,635,515])

add_block('built-in/Mux',[sys,'/','Mux'])
set_param([sys,'/','Mux'],...
        'orientation',1,...
        'inputs','2',...
        'position',[602,415,633,450])

add_block('built-in/Mux',[sys,'/','Mux1'])
set_param([sys,'/','Mux1'],...
        'orientation',1,...
        'inputs','3',...
        'position',[690,415,730,455])

add_block('built-in/Clock',[sys,'/','Clock'])
set_param([sys,'/','Clock'],...
        'orientation',1,...
        'position',[685,320,705,340])

add_block('built-in/Mux',[sys,'/','Mux2'])
set_param([sys,'/','Mux2'],...
        'orientation',2,...
        'position',[205,285,245,325])

add_block('built-in/Clock',[sys,'/','Clock1'])
set_param([sys,'/','Clock1'],...
        'orientation',2,...
        'position',[295,280,315,300])

add_block('built-in/Transfer Fcn',[sys,'/','Turbine 2'])
set_param([sys,'/','Turbine 2'],...
        'Denominator','[0.6  1]',...
        'position',[295,383,365,427])

add_block('built-in/To Workspace',[sys,'/','t, Pm1, Pm2, P12'])
set_param([sys,'/','t, Pm1, Pm2, P12'],...
        'orientation',2,...
        'mat-name','DP',...
        'position',[65,295,155,315])

add_block('built-in/To Workspace',[sys,'/',['t  ',13,'Dw1',13,'Dw2']])
set_param([sys,'/',['t  ',13,'Dw1',13,'Dw2']],...
        'orientation',1,...
        'mat-name','Dw',...
        'position',[685,470,735,515])

add_block('built-in/Gain',[sys,'/','Gain'])
set_param([sys,'/','Gain'],...
        'orientation',2,...
        'Gain','2',...
        'position',[415,302,450,338])

add_block('built-in/Integrator',[sys,'/','Integrator'])
set_param([sys,'/','Integrator'],...
        'orientation',2,...
        'position',[485,305,515,335])
add_line(sys,[235,225;285,225])
add_line(sys,[365,225;405,225])
add_line(sys,[435,225;475,225])
add_line(sys,[115,225;160,225])
add_line(sys,[565,225;590,225;590,105;370,105])
add_line(sys,[395,185;405,215])
add_line(sys,[315,105;55,105;55,215;85,215])
add_line(sys,[540,320;520,320])
add_line(sys,[480,320;455,320])
add_line(sys,[440,395;475,395])
add_line(sys,[240,405;290,405])
add_line(sys,[125,405;165,405])
add_line(sys,[370,405;410,405])
add_line(sys,[325,510;60,510;60,415;95,415])
add_line(sys,[565,395;590,395;590,510;390,510])
add_line(sys,[200,305;160,305])
add_line(sys,[290,290;250,290])
add_line(sys,[590,395;590,325;570,325])
add_line(sys,[590,225;590,315;570,315])
add_line(sys,[620,455;620,470])
add_line(sys,[710,460;710,465])
add_line(sys,[590,395;725,395;725,410])
add_line(sys,[695,345;695,410])
add_line(sys,[590,225;610,225;610,410])
add_line(sys,[625,395;625,410])
add_line(sys,[610,375;710,375;710,410])
add_line(sys,[410,320;250,320])
add_line(sys,[390,320;390,235;405,235])
add_line(sys,[390,320;390,385;410,385])
add_line(sys,[270,405;270,310;250,310])
add_line(sys,[270,225;270,300;250,300])

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
