clear
global A B fai2 
fai2 = 2.25*(90/342)^0.88;           
E=2.25*(90)^0.88;               %重伤群众上限
E1 = -90^0.88;                  %轻伤群众下限
E2 = 2.25*342^0.88;             %轻伤群众上限


load A 
load B

LA = length(A);                 %获取重伤群众人数
LB = length(B);                 %获取轻伤群众人数
L=LA+LB;                        %%获取总受伤群众人数

options = optimoptions('ga','PopulationSize',300,'MaxGenerations',100);%,'MaxStallGenerations',100);
[x,y]=ga(@f1,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
y
