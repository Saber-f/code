%% ��������Ƿ��п�ѧ��������ʾ����
tic;clear;clc;
global ZNP average_c average_s zy BX1 NUMC CN1 CN2 cn11 cn22;% Y;
NUMC = [];NUMX = [];                             %NUMCΪ�涨������NUMXΪУ���ֽ���
%NUM3 = [];                                        %NUM3Ϊ����ͬ�ÿ����ŵĿ�Ŀ���

fprintf('Ҫ��::\n1���뽫ԭ���ݰ�У������(������ǰ)\n2����ȡѧ�źͿ�Ŀ�������е���ǰĿ¼�µ�data.txt�ļ���\n3����¼����У�������˴�\n')

input('\n�س�����...');

%���ѧ������
fileID = fopen('data.txt','r');
s = fscanf(fileID,"%s");
fclose(fileID);
for i = 1:length(s)
   if s(i) == 'E' || s(i) == 'e'
      error('\n\n���ݺ��п�ѧ���������봦��������У�\n'); 
   end
end


%% ���룬����
RC = int64(load('data.txt')); %CΪԭʼ����

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
   fprintf("\n\n����%d�������ظ�(��ȥ��)\n",n3);
   for i = 1:n3
      fprintf("%d  \n",l2(i)); 
   end
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
BX1 = zeros(max(CN(:,2)),max(CN(:,1)));
for i = 1:length(CN)
    BX1(CN(i,2),CN(i,1)) = 1;
end

%% ���������
A = BX1*BX1';A = ~A;A = int8(~A);                                          %AΪ��ͻ����;
for i = 1:length(A)
   A(i,i) = 0; 
end

sumA = sum(A);[~,t1] = sort(-sumA);A = A(:,t1);A = A(t1,:);sumA = sumA(t1);     %��A��ÿ��ÿ�а���ͻ�̶ȴӴ�С����

%Ѱ������ţ��Թ�����
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
   if ~sum(b(t,:))            %����õ���
      if t > mt               %����Ÿ���
          mt = t;
          mbmc = cc;
          t = t - 1;
      end   
   end
end                                                       
n = length(mbmc);                                           %mbmcΪ�����±�������
fprintf('\n\n����Ŷ�����Ϊ%d,������Ҫ%d�ÿβ��п��ܵó��޳�ͻ�İ���.\n',n,n)

%% �������
fprintf('\n���²�����������\n')
while isempty(NUMC)
    NUMC = input('�����뿼�Ե�����::');
end
while isempty(NUMX)
    NUMX = input('������У���ֽ���(���������˴�)::');
end


fprintf('\n\n���²�����ֱ�ӻس�������(ʹ��Ĭ��ֵ)\n')
FN = input('\n�������ظ�����::');
if isempty(FN)
   FN = 10; 
   fprintf('�ظ�Ѱ�����Ű��Ŵ���Ϊ::10\n')
end
NUM3 = input('\n�����벻��һ�𿼵Ŀ�Ŀ����(��ʽΪ[xxx xxx xxx])::');
if isempty(NUM3)
   fprintf('û�в���һ�𿼵Ŀ�Ŀ\n')
end
O1 = input('\n��������Ⱥ��ģ::');
if isempty(O1)
    O1 = 300;
    fprintf('��Ⱥ��ģΪ::300\n')
end
O2 = input('\n�������Ŵ�����::');
if isempty(O2)
    O2 = 60;
    fprintf('�Ŵ�����Ϊ::60')
end

fprintf('\n\n')

fprintf('����������Ժ�...\n\n')

%% ��У��
CN1 = unique(CN(1:NUMX,1)');
%CN2 = unique(CN(NUMX + 1:end,1)');
j = sort(CN1);
j(length(j)+1) = 0;
k = 1;
t = 1;

num2 = length(NUM3);                           %num2Ϊ����ͬ���˴�
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

%% �Ŵ��㷨�����Ž�
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
    fprintf('��%d�ν������ͻ����Ϊ::%d\n',i,int32(cn33))
    if cn33 == 0
       break; 
    end
end

ANS = zeros(length(CN),1);
for i = 1:length(CN)
    ANS(i) = za(CN(i,2));
end
ANS = [RC,ANS];

numl = sum(ZNP(:,CN1),2);    %����ÿ������
nums = sum(ZNP(:,CN2),2);    %ʨɽÿ������

  
%% ��ǿ�����
l1 = length(ANS);l2 = [];n3 = 0;                                            %l2Ϊ�ظ�λ�ü�¼,n3�ظ�����
tANS = table(ANS(:,1),ANS(:,3));
[~,t] = unique(tANS);
if length(t) < l1                                                          %������ظ���
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
cn33 = (zb - (cn11 + cn22)/NUMC)/10 - num2; %��ͻ����
cn44 = n3 - num2;                             %��ͻ����(��ͬ�ļ��㷽ʽ)

format compact;

fprintf('\n\n���ٳ�ͻ�˴�Ϊ::%d��\n',cn44)
fprintf('����ÿ������::')
display(numl')
fprintf('ʨɽÿ������::')
display(nums')
fprintf('\n��ϸ�������ǰĿ¼�µ�result.xlsx\n')
dlmwrite('result.xlsx',ANS,'delimiter', '\t','precision','%d')

X = unique(RC(:,1));
while true
    xn = input('\n\n���뿴��������ǰ��������(���뿴��ֱ�ӻس���������^_^)  ');
    if isempty(xn)
       break; 
    end
    fprintf('\n   ѧ��        ������Ŀ��    \n')
    [xb1,xb2] = sort(sum(-BX1));
    for i = 1 : xn
       fprintf('%d         %d\n',X(xb2(i)),-xb1(i)) 
    end
end



%% �������
%clear ans cn1 cn2 cn3 cn4 fileID i j l1 l2 n3 s t t2 t5 t6 tRC a b average options n ans BX1 CN CN1 CN2 zy zb tANS ZNP za NUM# NUM3 RC NUMX Y

