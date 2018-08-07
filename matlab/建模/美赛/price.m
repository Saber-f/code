clear
load W
[~,~,REPLACE] = xlsread('data\replace.xlsx');
[~,~,R_C_P] = xlsread('data\price.xlsx');
A = [];
for i = 1:length(R_C_P)
    J = false;
    for j = 1:length(REPLACE)
        if strcmp(R_C_P(i,1),REPLACE(j,1))
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
    B = W(:,i,A(1)) .* W(:,i,A(2)) ./ W(:,i,A(3));
    hold on
    plot(1960:2009,B)
    xlabel('year')
    ylabel('Thousand dollars/Billion Btu')
end
title('Energy Price')
legend(S);