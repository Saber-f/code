clear
load W
A  = {'TETCB';'TETXB'};A = replace(A);


figure
hold on
S(1) = {'Arizona'};
S(2) = {'California'};
S(3) = {'New Mexico'};
S(4) = {'Texas'};

for i = 1:4
    D = W(:,i,A(2))./W(:,i,A(1));
    hold on
    plot(1960:2009,D)
    title('end-use/use')
end
legend(S)