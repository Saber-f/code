% µ¥Ä¿±ê
global D C W pnum
load('data.mat')
D = d; C = c; W = w;
n = size(D,1) + size(C,1) - 1;

options = optimoptions('ga','PopulationSize',pnum,'MaxGenerations',1000);%,'MaxStallGenerations',100);
[x,y] = ga(@f2,n,[],[],[],[],zeros(1,n),ones(1,n),[],options);