clear
load W
[~,~,REPLACE] = xlsread('data\replace.xlsx');
[~,~,R_C] = xlsread('data\total_energy.xlsx');
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
    subplot(2,2,i)
    for j = 1:length(A)
        C = [C;W(:,i,A(j))'];
        plot(1960:2009,C)
    end
    hold on
    xlabel('year')
    ylabel('Billion Btu')
    title(S(i))
    legend('production','consumption');
end

%追加，人均能源消生产消耗


J = false;
for j = 1:length(REPLACE)
    if strcmp('TPOPP',REPLACE(j,1))
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
    C = [];
    subplot(2,2,i)
    for j = 1:length(A)
        C = W(:,i,A(j))';
        C = C./W(:,i,B)';
        hold on
        plot(1960:2009,C)
    end

    xlabel('year')
    ylabel('Billion Btu')
    title(S(i))
    legend('Per capita production','Per capita consumption');
end








