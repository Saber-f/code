%% ��������Ƿ��п�ѧ��������ʾ����
tic;clear;clc;
NUMC = 8;
%NUM3 = [71001,71004,151010,171002];                                        %NUM3Ϊ����ͬ�ÿ����ŵĿ�Ŀ���
NUM3 = [];
fileID = fopen('input_datagj.txt','r');
s = fscanf(fileID,"%s");
fclose(fileID);
for i = 1:length(s)
   if s(i) == 'E' || s(i) == 'e'
      error('���ݺ��п�ѧ���������봦��������У�'); 
   end
end


%% ���룬����
RC = int64(load('input_datagj.txt')); %CΪԭʼ����

%����
l1 = length(RC);l2 = [];n3 = 0;                                            %l2Ϊ�ظ�λ�ü�¼,n3�ظ�����
tRC = table(RC(:,1),RC(:,2));
[~,t] = unique(tRC);
if length(t) < l1                                                          %������ظ���
   t2 = sort(t);
   RC = RC(t2,:);
   for i = 1:l1
      if i ~= t2(i-n3)
         n3 = n3 + 1;
         l2 = [l2,i];
      end
   end
   fprintf("����%d�������ظ�(��ȥ��)\n",n3);
   for i = 1:n3
      fprintf("%d  ",l2(i)); 
   end
   fprintf("\n");
end

CN = zeros(length(RC),2);                                                  %CNΪ�������  



%% �����
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



%% ���ɿ�Ŀ���xѧ�ž���
BX1 = zeros(max(CN(:,2)),max(CN(:,1)));num2 = 0;                           %num2Ϊ����ͬ���˴�
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

%% ����Ŀ���ҿ������������еõ�BX2
[~,s1] = sort(sum(BX1,2));
[~,s2] = sort(s1);
BX2 = BX1(s1,:);
BX1 = BX2;



%% ����
result = zeros(1,length(s2));mark = 0;record2 = zeros(1,NUMC);numpeop = inf; %numpeopΪ��ͻ����
record = zeros(length(s2)+1,length(BX2),NUMC);                               %record��¼ÿ�εĳ�ͻ���
respeop = zeros(NUMC,length(BX2));sus1 = 0;sus2 = 0;                         %���ͻ�����й�
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

    %�����жϳ�ͻ����
    for i = 1 : NUMC
        respeop(i,:) = record(record2(i)+1,:,i);
    end
    numpeop2 = sum(sum(respeop,2) - sum(~(~respeop),2)) - num2;
    
    if max(record(record2(result(mark))+1,:,result(mark))) > 2 || numpeop2 > 10
        record2(result(mark)) = record2(result(mark)) - 1;
        mark = mark - 1;   
    end
    
    if mark >= length(result)                                              %����������
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
%% ��������
clear cn1 cn2 cn3 cn4 fileID i j l1 l2 n3 s t t5 t6 tRC mark ans