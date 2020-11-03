S_2w = 60;
V1 = 240; V2 = 1200;
I1= S_2w*10^3/V1; I2 = S_2w*10^3/V2;
IL = I1 + I2;
S_auto = V2*IL*10^-3
Ploss = S_2w*0.8*(1 - 0.96)/0.96
Eff = S_auto*.8/(S_auto*0.8 + Ploss)
