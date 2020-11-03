function [ret,x0,str,ts,xts]=sim12p12(t,x,u,flag);
%SIM12P12   is the M-file description of the SIMULINK system named SIM12P12.
%   The block-diagram can be displayed by typing: SIM12P12.
%
%   SYS=SIM12P12(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes SIM12P12 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling SIM12P12 with a FLAG of zero:
%   [SIZES]=SIM12P12([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[102,58,960,751])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-23')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '15')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.05')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Note',[sys,'/','DPm'])
set_param([sys,'/','DPm'],...
        'position',[300,175,305,180])

add_block('built-in/Transfer Fcn',[sys,'/','Inertia & load'])
set_param([sys,'/','Inertia & load'],...
        'Denominator','[10  0.8]',...
        'position',[415,182,495,228])

add_block('built-in/Note',[sys,'/','Vref'])
set_param([sys,'/','Vref'],...
        'position',[35,350,40,370])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','-+-',...
        'position',[365,181,390,229])

add_block('built-in/Transfer Fcn',[sys,'/','Turbine'])
set_param([sys,'/','Turbine'],...
        'Denominator','[0.5  1]',...
        'position',[205,183,275,227])

add_block('built-in/Transfer Fcn',[sys,'/','Governor'])
set_param([sys,'/','Governor'],...
        'Denominator','[0.2   1]',...
        'position',[110,182,175,228])

add_block('built-in/Sum',[sys,'/','Sum1'])
set_param([sys,'/','Sum1'],...
        'inputs','--',...
        'position',[55,187,75,223])


%     Subsystem  'Graph1'.

new_system([sys,'/','Graph1'])
set_param([sys,'/','Graph1'],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/','Graph1/x'])
set_param([sys,'/','Graph1/x'],...
        'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['Graph1/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Graph1/S-function',13,'M-file which plots',13,'lines',13,'']],...
        'function name','sfuny',...
        'parameters','ax, color,dt',...
        'position',[130,55,180,75])
add_line([sys,'/','Graph1'],[90,65;125,65])
set_param([sys,'/','Graph1'],...
        'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
        'Mask Type','Graph scope.')
set_param([sys,'/','Graph1'],...
        'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/','Graph1'],...
        'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/','Graph1'],...
        'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/','Graph1'],...
        'Mask Entries','15\/-0.04\/0.005\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph1'.

set_param([sys,'/','Graph1'],...
        'position',[560,111,590,149])

add_block('built-in/Integrator',[sys,'/','Integrator1'])
set_param([sys,'/','Integrator1'],...
        'position',[590,187,620,223])

add_block('built-in/Note',[sys,'/','Ve'])
set_param([sys,'/','Ve'],...
        'position',[130,384,135,391])

add_block('built-in/Gain',[sys,'/','K5'])
set_param([sys,'/','K5'],...
        'orientation',1,...
        'Gain','-0.1',...
        'position',[635,325,695,375])

add_block('built-in/Note',[sys,'/','Vt'])
set_param([sys,'/','Vt'],...
        'position',[730,375,735,380])

add_block('built-in/Transfer Fcn',[sys,'/','Sensor'])
set_param([sys,'/','Sensor'],...
        'orientation',2,...
        'Denominator','[0.05  1]',...
        'position',[330,484,425,536])

add_block('built-in/Note',[sys,'/',['E''']])
set_param([sys,'/',['E''']],...
        'position',[585,420,590,425])

add_block('built-in/Sum',[sys,'/','Sum3'])
set_param([sys,'/','Sum3'],...
        'orientation',2,...
        'position',[290,270,310,310])

add_block('built-in/Transfer Fcn',[sys,'/','Generator'])
set_param([sys,'/','Generator'],...
        'Numerator','[0.8]',...
        'Denominator','[ 1.4 1]',...
        'position',[505,399,575,451])

add_block('built-in/Gain',[sys,'/','K6'])
set_param([sys,'/','K6'],...
        'Gain','.5',...
        'position',[615,400,675,450])

add_block('built-in/Sum',[sys,'/','Sum5'])
set_param([sys,'/','Sum5'],...
        'position',[705,397,725,433])


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
        'Mask Entries','15\/0\/1.1\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'Graph'.

set_param([sys,'/','Graph'],...
        'position',[780,396,810,434])

add_block('built-in/Gain',[sys,'/','K4'])
set_param([sys,'/','K4'],...
        'orientation',1,...
        'Gain','1.4',...
        'position',[405,360,465,410])

add_block('built-in/Gain',[sys,'/','K2'])
set_param([sys,'/','K2'],...
        'orientation',2,...
        'Gain','.2',...
        'position',[480,305,535,365])

add_block('built-in/Sum',[sys,'/','Sum4'])
set_param([sys,'/','Sum4'],...
        'inputs','-+',...
        'position',[455,407,475,443])

add_block('built-in/Gain',[sys,'/','K1=Ps'])
set_param([sys,'/','K1=Ps'],...
        'orientation',2,...
        'Gain','1.5',...
        'position',[355,253,405,307])

add_block('built-in/Note',[sys,'/','VR'])
set_param([sys,'/','VR'],...
        'position',[305,380,335,386])

add_block('built-in/Step Fcn',[sys,'/','Step Input1'])
set_param([sys,'/','Step Input1'],...
        'Time','12',...
        'Before','1',...
        'position',[20,407,60,443])

add_block('built-in/Sum',[sys,'/','Sum2'])
set_param([sys,'/','Sum2'],...
        'inputs','+-',...
        'position',[100,415,135,455])


%     Subsystem  'PID Controller'.

new_system([sys,'/','PID Controller'])
set_param([sys,'/','PID Controller'],'Location',[0,0,362,244])

add_block('built-in/Sum',[sys,'/','PID Controller/Sum'])
set_param([sys,'/','PID Controller/Sum'],...
        'inputs','+++',...
        'position',[245,57,265,93])

add_block('built-in/Gain',[sys,'/','PID Controller/D'])
set_param([sys,'/','PID Controller/D'],...
        'Gain','D',...
        'position',[95,129,115,151])

add_block('built-in/Gain',[sys,'/','PID Controller/Proportional'])
set_param([sys,'/','PID Controller/Proportional'],...
        'Gain','P',...
        'position',[120,13,140,37])

add_block('built-in/Transfer Fcn',[sys,'/','PID Controller/Integral'])
set_param([sys,'/','PID Controller/Integral'],...
        'Numerator','[I]',...
        'Denominator','[1 0]',...
        'position',[110,57,145,93])

add_block('built-in/Derivative',[sys,'/','PID Controller/Derivative'])
set_param([sys,'/','PID Controller/Derivative'],...
        'position',[150,128,190,152])

add_block('built-in/Outport',[sys,'/','PID Controller/Out_1'])
set_param([sys,'/','PID Controller/Out_1'],...
        'position',[290,65,310,85])

add_block('built-in/Inport',[sys,'/','PID Controller/In_1'])
set_param([sys,'/','PID Controller/In_1'],...
        'position',[25,65,45,85])
add_line([sys,'/','PID Controller'],[120,140;145,140])
add_line([sys,'/','PID Controller'],[270,75;285,75])
add_line([sys,'/','PID Controller'],[50,75;105,75])
add_line([sys,'/','PID Controller'],[65,75;65,140;90,140])
add_line([sys,'/','PID Controller'],[80,75;80,25;115,25])
add_line([sys,'/','PID Controller'],[195,140;215,140;215,85;240,85])
add_line([sys,'/','PID Controller'],[150,75;240,75])
add_line([sys,'/','PID Controller'],[145,25;210,25;210,65;240,65])
set_param([sys,'/','PID Controller'],...
        'Mask Display','PID',...
        'Mask Type','PID Controller',...
        'Mask Dialogue','Enter expressions for proportional, integral, and derivative terms.\nP+I/s+Ds|Proportional:|Integral|Derivative:')
set_param([sys,'/','PID Controller'],...
        'Mask Translate','P=@1; I=@2; D=@3;')
set_param([sys,'/','PID Controller'],...
        'Mask Help','This block implements a PID controller where parameters are entered for the Proportional, Integral and Derivative terms. Unmask this block to see how it works. The derivative term is implemented using a true derivative block.')
set_param([sys,'/','PID Controller'],...
        'Mask Entries','1\/0.25\/0.3\/')


%     Finished composite block 'PID Controller'.

set_param([sys,'/','PID Controller'],...
        'position',[170,419,210,451])

add_block('built-in/Transfer Fcn',[sys,'/','Exciter'])
set_param([sys,'/','Exciter'],...
        'Numerator','1',...
        'Denominator','[0.4  1]',...
        'position',[335,411,405,459])

add_block('built-in/Note',[sys,'/','Vf'])
set_param([sys,'/','Vf'],...
        'position',[415,405,420,410])

add_block('built-in/Transfer Fcn',[sys,'/','Amplifier'])
set_param([sys,'/','Amplifier'],...
        'Numerator','10',...
        'Denominator','[0.1  1]',...
        'position',[240,409,310,461])

add_block('built-in/Gain',[sys,'/','1//R'])
set_param([sys,'/','1//R'],...
        'orientation',2,...
        'Gain','20',...
        'position',[230,103,285,157])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
        'orientation',1,...
        'Time','2',...
        'Before','0.2',...
        'After','.2',...
        'position',[320,140,340,160])

add_block('built-in/Integrator',[sys,'/','Integrator'])
set_param([sys,'/','Integrator'],...
        'orientation',2,...
        'position',[155,68,185,112])

add_block('built-in/Gain',[sys,'/','KI'])
set_param([sys,'/','KI'],...
        'orientation',2,...
        'Gain','6',...
        'position',[65,67,115,113])

add_block('built-in/Note',[sys,'/','Dd'])
set_param([sys,'/','Dd'],...
        'position',[645,175,650,180])

add_block('built-in/Note',[sys,'/','Dw'])
set_param([sys,'/','Dw'],...
        'position',[535,210,540,215])
add_line(sys,[180,205;200,205])
add_line(sys,[280,205;360,205])
add_line(sys,[395,205;410,205])
add_line(sys,[80,205;105,205])
add_line(sys,[330,165;330,190;360,190])
add_line(sys,[65,425;95,425])
add_line(sys,[325,510;85,510;95,445])
add_line(sys,[315,435;330,435])
add_line(sys,[140,435;165,435])
add_line(sys,[215,435;235,435])
add_line(sys,[285,290;285,220;360,220])
add_line(sys,[500,205;585,205])
add_line(sys,[530,205;530,130;555,130])
add_line(sys,[410,435;450,435])
add_line(sys,[480,425;500,425])
add_line(sys,[580,425;610,425])
add_line(sys,[680,425;700,425])
add_line(sys,[350,280;315,280])
add_line(sys,[665,380;665,405;700,405])
add_line(sys,[730,415;775,415])
add_line(sys,[740,415;740,510;430,510])
add_line(sys,[590,425;590,335;540,335])
add_line(sys,[435,415;450,415])
add_line(sys,[475,335;335,335;335,300;315,300])
add_line(sys,[225,130;215,130;215,165;40,165;50,195])
add_line(sys,[150,90;120,90])
add_line(sys,[60,90;25,90;25,215;50,215])
add_line(sys,[625,205;665,205;665,320])
add_line(sys,[665,280;410,280])
add_line(sys,[520,205;520,90;190,90])
add_line(sys,[520,130;290,130])
add_line(sys,[435,280;435,355])

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
