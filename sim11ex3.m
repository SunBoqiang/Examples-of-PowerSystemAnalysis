function [ret,x0,str,ts,xts]=sim11ex3(t,x,u,flag);
%SIM11EX3   is the M-file description of the SIMULINK system named SIM11EX3.
%     The block-diagram can be displayed by typing: SIM11EX3.
%
%     SYS=SIM11EX3(T,X,U,FLAG) returns depending on FLAG certain
%     system values given time point, T, current state vector, X,
%     and input vector, U.
%     FLAG is used to indicate the type of output to be returned in SYS.
%
%     Setting FLAG=1 causes SIM11EX3 to return state derivatives, FLAG=2
%     discrete states, FLAG=3 system outputs and FLAG=4 next sample
%     time. For more information and other options see SFUNC.
%
%     Calling SIM11EX3 with a FLAG of zero:
%     [SIZES]=SIM11EX3([],[],[],0),  returns a vector, SIZES, which
%     contains the sizes of the state vector and other parameters.
%           SIZES(1) number of states
%           SIZES(2) number of discrete states
%           SIZES(3) number of outputs
%           SIZES(4) number of inputs
%           SIZES(5) number of roots (currently unsupported)
%           SIZES(6) direct feedthrough flag
%           SIZES(7) number of sample times
%
%     For the definition of other parameters in SIZES, see SFUNC.
%     See also, TRIM, LINMOD, LINSIM, EULER, RK23, RK45, ADAMS, GEAR.

% Note: This M-file is only used for saving graphical information;
%       after the model is loaded into memory an internal model
%       representation is used.

% the system will take on the name of this mfile:
sys = mfilename;
new_system(sys)
simver(1.3)
if (0 == (nargin + nargout))
     set_param(sys,'Location',[176,279,914,693])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '3')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '.0250')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/State-Space',[sys,'/','State-Space'])
set_param([sys,'/','State-Space'],...
            'A','[0    1;  -37.7061   -2.6169 ]',...
            'B','[0;   1]',...
            'C','eye(2)',...
            'D','zeros(2, 1)',...
            'position',[155,144,255,206])

add_block('built-in/Demux',[sys,'/','Demux'])
set_param([sys,'/','Demux'],...
            'outputs','2',...
            'position',[290,149,350,196])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
            'position',[540,39,560,161])

add_block('built-in/Note',[sys,'/','Example 11.3   Step response   Du = pi*60//H*(0.2)'])
set_param([sys,'/','Example 11.3   Step response   Du = pi*60//H*(0.2)'],...
            'position',[370,315,380,346])

add_block('built-in/Step Fcn',[sys,'/','Step Input'])
set_param([sys,'/','Step Input'],...
            'Time','100',...
            'Before','pi*60/9.94*.2',...
            'After','pi*60/9.84*.2',...
            'position',[55,143,100,207])

add_block('built-in/Note',[sys,'/','Du=3.79'])
set_param([sys,'/','Du=3.79'],...
            'position',[75,110,80,115])

add_block('built-in/Gain',[sys,'/','rps to Hz'])
set_param([sys,'/','rps to Hz'],...
            'Gain','1/(2*pi)',...
            'position',[400,196,470,264])

add_block('built-in/Sum',[sys,'/','Sum1'])
set_param([sys,'/','Sum1'],...
            'position',[540,204,560,311])

add_block('built-in/Gain',[sys,'/',['Rad to Degree',13,'',13,'']])
set_param([sys,'/',['Rad to Degree',13,'',13,'']],...
            'Gain','180/pi',...
            'position',[405,96,475,164])

add_block('built-in/Constant',[sys,'/','delta0'])
set_param([sys,'/','delta0'],...
            'Value','16.79',...
            'position',[460,57,510,83])


%     Subsystem  'delta'.

new_system([sys,'/','delta'])
set_param([sys,'/','delta'],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/','delta/x'])
set_param([sys,'/','delta/x'],...
            'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['delta/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['delta/S-function',13,'M-file which plots',13,'lines',13,'']],...
            'function name','sfuny',...
            'parameters','ax, color,dt',...
            'position',[130,55,180,75])
add_line([sys,'/','delta'],[90,65;125,65])
set_param([sys,'/','delta'],...
            'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
            'Mask Type','Graph scope.')
set_param([sys,'/','delta'],...
            'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/','delta'],...
            'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/','delta'],...
            'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/','delta'],...
            'Mask Entries','3\/15\/30\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block 'delta'.

set_param([sys,'/','delta'],...
            'position',[590,72,645,128])

add_block('built-in/Constant',[sys,'/','f0'])
set_param([sys,'/','f0'],...
            'Value','60',...
            'position',[485,271,520,299])


%     Subsystem  ['f',13,''].

new_system([sys,'/',['f',13,'']])
set_param([sys,'/',['f',13,'']],'Location',[0,59,274,252])

add_block('built-in/Inport',[sys,'/',['f',13,'/x']])
set_param([sys,'/',['f',13,'/x']],...
            'position',[65,55,85,75])

add_block('built-in/S-Function',[sys,'/',['f',13,'/S-function',13,'M-file which plots',13,'lines',13,'']])
set_param([sys,'/',['f',13,'/S-function',13,'M-file which plots',13,'lines',13,'']],...
            'function name','sfuny',...
            'parameters','ax, color,dt',...
            'position',[130,55,180,75])
add_line([sys,'/',['f',13,'']],[90,65;125,65])
set_param([sys,'/',['f',13,'']],...
            'Mask Display','plot(0,0,100,100,[90,10,10,10,90,90,10],[65,65,90,40,40,90,90],[90,78,69,54,40,31,25,10],[77,60,48,46,56,75,81,84])',...
            'Mask Type','Graph scope.')
set_param([sys,'/',['f',13,'']],...
            'Mask Dialogue','Graph scope using MATLAB graph window.\nEnter plotting ranges and line type.|Time range:|y-min:|y-max:|Line type (rgbw-:*). Seperate each plot by ''/'':')
set_param([sys,'/',['f',13,'']],...
            'Mask Translate','color = @4; ax = [0, @1, @2, @3]; dt = -1;')
set_param([sys,'/',['f',13,'']],...
            'Mask Help','This block plots to the MATLAB graph window and can be used as an improved version of the Scope block. Look at the m-file sfuny.m to see how it works. This block can take scalar or vector input signal.')
set_param([sys,'/',['f',13,'']],...
            'Mask Entries','3\/59.95\/60.1\/''y-/g--/c-./w:/m*/ro/b+''\/')


%     Finished composite block ['f',13,''].

set_param([sys,'/',['f',13,'']],...
            'position',[590,232,645,288])
add_line(sys,[105,175;150,175])
add_line(sys,[260,175;285,175])
add_line(sys,[565,260;585,260])
add_line(sys,[355,160;375,160;375,130;400,130])
add_line(sys,[480,130;535,130])
add_line(sys,[565,100;585,100])
add_line(sys,[355,185;375,185;375,230;395,230])
add_line(sys,[515,70;535,70])
add_line(sys,[475,230;535,230])
add_line(sys,[525,285;535,285])

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
