global A a n
A = [3000 1500];
a = [373 201];

[~,s] = sort(-A);A = A(s);[~,s] = sort(-a);a = a(s);

n = floor(A(1) * A(2) / (a(1) * a(2)));

options = optimoptions('ga','PopulationSize',900,'MaxGenerations',200);%,'MaxStallGenerations',100);
[x,y] = ga(@f,n,[],[],[],[],ones(n,1),ones(n,1)*(5)-0.00001,[],options)