%限定感知度求最快完成时间
global D C W Y
load('data.mat')
D = d; C = c; W = w;
n = size(D,1) + size(C,1) - 1;


YY = [];
for Y = 19000:2000:34000
    options = optimoptions('ga','PopulationSize',100,'MaxGenerations',100);%,'MaxStallGenerations',100);
    [x,y] = ga(@f21,n,[],[],[],[],zeros(1,n),ones(1,n),[],options);   
    YY = [YY;[Y,y]];
end


plot(YY(:,1),YY(:,2));
xlabel('感知度')
ylabel('完成时间')