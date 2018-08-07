%% 检查数据是否含有科学记数法表示的数
tic;clear;clc;
global ZNP average_c average_s zy BX1 NUMC CN1 CN2 cn11 cn22;% Y;
NUMC = 9;NUMX = 2011;                             %NUMC为规定堂数，NUMX为校区分界限
NUM3 = [];                                        %NUM3为不能同堂考多门的科目编号
fileID = fopen('data.txt','r');
s = fscanf(fileID,"%s");
fclose(fileID);
for i = 1:length(s)
   if s(i) == 'E' || s(i) == 'e'
      error('数据含有科学记数法，请处理后再运行！'); 
   end
end


%% 载入，查重
RC = int64(load('data.txt')); %C为原始数据

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
CN1 = unique(CN(1:NUMX,1)');
%CN2 = unique(CN(NUMX + 1:end,1)');
j = sort(CN1);
j(length(j)+1) = 0;
k = 1;
t = 1;

CN2 = zeros(1,max(CN(:,1)) - length(j));
for i = 1:max(CN(:,1))
    if(i ~= j(k))
        CN2(t) = i;
        t = t + 1;
    else
        k = k + 1;
    end
end



%% 生成科目编号x学号矩阵
BX1 = zeros(max(CN(:,2)),max(CN(:,1)));
for i = 1:length(CN)
    BX1(CN(i,2),CN(i,1)) = 1;
end

num2 = length(NUM3);                           %num2为不可同堂人次
for i = 1:num2
   for j = 1:length(RC)
      if RC(j,2) == NUM3(i)  
         BX1(CN(j,2),CN(j,1)) = 2;
      end
   end
end


%% 遗传算法求最优解
average_c = NUMX/NUMC;
average_s = (length(RC) - NUMX)/NUMC;
zb = inf;
zy = inf;
for i = 1:10
    Y = [];
    options = gaoptimset('PopulationSize',300,'Generations',60,'StallGenLimit',60);
    [a,b] = ga(@ff,t6,[],[],[],[],zeros(t6,1),ones(t6,1)*NUMC/100-0.00001,[],options);
    a = floor(a * 100 + 1);
    if b < zb
        zb = b;
        za = a;
        ZY = Y;
    end
end

ANS = zeros(length(CN),1);
for i = 1:length(CN)
    ANS(i) = za(CN(i,2));
end
ANS = [RC,ANS];

numl = sum(ZNP(:,CN1),2);    %成龙每堂人数
nums = sum(ZNP(:,CN2),2);    %狮山每堂人数

  
%% 标记考两科
l1 = length(ANS);l2 = [];n3 = 0;                                            %l2为重复位置记录,n3重复次数
tANS = table(ANS(:,1),ANS(:,3));
[~,t] = unique(tANS);
if length(t) < l1                                                          %如果有重复项
   t2 = sort(t);
   for i = 1:l1
      if i ~= t2(i-n3)
         n3 = n3 + 1;
         l2 = [l2,i];
      end
   end
   for i = 1:length(ANS)
      for j = 1:n3
         if ANS(i,1) == ANS(l2(j),1) && ANS(i,3) == ANS(l2(j),3)
            ANS(i,4) = j; 
         end
      end
   end
end

cn00 = zb;
cn33 = zb - (cn11 + cn22)/NUMC - num2; %冲突人数
cn44 = n3;                             %冲突人数(不同的计算方式)


%% 清理变量
clear ans cn1 cn2 cn3 cn4 fileID i j l1 l2 n3 s t t2 t5 t6 tRC a b average options n ans BX1 CN CN1 CN2 zy zb tANS ZNP za NUM# NUM3 RC NUMX Y
