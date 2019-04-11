clear
%% �˿�����˾��
global A m n p S st g1 g2
m = 20; %˾����
n = 30; %�˿���
p = 200;        %�˿���
g = 100;        %����
S = zeros(1,g);st = zeros(1,p);
g1 = 1;g2 = 1;

A = getA(m,n,0.5,sqrt(1.2));

w = rand(m,1); %˾������
At = A - w;
A(At>0) = At(At>0).^0.88;
A(At<0) = -2.25*abs(At(At<0)).^0.88;

options = optimoptions('ga','PopulationSize',p,'MaxGenerations',g,'MaxStallGenerations',g);
[x,y] = ga(@f2,m,[],[],[],[],[],[],[],options); %�ڶ��ַ���

%% ����x
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
