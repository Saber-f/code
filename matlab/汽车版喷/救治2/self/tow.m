%������ͼ
clear
global pnum ggY iy ipn D C W
load('data.mat')

pnum = 1000; %�˿���
ggY = [];
iy = inf;
ipn = 0;
daishu = 100;


D = d; C = c; W = w;
n = size(D,1) + size(C,1) - 1;

options = optimoptions('ga','PopulationSize',pnum,'MaxGenerations',daishu,'MaxStallGenerations',daishu);
[x,y] = ga(@f1,n,[],[],[],[],zeros(1,n),ones(1,n),[],options);

g1 = ggY;

%% 
ggY = [];
iy = inf;
ipn = 0;

D = d; C = c; W = w;
n = size(D,1) + size(C,1) - 1;

options = optimoptions('ga','PopulationSize',pnum,'MaxGenerations',daishu,'MaxStallGenerations',daishu);
[x,y] = ga(@f2,n,[],[],[],[],zeros(1,n),ones(1,n),[],options);

g2 = ggY;


plot([g1'*(g2(1)/g1(1)),g2'])
title('����ͼ')
xlabel('����')