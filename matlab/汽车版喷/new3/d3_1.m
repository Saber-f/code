%% 限定不满意度，最后考虑排污量
clear
global PD car L o fai2 N M Yt
l = 0.1;
E1 = -120^0.88;
E2 = 2.25*360^0.88;
o = l*E2;
fai2 = -o/120^0.88+2.25;

PD = importdata('排污矩阵.txt');
load car
L = length(car);

%% 得到一个局部最优的不满意度
init_y = inf;
for i = 1:1
    options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);
    [x,y,~,~,po_] = ga(@f3,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    if init_y > y
        init_y = y;po = po_;
    end
end
d = 250;    %步长500
num = 10;   %循环次数

init_p = [x;get_p(po,y)];
for i = 1:num
    N = init_y + (i-1)*d;
    options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100,'InitialPopulationMatrix',init_p);
    [x,y,~,~,po] = ga(@f32,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    
    M = y;
    init_p = [x;get_p(po,y)];
    options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100,'InitialPopulationMatrix',init_p);
    [x,y,~,~,po] = ga(@f321,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    f321(x);
    X(i,:) = x;
    Y(i,:) = Yt;
end
save('ans321.mat','X','Y');
plot3(Y(:,1),Y(:,2),Y(:,3),'-*');grid on;