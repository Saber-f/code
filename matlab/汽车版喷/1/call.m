clear
global A B fai2 
fai2 = 2.25*(90/342)^0.88;           
E=2.25*(90)^0.88;               %����Ⱥ������
E1 = -90^0.88;                  %����Ⱥ������
E2 = 2.25*342^0.88;             %����Ⱥ������


load A 
load B

LA = length(A);                 %��ȡ����Ⱥ������
LB = length(B);                 %��ȡ����Ⱥ������
L=LA+LB;                        %%��ȡ������Ⱥ������

options = optimoptions('ga','PopulationSize',300,'MaxGenerations',100);%,'MaxStallGenerations',100);
[x,y]=ga(@f1,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
y
