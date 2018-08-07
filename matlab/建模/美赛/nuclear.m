clear
load W
[~,~,REPLACE] = xlsread('data\replace.xlsx');
[~,~,R_C] = xlsread('data\nuclear.xlsx');
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
    for j = 1:length(A)
        C = [C;W(:,i,A(j))'];
    end
    hold on
    plot(1960:2009,C)
    xlabel('year')
    ylabel('Billion Btu')
end
title('nuclear energy')
legend(S);

%追加占总能源使用的比

J = false;
for j = 1:length(REPLACE)
    if strcmp('TETCB',REPLACE(j,1))
        B = cell2mat(REPLACE(j,2));
        J = true;
        break;
    end
end
if J == false
    error('error')
end

figure
for i = 1:4
    
    C = W(:,i,A(1))'./W(:,i,B)';
    hold on
    plot(1960:2009,C)
    xlabel('year')
    title('The amount of nuclear energy consumed is the proportion of total energy.')
    legend(S);
end
