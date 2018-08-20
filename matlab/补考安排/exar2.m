%% 检查数据是否含有科学记数法表示的数
tic;clear;clc;
NUMC = 8;
%NUM3 = [71001,71004,151010,171002];                                        %NUM3为不能同堂考多门的科目编号
NUM3 = [];
fileID = fopen('input_datagj.txt','r');
s = fscanf(fileID,"%s");
fclose(fileID);
for i = 1:length(s)
   if s(i) == 'E' || s(i) == 'e'
      error('数据含有科学记数法，请处理后再运行！'); 
   end
end


%% 载入，查重
RC = int64(load('input_datagj.txt')); %C为原始数据

%查重
l1 = length(RC);l2 = [];n3 = 0;                                            %l2为重复位置记录,n3重复次数
tRC = table(RC(:,1),RC(:,2));
[~,t] = unique(tRC);
if length(t) < l1                                                          %如果有重复项
   t2 = sort(t);
   RC = RC(t2,:);
   for i = 1:l1
      if i ~= t2(i-n3)
         n3 = n3 + 1;
         l2 = [l2,i];
      end
   end
   fprintf("以下%d处数据重复(已去重)\n",n3);
   for i = 1:n3
      fprintf("%d  ",l2(i)); 
   end
   fprintf("\n");
end

CN = zeros(length(RC),2);                                                  %CN为编号数据  



%% 编序号
[cn1,cn2] = sort(RC(:,1));
[cn3,cn4] = sort(RC(:,2));
CN(cn2(1),1) = 1;CN(cn4(1),2) = 1;t5 = 1;t6 = 1;
for i = 2:length(RC)
   if cn1(i) ~= cn1(i-1)
      t5 = t5 + 1; 
   end
   if cn3(i) ~= cn3(i-1)
      t6 = t6 + 1; 
   end
   CN(cn2(i),1) = t5;
   CN(cn4(i),2) = t6;
end



%% 生成科目编号x学号矩阵
BX1 = zeros(max(CN(:,2)),max(CN(:,1)));num2 = 0;                           %num2为不可同堂人次
for i = 1:length(CN)
    BX1(CN(i,2),CN(i,1)) = 1;
end

for i = 1:length(NUM3)
   for j = 1:length(RC)
      if RC(j,2) == NUM3(i)  
         BX1(CN(j,2),CN(j,1)) = 2;
         num2 = num2 + 1;
      end
   end
end

%% 将科目按挂科人数降序排列得到BX2
[~,s1] = sort(sum(BX1,2));
[~,s2] = sort(s1);
BX2 = BX1(s1,:);
BX1 = BX2;



%% 遍历
result = zeros(1,length(s2));mark = 0;record2 = zeros(1,NUMC);numpeop = inf; %numpeop为冲突人数
record = zeros(length(s2)+1,length(BX2),NUMC);                               %record记录每次的冲突情况
respeop = zeros(NUMC,length(BX2));sus1 = 0;sus2 = 0;                         %与冲突人数有关
while(1)
    [result,sum(record2),mark]    
    if result(mark + 1) >= NUMC
        while(result(mark) >= NUMC)
            record2(result(mark + 1)) = record2(result(mark+1)) - 1;
            result(mark + 1) = 0;
            mark = mark - 1;
        end
        result(mark + 1) = 0;
        record2(result(mark)) = record2(result(mark)) - 1;
        result(mark) = result(mark) + 1;
    else
        mark = mark + 1;
        result(mark) = result(mark) + 1;
    end
    record2(result(mark)) = record2(result(mark)) + 1; 
    record(record2(result(mark))+1,:,result(mark)) = record(record2(result(mark)),:,result(mark)) + BX2(mark,:); 

    %计算判断冲突人数
    for i = 1 : NUMC
        respeop(i,:) = record(record2(i)+1,:,i);
    end
    numpeop2 = sum(sum(respeop,2) - sum(~(~respeop),2)) - num2;
    
    if max(record(record2(result(mark))+1,:,result(mark))) > 2 || numpeop2 > 10
        record2(result(mark)) = record2(result(mark)) - 1;
        mark = mark - 1;   
    end
    
    if mark >= length(result)                                              %如果分配完成
        if numpeop > numpeop2
            numpeop = numpeop2;
            result2 = result;
            sus2 = sus2 + 1;
        end
        record2(result(mark)) = record2(result(mark)) - 1;
        mark = mark - 1;
        sus1 = sus1 + 1;
    end
end
numpeop = numpeop - num2;
%% 变量清理
clear cn1 cn2 cn3 cn4 fileID i j l1 l2 n3 s t t5 t6 tRC mark ans