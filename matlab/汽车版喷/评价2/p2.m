clear
%% ˾�����۳˿�
global A m n
m = 10; %˾����
n = 15; %�˿���
A = 0.5 + sqrt(1.2).*randn(n,m);

w = rand(n,1); %˾������
At = A - w;
A(At>0) = At(At>0).^0.88;
A(At<0) = -2.25*abs(At(At<0)).^0.88;

options = optimoptions('ga','PopulationSize',5000,'MaxGenerations',1000);
[x,y] = ga(@f2,m,[],[],[],[],[],[],[],options);

%% ����x
[~,s] = sort(x);
x = zeros(1,m);
for i = 1:m
    [~,t] = sort(A(:,s(i)));
    for j = n:-1:1
        if sum(x == t(j)) == 0
            x(s(i)) = t(j);
            break
        end
    end
end