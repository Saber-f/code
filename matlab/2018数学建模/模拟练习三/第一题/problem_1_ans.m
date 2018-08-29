G = [
    0	300	360	210	590	475	500	690
    300	0	380	270	230	285	200	390
    360	380	0	510	230	765	580	770
    210	270	510	0	470	265	450	640
    590	230	230	470	0	515	260	450
    475	285	765	265	515	0	460	650
    500	200	580	450	260	460	0	190
    690	390	760	640	450	650	190	0
    ]; % 邻接矩阵
n = factorial(6); % 所有可能的走法种类
path = [ones(n,1),perms(2:7),ones(n,1)*8]; % 所有可能的走法
dist = zeros(1,n); % 每种走法的距离
for i = 1:n % 计算每种走法的总路程
    for j = 1:7
        dist(i) = dist(i) + G(path(i,j),path(i,j+1));
    end
end
[~,m] = min(dist); % 最短路径为第m中走法
fprintf("最少步数为::%d\n路径为::",dist(m));
for i = 1:8
    fprintf('%d',path(m,i))
    if i < 8
        fprintf(" -> ")
    else
        fprintf("\n")
    end
end

[~,a] = sort(dist);
path(a(1:10),:)
