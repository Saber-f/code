%% ��������Ƿ��п�ѧ��������ʾ����
tic;clear;clc;
fileID = fopen('input_dataz.txt','r');
s = fscanf(fileID,"%s");
fclose(fileID);
for i = 1:length(s)
   if s(i) == 'E' || s(i) == 'e'
      error('���ݺ��п�ѧ���������봦��������У�'); 
   end
end


%% ���룬���أ�Ԥ��
st = 600;                                                                 %stΪ��������Ż�ʱ��
RC = int64(load('input_dataz.txt')); %CΪԭʼ����

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


%% ����D01,D01Ϊ01��������.
D01 = zeros(max(CN(:,1)),max(CN(:,2)));                                    
for i = 1:length(RC)
   D01(CN(i,1),CN(i,2)) = 1; 
end
A = D01'*D01;A = ~A;A = int8(~A);                                          %AΪ��ͻ����;
for i = 1:length(A)
   A(i,i) = 0; 
end

%% ����nop��ÿ�ƹҵ�������
nop = zeros(1,max(CN(:,2)));
t = 1;
nop(t) = 1;
for i = 2:length(RC)
   if cn3(i) ~= cn3(i-1)
      t = t+1; 
   end
   nop(t) = nop(t) + 1;
end


%% ���������
refer = 1:length(A);                                                                              %refer��¼�仯��ı��
sumA = sum(A);[~,t1] = sort(-sumA);A = A(:,t1);A = A(t1,:);refer = refer(t1);sumA = sumA(t1);     %��A��ÿ��ÿ�а���ͻ�̶ȴӴ�С����


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
end                                                        %mbmcmΪ�����±�������
mc = refer(mbmc);n = length(mc);                                           %mcΪ�����  


%% �������� 
%��������ö�
for i = 1:n 
   if mbmc(i) ~= i
       t = A(i,:);A(i,:) = A(mbmc(i),:);A(mbmc(i),:) = t;                  %������
       t = A(:,i);A(:,i) = A(:,mbmc(i));A(:,mbmc(i)) = t;                  %������
       t = refer(i);refer(i) = refer(mbmc(i));refer(mbmc(i)) = t;          %������¼
   end
end


%% �޳���ͻ��Ϊ��Ŀ�Ŀ�Լ��ټ���
n0 = 0;t = length(A);
while ~sumA(t)
    n0 = n0 + 1;
    t = t - 1;
end
A(:,length(A)-n0+1:length(A)) = [];A(length(A)-n0+1:length(A),:) = [];


%% �޳���ͻ��Ϊһ�Ŀ�Ŀ�Լ��ټ��㣨�޳���С�ڷֵ�������
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


%% ��ʼ���Թ�
pj = 1;tp = 1;tp2 = 0;tt = Inf;
avnop = sum(nop)/n;                                                        %avnopweiÿ�ÿε�ƽ������
tol = 0;                                                                   %tolΪ���̶� 
toln = 6;

%��ѭ����ʼ
while pj
   tolt = toc;                                    
   tol = tol + 0.01;  
   B = int8(zeros(length(A),n,length(A)-n+1));B(:,:,1) = A(:,1:n);           %B���ڴ���·����Ϣ
   c = zeros(length(A),1);c(1:n) = 1:n;                                    %c���ڴ��浥�η�����
   nc = 0;                                                                 %ncΪ�ɹ��Ĵ���
   cv = inf;                                                               %cv��ƽ����������������
   ncv = 0;                                                                %ncvΪ�Ľ�����
   cva = nop(mc);                                                          %cvaΪ��ʼÿ������
   maxtol = (1 + tol) * avnop;                                             %ÿ���������� 
   mintol = (1 - tol) * avnop;                                             %ÿ����������
   
   %��ѭ����ʼ
   j = n + 1;
   while 1   
       
      %Ѱ�ҿ��Խ����ŵı�Ų���¼(�ɽ������ж���һ�ǲ���ͻ������������������̫��)
      while 1
         t = 1;
         for i = c(j)+1:n + 1
            if i == n + 1
               c(j) = 0; 
               j = j - 1;
               t = 0;    
            elseif ~B(j,i,j - n)
             
               %ʹͬһ�ÿ�������Ҫ̫��
               t2 = nop(refer(j));                                           
               for k = 1:j-1
                  if c(k) == i
                     t2 = t2 +  nop(refer(k));
                  end
               end
               if t2 < maxtol
                
                  %ʹÿ�ÿ���������̫�� 
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
                  %ʹÿ�ÿ���������̫�� 
               
               end
               %ʹͬһ�ÿ�������Ҫ̫��
            
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
      
      %��ȫͨ��
      if j <= n                                                               
         break;
      end
      B(:,:,j - n +1) = B(:,:,j - n);
      B(:,c(j),j - n + 1) = B(:,c(j),j - n) + A(:,j);
      B(:,c(j),j - n + 1) = ~B(:,c(j),j - n + 1); B(:,c(j),j - n + 1) = ~B(:,c(j),j - n + 1);     %����0Ϊ1

      %�ж��ϴε�ѡ���Ƿ�������·����
      np = 0;                                                                                     %np��ʾ�Ƿ���·����
      t = sum(B(j:end,:,j - n + 1),2);
      for i = 1:length(A)-j
          if t(i) == n
              np = 1;
              break;
          end    
      end

      if ~np                                                               %�����·����
         j = j + 1;
      end
   
      if j == length(A) + 1                                                %����ͨ��
          if tp                                                            %֪ͨ���ҵ������������Ż�
             tt = toc;
             fprintf("\n���ҵ���������ʱ��%.2fs\n�����Ż�ʹ����ƽ�������Ժ�...\nע���Ż�ʱ�䳬��%ds���Զ�����\n\n",tt,st);
             tp = 0;      
          end
          nc = nc + 1;
          j = j - 1;
          cvat = cva;
          for i = n+1:length(A)
             cvat(c(i)) = cvat(c(i)) + nop(refer(i));
          end 
          mcvat = max(abs(cvat - avnop));
          if cv > mcvat                                                    %�����������
             cv = mcvat;                                             
             C = c; 
             ncv = ncv + 1;
             jcvat = cvat;                                                 %jcvatΪ���շ���ÿ�ÿεĿ�������
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


%% ���䱻�޳��ĳ�ͻ��Ϊһ�Ŀ�Ŀ
for i = length(A)+1:length(A) + n1
    [~,t] = min(jcvat);
    [~,t2] = max(A1(i,:));                                                 %��ȡΨһ��ͻ���
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



%% ���䱻�޳��ĳ�ͻ��Ϊ��Ŀ�Ŀ
for i = length(A1)+1:length(A1) + n0
    [~,t] = min(jcvat);
    C = [C;t];
    jcvat(t) = jcvat(t) + nop(refer(i));    
end



%% ����������Գ���

%�����refer2������
[~,refer2] = sort(refer);
 
%���һ˵��������Ŀ���룬�ڼ��ÿ�,�ÿƹҿ�����,���ÿ�������
t = unique(cn3);
ans1 = [t,C(refer2),nop(1:length(refer))',jcvat(C(refer2))'];

%�����˵������ѧ�ţ���Ŀ���룬�ڼ��ÿ�
ans2 = [RC,C(refer2(CN(:,2)))];

%�����˵������ѧ�ţ����ÿ������ݣ���ͬѧ���ؿ���Ŀ��
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

%�������
if tp2
   fprintf("�Ż�ʱ�䳬��%ds,�Զ�����,����ʱ%.2fs\n\n",st,toc);
else
   fprintf("�Ż���ɣ�����ʱ��%.2f\n\n",toc); 
end