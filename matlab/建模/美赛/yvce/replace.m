function Rp = replace(Rp)
[~,~,R] = xlsread('..\data\replace.xlsx');
for j = 1:length(Rp)
    J = true;
    for i = 1:length(R)
        if strcmp(R(i,1),Rp(j))
            Rp(j) = (R(i,2));
            J = false;
            break;
        end
    end
    if J
       error('error1') 
    end
end
Rp = cell2mat(Rp);
end
