%限定完成时间求最低感知度(在不超过时间T)
global D C W Y
load('data.mat')
D = d; C = c; W = w;
n = size(D,1) + size(C,1) - 1;


YY = [];
for Y =400:20:580
    options = optimoptions('ga','PopulationSize',100,'MaxGenerations',100);%,'MaxStallGenerations',100);
    [x,y] = ga(@f12,n,[],[],[],[],zeros(1,n),ones(1,n),[],options);    
    YY = [YY;[Y,y]];
end
 
plot(YY(:,1),YY(:,2)); 
xlabel('完成时间')
ylabel('感知度')