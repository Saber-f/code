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

%% 限完成时间，求最低排放
ans23 = zeros(10,2);
options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);

N = 1200;
pn = 0;
while true
    [x,y,~,~,po] = ga(@f21,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    ans21(1,1) = N;ans21(1,2) = y;
    
    % 筛选初始种群
    init_p = get_p(po,N);
    if ~isempty(init_p)
        x21(1,:) = x;
        break
    end
    pn = pn + 100
    options = optimoptions('ga','PopulationSize',600 + pn,'MaxGenerations',100 + pn);
end

for i = 2:10
    N = 1100 + 100*i;
    options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100,'InitialPopulationMatrix',init_p);
    [x,y,~,~,po] = ga(@f21,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    % 筛选初始种群
    init_p = get_p(po,N);
    ans21(i,1) = N;ans21(i,2) = y;
    x21(i,:) = x;
end


plot(ans23(:,1),ans23(:,2));
xlabel('完成时间')
ylabel('排放量')
save('ans21.mat','ans21','x21')