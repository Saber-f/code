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

%% 限完成时间，求最低不满意度
ans23 = zeros(10,2);
options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);
for i = 1:10
    N = 1100 + 100*i;
    [x,y] = ga(@f23,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    if y > 1000000
        y = NaN;
    end
    ans23(i,1) = N;ans23(i,2) = y;
end

%%规范化
for i = 2:10
    ans23(i,2) = min([ans23(i-1,2),ans23(i,2)]);
end
plot(ans23(:,1),ans23(:,2));
xlabel('完成时间')
ylabel('不满意度')
save('ans23','ans23')