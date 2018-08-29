global G path
G = [
    0	300	360	210	590	475	500	690
    300	0	380	270	230	285	200	390
    360	380	0	510	230	765	580	770
    210	270	510	0	470	265	450	640
    590	230	230	470	0	515	260	450
    475	285	765	265	515	0	460	650
    500	200	580	450	260	460	0	190
    690	390	760	640	450	650	190	0
    ]/(100/3); % 邻接矩阵(行走时间)

n = factorial(6); % 所有可能的走法种类
path = [ones(n,1),perms(2:7),ones(n,1)*8]; % 所有可能的走法

c = [];
for i = 1:720
    if path(i,2) == 4
        c = [c,i];
    end
end
path(c,:) = [];
dist = zeros(1,size(path,1)); % 每种走法的距离
for i = 1:size(path,1) % 计算每种走法的总时间
    for j = 1:7
        dist(i) = dist(i) + G(path(i,j),path(i,j+1));
    end
end
[~,z] = sort(dist);
path = path(z,:);dist = dist(z);
options = gaoptimset('PopulationSize',100,'Generations',60,'StallGenLimit',60); % 人口设，进化代数设
[a,b] = ga(@f,6,[],[],[],[],[1;10;20;30;20;30],[10;30;60;60;60;60],[],options);

n = floor(a(1));p = path(n,:); % 选择路径
fprintf("最长游览时间::%f\n",-b);
fprintf("行走时间为::%f\n",dist(n));
fprintf("总用时::%fmin\n路径::",dist(n)-b);
for i = 1:8
    fprintf('%d',p(i))
    if i < 8
        fprintf(" -> ")
    else
        fprintf("\n")
    end
end
label = {'景石','游客服务中心','阳光草坪','森林小剧场','儿童科普体验区','儿童戏水场','湿地博物馆','湿地商业街'};
t = 12 * 60; % 当前时间
for i = 1:7
    fprintf(['从',label{p(i)},'出发时间 %02d:%02d:%.2f            '],floor(t/60),floor(mod(t,60)),60*mod(t,1))
    t = t + G(p(i),p(i+1));
    fprintf(['到达',label{p(i+1)},'的时间 %02d:%02d:%.2f\n'],floor(t/60),floor(mod(t,60)),60*mod(t,1))
    if p(i+1) == 4 %如果到了深林小剧场
        if mod(t,30) > 1e-4
            t = t + (30-mod(t,30));
        end
        t = t + 30;
    elseif p(i+1) < 4
        t = t + a(p(i+1));
    elseif p(i+1) < 8
        t = t + a(p(i+1)-1);
    end
end