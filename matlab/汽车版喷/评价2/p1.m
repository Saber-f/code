clear
%% �˿�����˾��
global A m n
m = 10; %˾����
n = 15; %�˿���
A = 0.5 + sqrt(1.2).*randn(m,n);

w = rand(m,1); %˾������
At = A - w;
A(At>0) = At(At>0).^0.88;
A(At<0) = -2.25*abs(At(At<0)).^0.88;

options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);%,'UseParallel',true);
[x,y,out] = ga(@f1,m,[],[],[],[],[],[],[],options);

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
