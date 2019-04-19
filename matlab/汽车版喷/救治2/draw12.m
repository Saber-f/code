%限定完成时间求最低感知度
global D C W T
load('data.mat')
D = d; C = c; W = w;
n = size(D,1) + size(C,1) - 1;


YY = [];
for T = 450:2:470
    options = optimoptions('ga','PopulationSize',100,'MaxGenerations',100);%,'MaxStallGenerations',100);
    [x,y] = ga(@f12,n,[],[],[],[],zeros(1,n),ones(1,n),[],options);   
    YY = [YY;[T,y]];
end

plot(YY(:,1),YY(:,2));