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

%% 限定排污量，求最底不满意度
ans13 = zeros(10,2);
options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);

N = 10;
pn = 0;
while true
    [x,y,~,~,po] = ga(@f13,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    ans13(1,1) = N;ans13(1,2) = y;
    
    % 筛选初始种群
    init_p = get_p(po,N);
    if ~isempty(init_p)
        x13(1,:) = x;
        break
    end
    pn = pn + 100;
    options = optimoptions('ga','PopulationSize',600 + pn,'MaxGenerations',100 + pn);
end

for i = 2:10
    N = 8 + 2*i;
    options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100,'InitialPopulationMatrix',[x;init_p]);
    [x,y,~,~,po] = ga(@f13,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    % 筛选初始种群
    init_p = get_p(po,N);
    ans13(i,1) = N;ans13(i,2) = y;
    x13(i,:) = x;
end

plot(ans13(:,1),ans13(:,2));
xlabel('污染排放量')
ylabel('不满意度')
save('ans13.mat','ans13','x13')