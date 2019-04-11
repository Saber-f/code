%% 检查数据是否含有科学记数法表示的数
tic;clear;clc;
global ZNP average_c average_s zy BX1 NUMC CN1 CN2 cn11 cn22;% Y;
NUMC = [];NUMX = [];                             %NUMC为规定堂数，NUMX为校区分界限
%NUM3 = [];                                        %NUM3为不能同堂考多门的科目编号

fprintf('要求::\n1、请将原数据按校区排序(成龙在前)\n2、提取学号和科目代码两列到当前目录下的data.txt文件中\n3、记录成龙校区补考人次\n')

input('\n回车继续...');

%查科学计数法
fileID = fopen('data.txt','r');
s = fscanf(fileID,"%s");
fclose(fileID);
for i = 1:length(s)
   if s(i) == 'E' || s(i) == 'e'
      error('\n\n数据含有科学记数法，请处理后再运行！\n'); 
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
   fprintf("\n\n以下%d处数据重复(已去重)\n",n3);
   for i = 1:n3
      fprintf("%d  \n",l2(i)); 
   end
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
BX1 = zeros(max(CN(:,2)),max(CN(:,1)));
for i = 1:length(CN)
    BX1(CN(i,2),CN(i,1)) = 1;
end

%% 计算最大团
A = BX1*BX1';A = ~A;A = int8(~A);                                          %A为冲突矩阵;
for i = 1:length(A)
   A(i,i) = 0; 
end

sumA = sum(A);[~,t1] = sort(-sumA);A = A(:,t1);A = A(t1,:);sumA = sumA(t1);     %将A按每行每列按冲突程度从大到小排列

%寻找最大团（迷宫法）
cc = 1;b = A(1,:);mt = 0;  t = 1;t2 = 1;mbmcm = [];
while 1
   for i = t2:length(A)
      if b(t,i)
         t = t + 1;
         cc(t) = i;
         t2 = i + 1;
         b(t,:) = b(t-1,:)&A(i,:);         
         break;
      elseif i == length(A)  
         t2 = cc(t) + 1;
         cc(t) = [];
         t = t - 1;
         break;
      end
   end
   if t <= 0
       break
   end
   if ~sum(b(t,:))            %如果得到团
      if t > mt               %如果团更大
          mt = t;
          mbmc = cc;
          t = t - 1;
      end   
   end
end                                                       
n = length(mbmc);                                           %mbmc为所有新编号最大团
fprintf('\n\n最大团顶点数为%d,至少需要%d堂课才有可能得出无冲突的安排.\n',n,n)

%% 输入参数
fprintf('\n以下参数必须输入\n')
while isempty(NUMC)
    NUMC = input('请输入考试的堂数::');
end
while isempty(NUMX)
    NUMX = input('请输入校区分界线(成龙补考人次)::');
end


fprintf('\n\n以下参数可直接回车不输入(使用默认值)\n')
FN = input('\n请输入重复次数::');
if isempty(FN)
   FN = 10; 
   fprintf('重复寻找最优安排次数为::10\n')
end
NUM3 = input('\n请输入不能一起考的科目代码(形式为[xxx xxx xxx])::');
if isempty(NUM3)
   fprintf('没有不能一起考的科目\n')
end
O1 = input('\n请输入种群规模::');
if isempty(O1)
    O1 = 300;
    fprintf('种群规模为::300\n')
end
O2 = input('\n请输入遗传代数::');
if isempty(O2)
    O2 = 60;
    fprintf('遗传代数为::60')
end

fprintf('\n\n')

fprintf('正在求解请稍候...\n\n')

%% 分校区
CN1 = unique(CN(1:NUMX,1)');
%CN2 = unique(CN(NUMX + 1:end,1)');
j = sort(CN1);
j(length(j)+1) = 0;
k = 1;
t = 1;

num2 = length(NUM3);                           %num2为不可同堂人次
for i = 1:num2
   for j = 1:length(RC)
      if RC(j,2) == NUM3(i)  
         BX1(CN(j,2),CN(j,1)) = 2;
      end
   end
end

CN2 = zeros(1,max(CN(:,1)) - length(j));
for i = 1:max(CN(:,1))
    if(i ~= j(k))
        CN2(t) = i;
        t = t + 1;
    else
        k = k + 1;
    end
end

%% 遗传算法求最优解
average_c = NUMX/NUMC;
average_s = (length(RC) - NUMX)/NUMC;
zb = inf;
zy = inf;


for i = 1:FN
    Y = [];
    options = gaoptimset('PopulationSize',O1,'Generations',O2,'StallGenLimit',O2);
    [a,b] = ga(@ff,t6,[],[],[],[],zeros(t6,1),ones(t6,1)*NUMC/100-0.00001,[],options);
    a = floor(a * 100 + 1);
    if b < zb
        zb = b;
        za = a;
        ZY = Y;
    end
    cn33 = (zb - (cn11 + cn22)/NUMC)/10 - num2;
    fprintf('第%d次结果，冲突人数为::%d\n',i,int32(cn33))
    if cn33 == 0
       break; 
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
cn33 = (zb - (cn11 + cn22)/NUMC)/10 - num2; %冲突人数
cn44 = n3 - num2;                             %冲突人数(不同的计算方式)

format compact;

fprintf('\n\n最少冲突人次为::%d人\n',cn44)
fprintf('成龙每堂人数::')
display(numl')
fprintf('狮山每堂人数::')
display(nums')
fprintf('\n详细结果见当前目录下的result.xlsx\n')
dlmwrite('result.xlsx',ANS,'delimiter', '\t','precision','%d')

X = unique(RC(:,1));
while true
    xn = input('\n\n你想看补考最多的前多少名？(不想看？直接回车结束程序^_^)  ');
    if isempty(xn)
       break; 
    end
    fprintf('\n   学号        补考科目数    \n')
    [xb1,xb2] = sort(sum(-BX1));
    for i = 1 : xn
       fprintf('%d         %d\n',X(xb2(i)),-xb1(i)) 
    end
end



%% 清理变量
%clear ans cn1 cn2 cn3 cn4 fileID i j l1 l2 n3 s t t2 t5 t6 tRC a b average options n ans BX1 CN CN1 CN2 zy zb tANS ZNP za NUM# NUM3 RC NUMX Y

