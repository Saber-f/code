clear;load ..\W
y(1:50) = W(:,2,replace({'NGTCB'}));
x = 1960:2009;
fun = @(c,x)c(1)./(1+exp(c(2).*(x+c(3))))+c(4);
options = optimset('MaxFunEvals',2000);
c0 = [1000000,-0.2,-1980,1.3e6];
c = lsqcurvefit(fun,c0,x,y,[],[],options)
figure
plot(x,y);
hold on;
plot(x,fun(c,x));
legend('original','predict')
ylabel('Billion Btu')
xlabel('Year')
title('CA-NGTCB')
box off