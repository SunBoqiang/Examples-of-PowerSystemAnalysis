function [ret,x0,str,ts,xts]=chp12sm5(t,x,u,flag);
%CHP12SM5   is the M-file description of the SIMULINK system named CHP12SM5.
%   The block-diagram can be displayed by typing: CHP12SM5.
%
%   SYS=CHP12SM5(T,X,U,FLAG) returns depending on FLAG certain
%   system values given time point, T, current state vector, X,
%   and input vector, U.
%   FLAG is used to indicate the type of output to be returned in SYS.
%
%   Setting FLAG=1 causes CHP12SM5 to return state derivatives, FLAG=2
%   discrete states, FLAG=3 system outputs and FLAG=4 next sample
%   time. For more information and other options see SFUNC.
%
%   Calling CHP12SM5 with a FLAG of zero:
%   [SIZES]=CHP12SM5([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[54,58,902,751])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '25')
set_param(sys,'Min step size', '0.001')
set_param(sys,'Max step size', '.1')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Transfer Fcn',[sys,'/','Inertia & load 2'])
set_param([sys,'/','Inertia & load 2'],...
        'Denominator','[8  0.9]',...
        'position',[645,402,725,448])

add_block('built-in/Sum',[sys,'/','Sum3'])
set_param([sys,'/','Sum3'],...
        'position',[580,407,600,443])

add_block('built-in/Sum',[sys,'/','Sum4'])
set_param([sys,'/','Sum4'],...
        'inputs','+-',...
        'position',[265,417,285,453])

add_block('built-in/Transfer Fcn',[sys,'/','   Governor 2'])
set_param([sys,'/','   Governor 2'],...
        'Denominator','[0.3   1]',...
        'position',[335,412,400,458])


%     Subsystem  ['Dw1',13,'Dw2 '].

new_system([sys,'/',['Dw1',13,'Dw2 ']])
set_param([sys,'/',['Dw1',13,'Dw2 ']],'Location',[0,59,274,252])

add_block('built-in/S-Function',[sys,'/',['Dw1',13,'Dw2 /S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['Dw1',13,'Dw2 /S-function',13,'M-file which plots',13,'lines',13,'']],...
        'function name','sfuny',...
        'parameters','ax, color,dt',...
        'position',[130,55,180,75])

add_block('built-in/Inport',[sys,'/',['Dw1',13,'Dw2 /x']])
set_param([sys,'/',['Dw1',13,'Dw2 /x']],...
        'position',[65,55,85,75])
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
        'Mask Entries','25\/-.015\/0.015\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block ['Dw1',13,'Dw2 '].

set_param([sys,'/',['Dw1',13,'Dw2 ']],...
        'orientation',1,...
        'position',[770,505,800,545])

add_block('built-in/Mux',[sys,'/','Mux'])
set_param([sys,'/','Mux'],...
        'orientation',1,...
        'inputs','2',...
        'position',[767,445,798,480])

add_block('built-in/Mux',[sys,'/','Mux1'])
set_param([sys,'/','Mux1'],...
        'orientation',1,...
        'inputs','3',...
        'position',[855,445,895,485])

add_block('built-in/Clock',[sys,'/','Clock'])
set_param([sys,'/','Clock'],...
        'orientation',1,...
        'position',[850,350,870,370])

add_block('built-in/Transfer Fcn',[sys,'/','Turbine 2'])
set_param([sys,'/','Turbine 2'],...
        'Denominator','[0.6  1]',...
        'position',[460,413,530,457])

add_block('built-in/To Workspace',[sys,'/',['t  ',13,'Dw1',13,'Dw2']])
set_param([sys,'/',['t  ',13,'Dw1',13,'Dw2']],...
        'orientation',1,...
        'mat-name','Dw',...
        'position',[850,500,900,545])

add_block('built-in/Gain',[sys,'/','Gain'])
set_param([sys,'/','Gain'],...
        'orientation',2,...
        'Gain','2',...
        'position',[580,331,620,369])

add_block('built-in/Gain',[sys,'/',['1//R2',13,'']])
set_param([sys,'/',['1//R2',13,'']],...
        'orientation',2,...
        'Gain','16',...
        'position',[495,492,550,538])

add_block('built-in/Gain',[sys,'/','1//R1'])
set_param([sys,'/','1//R1'],...
        'orientation',2,...
        'Gain','20',...
        'position',[485,112,530,158])

add_block('built-in/Transfer Fcn',[sys,'/',' Turbine 1'])
set_param([sys,'/',' Turbine 1'],...
        'Denominator','[0.5  1]',...
        'position',[455,208,525,252])

add_block('built-in/Transfer Fcn',[sys,'/',' Governor 1'])
set_param([sys,'/',' Governor 1'],...
        'Denominator','[0.2   1]',...
        'position',[335,207,400,253])

add_block('built-in/Sum',[sys,'/','Sum1'])
set_param([sys,'/','Sum1'],...
        'inputs','-+',...
        'position',[255,212,275,248])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
        'inputs','-+-',...
        'position',[570,212,590,248])

add_block('built-in/Transfer Fcn',[sys,'/',['Inertia & load 1',13,'']])
set_param([sys,'/',['Inertia & load 1',13,'']],...
        'Denominator','[10  0.6]',...
        'position',[645,207,725,253])

add_block('built-in/Step Fcn',[sys,'/',['DPL',13,'']])
set_param([sys,'/',['DPL',13,'']],...
        'orientation',1,...
        'Time','100',...
        'Before','0.1875',...
        'After','.1875',...
        'position',[545,175,565,195])

add_block('built-in/Mux',[sys,'/','Mux2'])
set_param([sys,'/','Mux2'],...
        'orientation',2,...
        'position',[370,282,410,328])

add_block('built-in/Clock',[sys,'/','Clock1'])
set_param([sys,'/','Clock1'],...
        'orientation',2,...
        'position',[460,280,480,300])

add_block('built-in/To Workspace',[sys,'/','t, Pm1, Pm2, P12'])
set_param([sys,'/','t, Pm1, Pm2, P12'],...
        'orientation',2,...
        'mat-name','DP',...
        'position',[230,295,320,315])

add_block('built-in/Sum',[sys,'/','ACE1'])
set_param([sys,'/','ACE1'],...
        'inputs','--',...
        'position',[50,230,70,250])

add_block('built-in/Sum',[sys,'/','ACE2'])
set_param([sys,'/','ACE2'],...
        'inputs','+-',...
        'position',[50,415,70,435])

add_block('built-in/Gain',[sys,'/','B1=1//R1+D1'])
set_param([sys,'/','B1=1//R1+D1'],...
        'orientation',2,...
        'Gain','20.6',...
        'position',[385,48,450,102])

add_block('built-in/Gain',[sys,'/','B2=1//R2+D2'])
set_param([sys,'/','B2=1//R2+D2'],...
        'orientation',2,...
        'Gain','16.9',...
        'position',[440,541,495,589])

add_block('built-in/Integrator',[sys,'/','Integrator2'])
set_param([sys,'/','Integrator2'],...
        'position',[130,407,165,443])

add_block('built-in/Integrator',[sys,'/','Integrator1'])
set_param([sys,'/','Integrator1'],...
        'position',[130,223,160,257])

add_block('built-in/Gain',[sys,'/','KI2 '])
set_param([sys,'/','KI2 '],...
        'Gain','.3',...
        'position',[190,408,230,442])

add_block('built-in/Gain',[sys,'/','KI1'])
set_param([sys,'/','KI1'],...
        'Gain','.3',...
        'position',[190,223,220,257])

add_block('built-in/Integrator',[sys,'/','Integrator'])
set_param([sys,'/','Integrator'],...
        'orientation',2,...
        'position',[650,333,680,367])

add_block('built-in/Sum',[sys,'/','Sum2'])
set_param([sys,'/','Sum2'],...
        'orientation',2,...
        'inputs','+-',...
        'position',[710,334,730,361])
add_line(sys,[405,230;450,230])
add_line(sys,[530,230;565,230])
add_line(sys,[595,230;640,230])
add_line(sys,[280,230;330,230])
add_line(sys,[730,230;755,230;755,135;535,135])
add_line(sys,[555,200;565,220])
add_line(sys,[480,135;220,135;220,220;250,220])
add_line(sys,[705,350;685,350])
add_line(sys,[645,350;625,350])
add_line(sys,[605,425;640,425])
add_line(sys,[405,435;455,435])
add_line(sys,[290,435;330,435])
add_line(sys,[535,435;575,435])
add_line(sys,[490,515;235,515;235,445;260,445])
add_line(sys,[730,425;755,425;755,515;555,515])
add_line(sys,[365,305;325,305])
add_line(sys,[455,290;415,290])
add_line(sys,[730,425;755,425;755,355;735,355])
add_line(sys,[730,230;755,230;755,340;735,340])
add_line(sys,[785,485;785,500])
add_line(sys,[875,490;875,495])
add_line(sys,[730,425;890,425;890,440])
add_line(sys,[860,375;860,440])
add_line(sys,[730,230;775,230;775,440])
add_line(sys,[730,425;790,425;790,440])
add_line(sys,[730,230;775,230;775,402;875,402;875,440])
add_line(sys,[575,350;555,350;565,240])
add_line(sys,[575,350;555,350;555,415;575,415])
add_line(sys,[405,435;435,435;435,310;415,310])
add_line(sys,[405,230;435,230;435,300;415,300])
add_line(sys,[225,240;250,240])
add_line(sys,[165,240;185,240])
add_line(sys,[75,240;125,240])
add_line(sys,[555,350;20,350;20,245;45,245])
add_line(sys,[170,425;185,425])
add_line(sys,[75,425;125,425])
add_line(sys,[235,425;260,425])
add_line(sys,[380,75;20,75;20,235;45,235])
add_line(sys,[755,140;755,75;455,75])
add_line(sys,[20,350;20,420;45,420])
add_line(sys,[435,565;20,565;20,430;45,430])
add_line(sys,[755,515;755,565;500,565])
add_line(sys,[425,350;415,320])

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
