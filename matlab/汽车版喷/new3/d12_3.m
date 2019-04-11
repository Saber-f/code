clear
global PD car L o fai2 N M
l = 0.1;
E1 = -120^0.88;
E2 = 2.25*360^0.88;
o = l*E2;
fai2 = -o/120^0.88+2.25;

PD = importdata('排污矩阵.txt');
load car
L = length(car);

%% 限定排污量，求最高效率
ans12 = zeros(10,2);
ans12_3 = zeros(10,3);

options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);

N = 10;
while true
    [~,y,~,~,po] = ga(@f12,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);    
    % 筛选初始种群
    init_p = get_p(po,N);
    if ~isempty(init_p)
        M = y;
        options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100,'InitialPopulationMatrix',init_p);
        [x,y] = ga(@f123,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
        ans12_3(1,1) = N;ans12_3(1,2) = M; ans12_3(1,3) = y;
        x12_3(1,:) = x;
        break
    end
end

for i = 2:10
    N = 8 + 2*i;
    options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100,'InitialPopulationMatrix',init_p);
    [~,y,~,~,po] = ga(@f12,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    % 筛选初始种群
    init_p = get_p(po,N);
    M = y;
    options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100,'InitialPopulationMatrix',init_p);
    [x,y] = ga(@f123,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    ans12_3(i,1) = N;ans12_3(i,2) = M; ans12_3(i,3) = y;
    x12_3(i,:) = x;
end

plot3(ans12_3(:,1),ans12_3(:,2),ans12_3(:,3),'-*');grid on
xlabel('污染排放量')
ylabel('钣喷完成时间')
zlabel('不满意度')
save('ans12_3.mat','ans12_3','x12_3')