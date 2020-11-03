t=0:.005:3;
c = 1+ exp(-2*t).*sin(8*t - pi/2);
[cp, k] = max(c)   % cp is the maximum value of c at interval k
tp = t(k)                                 % tp is the peak time
plot(t, c), xlabel(' t,  sec'), ylabel('c'), grid
title('Damped sine curve')
text(0.55,1.35,['cp = ',num2str(cp)])%Text in quote & the value 
     % of cp are printed on the graph at the specified location
text(0.55, 1.2,['tp = ',num2str(tp)])

% use of ginputcommand
% [tp, cp] = ginput
