clear;load ..\W
y(1:50) = W(:,1,replace({'TETCB'}));
x = 1960:2009;
fun = @(c,x)c(1)./(1+exp(c(2).*(x+c(3))))+c(4);
options = optimset('MaxFunEvals',2000);
c0 = [1.5e6,-0.1,-1985,2e5];
c = lsqcurvefit(fun,c0,x,y,[],[],options)
figure
plot(x,y);
hold on;
plot(x,fun(c,x));
legend('original','predict')
ylabel('Billion Btu')
xlabel('Year')
title('AZ-TETCB')
box off