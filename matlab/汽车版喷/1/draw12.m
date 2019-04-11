clear
global A B L fai2 N
fai2 = 2.25*(90/342)^0.88;
E=2.25*(90)^0.88;
E1 = -90^0.88;
E2 = 2.25*342^0.88; 


load A 
load B

LA = length(A);
LB = length(B);
L=LA+LB;

%% 限完成时间，求最低不满意度
ans12 = zeros(10,2);              %10行2列的零矩阵
options = optimoptions('ga','PopulationSize',300,'MaxGenerations',100);

N = 540;                          %完成时间的上界
pn = 0;
while true
    [x,y,~,~,po] = ga(@f12,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    ans12(1,1) = N;ans12(1,2) = y;
    
    % 筛选初始种群
    init_p = get_p(po,N);
    if ~isempty(init_p)  
        x12(1,:) = x;
        break
    end
    pn = pn + 100 
    options = optimoptions('ga','PopulationSize',300 + pn,'MaxGenerations',100 + pn);
end

for i = 2:10
    N = 530 + 5*i
    options = optimoptions('ga','PopulationSize',300,'MaxGenerations',100,'InitialPopulationMatrix',init_p);
    [x,y,~,~,po] = ga(@f12,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    % 筛选初始种群
    init_p = get_p(po,N);
    ans12(i,1) = N;ans12(i,2) = y;
    x12(i,:) = x; 
end

%%规范化
% for i = 2:5
%     ans12(i,2) = min([ans12(i-1,2),ans12(i,2)]);
% end
plot(ans12(:,1),ans12(:,2));
xlabel('完成时间')
ylabel('感知满意度')
save('ans12.mat','ans12','x12')

