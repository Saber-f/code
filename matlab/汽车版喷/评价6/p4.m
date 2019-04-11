%% 乘客评价司机
global A m n p S st g1 g2
flage1 = true; %A1,A2改变
% flage1 = false; %A1,A2不改变
m = 80;        %司机数
n = 100;        %乘客数
u = 0.5;        %均值
p = 1000;        %人口数
g = 1000000;        %代数
S = zeros(1,g);st = zeros(1,p);
o = sqrt(1.2);  %方差
w = [0.6,0.8];  %w范围


w1 = rand(m,1)*(w(2)-w(1))+w(1); %期望
w2 = rand(n,1)*(w(2)-w(1))+w(1); %期望

if flage1
    A1_ = getA(m,n,u,o);
    A2_ = getA(n,m,u,o);
end

A1 = A1_;
At = A1 - w1;
A1(At>0) = At(At>0).^0.88;
A1(At<0) = -2.25*abs(At(At<0)).^0.88;


A2 = A2_;
At = A2 - w2;
A2(At>0) = At(At>0).^0.88;
A2(At<0) = -2.25*abs(At(At<0)).^0.88;

A2 = A2';

Y = [];X = [];SS = [];
for k = 0:1:1
    g1 = 1;g2 = 1;
    A = k*A1 + (1-k)*A2;
    options = optimoptions('ga','PopulationSize',p,'MaxGenerations',g,'MaxStallGenerations',g);
    [x,y] = ga(@f2,m,[],[],[],[],[],[],[],options);
    
    %% 解析x
    [~,s] = sort(x);
    x = zeros(1,m);
    y1 = 0;y2 = 0;
    for i = 1:m
        [~,t] = sort(A(s(i),:));
        for j = n:-1:1
            if sum(x == t(j)) == 0
                x(s(i)) = t(j);
                y1 = y1 + A1(s(i),t(j));
                y2 = y2 + A2(s(i),t(j));
                break
            end
        end
    end
    X = [X;x];
    Y = [Y;[y1,y2]];
    SS = [SS;-S];
end
plot(SS');