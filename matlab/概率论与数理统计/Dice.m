clear
m = 1; %有几颗骰子
n = 6; %每颗骰子的最大点数
D = ones(1,m); %m颗骰子排成一排
R  = zeros(1,m*n-m+1); %结果
i = 1;
b = false;
while true
    t = sum(D) - m + 1; %骰子的点数->角标
    R(t) = R(t) + 1;
    while D(i) + 1 > n %进位
        if i == m
            b = true;
            break;
        end
        D(i) = 1;
        i = i + 1; 
    end
    if b
       break; 
    end
    D(i) = D(i) + 1;
    i = 1;
end
R = R/sum(R);
figure
X = m:m*n;
plot(X,R,'x')

%拟合正态分布函数
options = optimset('MaxFunEvals',6000);
fun = @(c,x)exp(-(x-(m*n+m)/2).^2/2/c^2)/(2*pi)^0.5/c;
c0 = 1;
c = lsqcurvefit(fun,c0,X,R,[],[],options)
hold on;
x = min(X):0.1:max(X);
plot(x,fun(c,x));

clear ans b i t D x X options c0