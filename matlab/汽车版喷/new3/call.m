global PD car L o fai2
l = 0.1;
E1 = -120^0.88;
E2 = 2.25*360^0.88;
o = l*E2;
fai2 = -o/120^0.88+2.25;

PD = importdata('≈≈Œ€æÿ’Û.txt');
load car
L = length(car);

options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);%,'MaxStallGenerations',100);
[x,y] = ga(@f1,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);

