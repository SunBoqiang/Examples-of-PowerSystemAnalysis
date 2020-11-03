disp('(a)')
R1 = 0.05; R2 = 0.0625;
D1 = 0.6; D2 = 0.9;
DPL1 = 187.5/1000;
Dw = -DPL1/(1/R1 + D1+ 1/R2+D2)
Df = Dw*60, f = 60+Df
DPm1 = -Dw/R1
DPm2 = -Dw/R2
DP12 = Dw*(1/R2 + D2)
disp('(b) Open sim12ex4.mdl in SIMULINK WINDOW and click on simulation')
