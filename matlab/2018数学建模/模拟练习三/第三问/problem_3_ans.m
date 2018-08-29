global G path T p
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
path = path(z,:);dist = dist(z);nn = 25;
u = {[],[],[]};
for i = 1:nn
    if path(i,2) == 3
        u{1} = [u{1},i];
    elseif path(i,2) == 6
        u{2} = [u{2},i];
    else
        u{3} = [u{3},i];
    end 
end
u{1} = 1;u{2} = 5;u{3}=6;
path = path([u{1},u{2},u{3}],:);
dist = dist([u{1},u{2},u{3}]);
options = gaoptimset('PopulationSize',100,'Generations',60,'StallGenLimit',60); % 人口设为100，进化代数设为60
[a,b] = ga(@f,3*6,[],[],[],[],[1;10;20;38.2;20;30;1+length(u{1});30;20;40.15;60;54;1+length(u{1})+length(u{2});10;23;45.3;37.8;37.45],...
    [length(u{1}+1-1e-8);10;20;38.2;20;30;1+length(u{1})+length(u{2})-1e-8;30;20;40.15;60;54;1+length(u{1})+length(u{2})+length(u{3})-1e-8;10;23;45.3;37.8;37.45],[],options);
% [a,b] = ga(@f,3*6,[],[],[],[],[1;10;20;30;20;30;1+length(u{1});10;20;30;20;30;1+length(u{1})+length(u{2});10;20;30;20;30],...
%     [length(u{1}+1-1e-8);20;60;60;60;60;1+length(u{1})+length(u{2})-1e-8;20;60;60;60;60;1+length(u{1})+length(u{2})+length(u{3})-1e-8;20;60;60;60;60],[],options);
-f(a)
fprintf('路径::')
p
fprintf("12:00\t0\t12:00\t12:00\t0\t12:00\t12:00\t0\t12:00\n")
for i = 1:6
    for j = 1:3
        if i < 3
            c = a(i+1 + (j-1)*6);
        elseif i == 3
            c = 30;
        else
            c = a(i + (j-1)*6);
        end
        d = find(p(j,:) == i+1) - 1;
        fprintf('%02d:%-6.2f\t%-6.2f\t%02d:%-6.2f\t',...
            floor(T(j,2*d-1)/60+12),mod(T(j,2*d-1),60),...
            mod(c,60),...
            floor(T(j,2*d)/60+12),mod(T(j,2*d),60))
    end
    fprintf('\n');
end
for j = 1:3
        fprintf('%02d:%-5.2f\t%-5.2f\t%02d:%-5.2f\t',...
            floor(T(j,end)/60+12),mod(T(j,end),60),...
            30 + (300 - T(j,end)),...
            17,30)
end
fprintf("\n%5.2f\t%5.2f\t%5.2f\n",...
    dist(floor(a(1))),dist(floor(a(7))),dist(floor(a(13))));
fprintf("%5.2f\t%5.2f\t%5.2f\n",...
    sum(a(2:6))+(360-T(1,end)),sum(a(8:12))+(360-T(2,end)),sum(a(14:18))+(360-T(3,end)));
fprintf("%5.2f\t%5.2f\t%5.2f\n",...
    330 - sum(a(2:6))-(360-T(1,end)) - dist(floor(a(1))),330 - sum(a(8:12))-(360-T(2,end)) - dist(floor(a(7))),330 - sum(a(14:18))-(360-T(3,end)) - dist(floor(a(13))));