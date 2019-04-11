clear
%% 乘客评价司机
global A m n p S st g1 g2
m = 20; %司机数
n = 30; %乘客数
p = 200;        %人口数
g = 100;        %代数
S = zeros(1,g);st = zeros(1,p);
g1 = 1;g2 = 1;

A = getA(m,n,0.5,sqrt(1.2));

w = rand(m,1); %司机期望
At = A - w;
A(At>0) = At(At>0).^0.88;
A(At<0) = -2.25*abs(At(At<0)).^0.88;

options = optimoptions('ga','PopulationSize',p,'MaxGenerations',g,'MaxStallGenerations',g);
[x,y] = ga(@f2,m,[],[],[],[],[],[],[],options); %第二种方法

%% 解析x
[~,s] = sort(x);
x = zeros(1,m);
for i = 1:m
    [~,t] = sort(A(s(i),:));
    for j = n:-1:1
        if sum(x == t(j)) == 0
            x(s(i)) = t(j);
            break
        end
    end
end
plot(S)
