%限定感知度求最快完成时间
global D C W T
load('data.mat')
D = d; C = c; W = w;
n = size(D,1) + size(C,1) - 1;


YY = [];
for T = 46500:300:49500
    options = optimoptions('ga','PopulationSize',100,'MaxGenerations',100);%,'MaxStallGenerations',100);
    [x,y] = ga(@f21,n,[],[],[],[],zeros(1,n),ones(1,n),[],options);   
    YY = [YY;[T,y]];
end


plot(YY(:,1),YY(:,2));