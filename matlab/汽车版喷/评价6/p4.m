%% �˿�����˾��
global A m n p S st g1 g2
flage1 = true; %A1,A2�ı�
% flage1 = false; %A1,A2���ı�
m = 80;        %˾����
n = 100;        %�˿���
u = 0.5;        %��ֵ
p = 1000;        %�˿���
g = 1000000;        %����
S = zeros(1,g);st = zeros(1,p);
o = sqrt(1.2);  %����
w = [0.6,0.8];  %w��Χ


w1 = rand(m,1)*(w(2)-w(1))+w(1); %����
w2 = rand(n,1)*(w(2)-w(1))+w(1); %����

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
    
    %% ����x
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