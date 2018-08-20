%最终处理方法
load cq
N = 100; %将存取款区间分为N个小区间统计次数

C = [];
for n = 1:30
    %n = 1; %第一个省
    a = cq(:,2*n-1) - cq(:,2*n);
    [b x] = hist(a,N);
    y=cumsum(b/numel(a));        %累积分布
    
%     fun = @(c,x)tcdf(c(1)*x+c(2),c(3));
%     c0 = [0.03,-0.003,2];

    fun = @(c,x)normcdf(x,c(1),c(2));
    c0 = [0,30];
    [c, d] = lsqcurvefit(fun,c0,x,y);
    
%     figure
%     plot(x,y,'*')
%     x_ = min(x):(max(x)-min(x))/1000:max(x);
%     hold on
%     plot(x_,fun(c,x_));
    
    C = [C;[c,d/N]];
end

clear a b ans n N cq x y fun c c0 d
