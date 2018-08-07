%% 检查数据是否含有科学记数法表示的数
tic;clear;clc;
fileID = fopen('input_dataz.txt','r');
s = fscanf(fileID,"%s");
fclose(fileID);
for i = 1:length(s)
   if s(i) == 'E' || s(i) == 'e'
      error('数据含有科学记数法，请处理后再运行！'); 
   end
end


%% 载入，查重，预设
st = 600;                                                                 %st为最大允许优化时间
RC = int64(load('input_dataz.txt')); %C为原始数据

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


%% 生成D01,D01为01描述矩阵.
D01 = zeros(max(CN(:,1)),max(CN(:,2)));                                    
for i = 1:length(RC)
   D01(CN(i,1),CN(i,2)) = 1; 
end
A = D01'*D01;A = ~A;A = int8(~A);                                          %A为冲突矩阵;
for i = 1:length(A)
   A(i,i) = 0; 
end

%% 计算nop（每科挂的人数）
nop = zeros(1,max(CN(:,2)));
t = 1;
nop(t) = 1;
for i = 2:length(RC)
   if cn3(i) ~= cn3(i-1)
      t = t+1; 
   end
   nop(t) = nop(t) + 1;
end


%% 计算最大团
refer = 1:length(A);                                                                              %refer记录变化后的编号
sumA = sum(A);[~,t1] = sort(-sumA);A = A(:,t1);A = A(t1,:);refer = refer(t1);sumA = sumA(t1);     %将A按每行每列按冲突程度从大到小排列


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
end                                                        %mbmcm为所有新编号最大团
mc = refer(mbmc);n = length(mc);                                           %mc为最大团  


%% 初步处理 
%将最大团置顶
for i = 1:n 
   if mbmc(i) ~= i
       t = A(i,:);A(i,:) = A(mbmc(i),:);A(mbmc(i),:) = t;                  %交换行
       t = A(:,i);A(:,i) = A(:,mbmc(i));A(:,mbmc(i)) = t;                  %交换列
       t = refer(i);refer(i) = refer(mbmc(i));refer(mbmc(i)) = t;          %交换记录
   end
end


%% 剔除冲突度为零的科目以减少计算
n0 = 0;t = length(A);
while ~sumA(t)
    n0 = n0 + 1;
    t = t - 1;
end
A(:,length(A)-n0+1:length(A)) = [];A(length(A)-n0+1:length(A),:) = [];


%% 剔除冲突度为一的科目以减少计算（剔除数小于分的堂数）
n1 = 0;t = length(A);
for i = 2:n
    if sumA(t) == 1
       n1 = n1 + 1;
       t = t - 1;
    else
        break;
    end
end
A1 = A;
A(:,length(A)-n1+1:length(A)) = [];A(length(A)-n1+1:length(A),:) = [];


%% 开始走迷宫
pj = 1;tp = 1;tp2 = 0;tt = Inf;
avnop = sum(nop)/n;                                                        %avnopwei每堂课的平均人数
tol = 0;                                                                   %tol为容忍度 
toln = 6;

%大循环开始
while pj
   tolt = toc;                                    
   tol = tol + 0.01;  
   B = int8(zeros(length(A),n,length(A)-n+1));B(:,:,1) = A(:,1:n);           %B用于储存路口信息
   c = zeros(length(A),1);c(1:n) = 1:n;                                    %c用于储存单次分配结果
   nc = 0;                                                                 %nc为成功的次数
   cv = inf;                                                               %cv与平均人数相差最大人数
   ncv = 0;                                                                %ncv为改进次数
   cva = nop(mc);                                                          %cva为初始每堂人数
   maxtol = (1 + tol) * avnop;                                             %每堂人数上限 
   mintol = (1 - tol) * avnop;                                             %每堂人数下限
   
   %次循环开始
   j = n + 1;
   while 1   
       
      %寻找可以进的门的编号并记录(可进条件有二，一是不冲突，二是组内人数不能太多)
      while 1
         t = 1;
         for i = c(j)+1:n + 1
            if i == n + 1
               c(j) = 0; 
               j = j - 1;
               t = 0;    
            elseif ~B(j,i,j - n)
             
               %使同一堂课人数不要太多
               t2 = nop(refer(j));                                           
               for k = 1:j-1
                  if c(k) == i
                     t2 = t2 +  nop(refer(k));
                  end
               end
               if t2 < maxtol
                
                  %使每堂课人数不能太少 
                  mip = nop(mc);   
                  for k = n+1:j-1
                     mip(c(k)) = mip(c(k)) + nop(refer(k)); 
                  end
                  mip(i) = mip(i) + nop(refer(j));
                  if j < 42   
                     mip = mip + (sum(~B(j+1:end,:,j-n)'.*nop(refer(j+1:length(A))),2))';
                  end 
                  if min(mip) > mintol                 
                     c(j) = i;
                     break;
                  end 
                  %使每堂课人数不能太少 
               
               end
               %使同一堂课人数不要太多
            
            elseif i == n
               c(j) = 0; 
               j = j - 1;
               t = 0;
               break;
            end    
         end
         if t
             break;
         end
      
         if j < n
             break
         end
      end
      
      %完全通关
      if j <= n                                                               
         break;
      end
      B(:,:,j - n +1) = B(:,:,j - n);
      B(:,c(j),j - n + 1) = B(:,c(j),j - n) + A(:,j);
      B(:,c(j),j - n + 1) = ~B(:,c(j),j - n + 1); B(:,c(j),j - n + 1) = ~B(:,c(j),j - n + 1);     %化非0为1

      %判断上次的选择是否会造成无路可走
      np = 0;                                                                                     %np表示是否无路可走
      t = sum(B(j:end,:,j - n + 1),2);
      for i = 1:length(A)-j
          if t(i) == n
              np = 1;
              break;
          end    
      end

      if ~np                                                               %如果有路可走
         j = j + 1;
      end
   
      if j == length(A) + 1                                                %侠义通关
          if tp                                                            %通知已找到方案，正在优化
             tt = toc;
             fprintf("\n已找到方案，用时：%.2fs\n正在优化使人数平均，请稍候...\n注：优化时间超过%ds将自动结束\n\n",tt,st);
             tp = 0;      
          end
          nc = nc + 1;
          j = j - 1;
          cvat = cva;
          for i = n+1:length(A)
             cvat(c(i)) = cvat(c(i)) + nop(refer(i));
          end 
          mcvat = max(abs(cvat - avnop));
          if cv > mcvat                                                    %如果方案更优
             cv = mcvat;                                             
             C = c; 
             ncv = ncv + 1;
             jcvat = cvat;                                                 %jcvat为最终方案每堂课的考试人数
          end
          if toc-tt > st 
             tp2 = 1;
             break;
          end
      end
      if tp2
          break;
      end  
      if toc - tolt > toln       
          toln = toln + 0.2;
          break;
      end
   end
   if ncv ~= 0
      pj = 0; 
   end
   if tp2
       break;
   end
end


%% 分配被剔除的冲突度为一的科目
for i = length(A)+1:length(A) + n1
    [~,t] = min(jcvat);
    [~,t2] = max(A1(i,:));                                                 %获取唯一冲突编号
    if t2 > length(A)
       C = [C;t];
    else
        if t ~= C(t2)
           C = [C;t];   
        else
            t3 = jcvat;
            t3(t) = inf;
            [~,t] = min(jcvat);
            C = [C;t];
        end
    end
    jcvat(t) = jcvat(t) + nop(refer(i));    
end



%% 分配被剔除的冲突度为零的科目
for i = length(A1)+1:length(A1) + n0
    [~,t] = min(jcvat);
    C = [C;t];
    jcvat(t) = jcvat(t) + nop(refer(i));    
end



%% 处理分配结果以呈现

%神奇的refer2！酱！
[~,refer2] = sort(refer);
 
%结果一说明——科目代码，第几堂考,该科挂科人数,该堂课人数，
t = unique(cn3);
ans1 = [t,C(refer2),nop(1:length(refer))',jcvat(C(refer2))'];

%结果二说明——学号，科目代码，第几堂考
ans2 = [RC,C(refer2(CN(:,2)))];

%结果三说明——学号，该堂考试内容，该同学需重考科目数
URC1 = unique(RC(:,1));
ans3 = [0;URC1];
ans3 = [ans3,zeros(length(URC1)+1,length(mc))];
ans3(1,2:length(mc)+1) = 1:length(mc);
for i = 1:length(RC)
   ans3(CN(i,1)+1,C(refer2(CN(i,2)))+1) = RC(i,2); 
end
t = ans3(2:end,2:end);t = ~t;t = ~t;t1 = sum(t);t2 = sum(t,2);
ans3(length(URC1)+2,2:length(mc)+1) = t1;
ans3(2:length(URC1) + 1,length(mc)+2) = t2;

%最后的最后
if tp2
   fprintf("优化时间超过%ds,自动结束,总用时%.2fs\n\n",st,toc);
else
   fprintf("优化完成，总用时：%.2f\n\n",toc); 
end