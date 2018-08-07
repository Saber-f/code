clear
RC = load('allData.txt'); %原始数据

[~,s] = sort(RC(:,3));
data = RC(s,:);
priceuq = unique(data(:,3));

N = 4;  %分成N组
n = N;

A = zeros(1,N);l = length(priceuq);  %A每组价位数
for i = 1:N
    A(i) = floor(l / n);
    l = l - A(i);
    n = n - 1;
end

for i = 2:N
   A(i) = A(i-1) + A(i); 
end


j = 1;
for i = 2:length(data)
    if data(i,3) ~= data(i - 1,3)
       n = n + 1;
       if n == A(1,j)
           A(2,j) = i - 1;
          j = j + 1; 
       end
    end
end

A(2,N) = length(data);
A2 = [1,A(2,:)];

figure
%for i = 1:N
    i = 0;
    i = i + 1;
    hold on
    plot(data(A2(i):A2(i+1),2),data(A2(i):A2(i+1),1),'*y')

    i = i + 1;
    hold on
    plot(data(A2(i):A2(i+1),2),data(A2(i):A2(i+1),1),'x')

    i = i + 1;
    hold on
    plot(data(A2(i):A2(i+1),2),data(A2(i):A2(i+1),1),'o')

    i = i + 1;
    hold on
    plot(data(A2(i):A2(i+1),2),data(A2(i):A2(i+1),1),'vm')
    
%end
legend('65.0-67.0','67.5-69.5','70.0-72.0','72.5-85.0');
title('价格分布情况分布图','FontSize',16);
xlabel('经度','FontSize',12);
ylabel('纬度','FontSize',12);
legend('65.0-67.0','67.5-69.5','70.0-72.0','72.5-85.0');
text(113.7517900000,23.0206700000,'东莞市','FontSize',14);
text(113.1219200000,23.0218500000,'佛山市','FontSize',14);
text(113.2643600000,23.1290800000,'广州市','FontSize',14);
text(113.0561500000,23.6820100000,'清远市','FontSize',14);
text(114.0595600000,22.5428600000,'深圳市','FontSize',14);




