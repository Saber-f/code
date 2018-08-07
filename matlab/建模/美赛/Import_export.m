clear
load W
[~,~,REPLACE] = xlsread('data\replace.xlsx');
[~,~,IM_EX] = xlsread('data\Import_export.xlsx');
A = [];
for i = 1:length(IM_EX)
    J = false;
    for j = 1:length(REPLACE)
        if strcmp(IM_EX(i,1),REPLACE(j,1))
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

for i = 1:4
    B = [];
    for j = 1:length(A)
         B = [B;W(:,i,A(j))'];
    end
    subplot(2,2,i)
    for j = 1:3
        hold on
       plot(1960:2009,B(j,:)) 
    end
    title(S(i))
    xlabel('year')
    ylabel('Billion Btu')
    legend('export','import',' net import');
end
