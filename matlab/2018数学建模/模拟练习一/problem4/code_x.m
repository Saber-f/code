%最终处理方法
load cq
N = 100; %将存取款区间分为N个小区间统计次数

XV = [];
for n = 1:1; %第一个省
    a = cq(:,2*n-1) - cq(:,2*n);
    
    % load C
    % a = [];
    % for k = 1:365
    %     a = [a,norminv(rand,C(1,1),C(1,2))];
    % end
    
    [b x]=hist(a,N);
    num=numel(a);
    y=cumsum(b/num);        %累积分布
    XV = [XV;x];
end

clear a num ans n N



