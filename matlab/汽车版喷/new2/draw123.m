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

%% 限定排污量和完成时间，求最底不满意度
z = zeros(10,10);
options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);
for i = 1:10
    N = 8 + 2*i;
    for j = 1:10
        M = 1100 + 100*i;
        [x,y] = ga(@f123,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
        if y > 1000000
            y = NaN;
        end
        z(i,j) = y;
    end
end

%%规范化
for i = 2:10
    for j = 2:10
        z(i,j) = min([z(i,j),z(i-1,j),z(i,j-1)]);
    end
end

[x,y] = meshgrid(10:2:28,1200:100:2100);
surf(x,y,z)
xlabel('污染排放量');ylabel('完成时间');zlabel('不满意度')

figure
surf(x(4:end,:),y(4:end,:),z(4:end,:))
xlabel('污染排放量');ylabel('完成时间');zlabel('不满意度')
save('ans123.mat','x','y','z')