clear
load W
[~,~,REPLACE] = xlsread('data\replace.xlsx');
[~,~,R_C] = xlsread('data\reproducible_clean.xlsx');
A = [];
for i = 1:length(R_C)
    J = false;
    for j = 1:length(REPLACE)
        if strcmp(R_C(i,1),REPLACE(j,1))
            A = cell2mat([A;REPLACE(j,2)]);
            J = true;
            break;
        end
    end
    if J == false
        error('error')
    end
end

S(1) = {'Arizona'};
S(2) = {'California'};
S(3) = {'New Mexico'};
S(4) = {'Texas'};

figure
for i = 1:4
    C = [];
    for j = 2:length(A)
        C = [C;W(:,i,A(j))'];
    end
    C = sum(C);
    hold on
    plot(1960:2009,C)
    xlabel('year')
    ylabel('Billion Btu')
end
title('Clean renewable energy consumption')
legend(S);

figure
for i = 1:4
    B = [];
    C = [];
    B = [C;W(:,i,A(1))'];
    for j = 2:length(A)
        C = [C;W(:,i,A(j))'];
    end
    C = sum(C);
    hold on
    plot(1960:2009,C./B)
    xlabel('year')
end
title('The ratio of clean renewable energy consumption to total energy consumption.')
legend(S);