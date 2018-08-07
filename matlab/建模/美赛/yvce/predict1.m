clear;load ..\W
y(1:50) = W(:,1,replace({'RETCB'}));
x = 1960:2009;
options = optimset('MaxFunEvals',2000);
fun = @(c,x)c(1)./(1+exp(c(2).*(x+c(3))))+c(4);
c0 = [100000,-0.1,-1960,0];
c = lsqcurvefit(fun,c0,x,y,[],[],options)
figure
plot(x,y);
hold on;
plot(x,fun(c,x));
legend('original','predict')
ylabel('Billion Btu')
xlabel('Year')
title('AZ-RETCB')
box off