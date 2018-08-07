clear
[DATA1,DATA2,~] = xlsread('\data\data.xlsx');
[~,~,REPLACE] = xlsread('\data\replace.xlsx');
[~,~,REPLACE2] = xlsread('\data\replace2.xlsx');
for i = 1 : length(DATA2)
    J = 0;
    for j = 1:length(REPLACE)
       if strcmp(DATA2(i,1),REPLACE(j,1))
          DATA2(i,1) = REPLACE(j,2);
          J = 1;
          break
       end
    end
    if J == 0
        fprintf('i = %d , j = %d \n',i,j)
        error('error1')
    end
    J = 0;
    for j = 1:length(REPLACE2)
       if strcmp(DATA2(i,2),REPLACE2(j,1))
          DATA2(i,2) = REPLACE2(j,2); 
          J = 1;
          break;
       end
    end
    if J == 0
        fprintf('i = %d , j = %d \n',i,j)
       error('error2') 
    end
end
D = [cell2mat(DATA2),DATA1];