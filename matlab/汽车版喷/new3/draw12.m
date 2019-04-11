clear
global PD car L o fai2 N
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

options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);

N = 10;
while true
    [x,y,~,~,po] = ga(@f12,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    ans12(1,1) = N;ans12(1,2) = y;
    
    % 筛选初始种群
    init_p = get_p(po,N);
    if ~isempty(init_p)
        x12(1,:) = x;
        break
    end
end

for i = 2:10
    N = 8 + 2*i;
    options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100,'InitialPopulationMatrix',init_p);
    [x,y,~,~,po] = ga(@f12,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    % 筛选初始种群
    init_p = get_p(po,N);
    ans12(i,1) = N;ans12(i,2) = y;
    x12(i,:) = x;
end

plot(ans12(:,1),ans12(:,2));
xlabel('污染排放量')
ylabel('钣喷完成时间')
save('ans12.mat','ans12','x12')